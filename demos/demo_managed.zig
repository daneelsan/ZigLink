const wl = @import("WolframLibrary");
const std = @import("std");

var arena: std.heap.ArenaAllocator = undefined;
var map: std.AutoArrayHashMap(wl.mint, *wl.MTensor) = undefined;

fn manageInstance(libData: wl.WolframLibraryData, mode: wl.mbool, id: wl.mint) callconv(.C) void {
    if (mode == 0) {
        const lcg_ptr = arena.allocator().create(wl.MTensor) catch unreachable;
        lcg_ptr.* = null;
        map.put(id, lcg_ptr) catch unreachable;
        //std.debug.print("Create {}\n", .{id});
    } else {
        const lcg_ptr = map.get(id);
        if (lcg_ptr) |ptr| {
            if (ptr.* != null) {
                libData.MTensor_free(ptr.*);
            }
            arena.allocator().destroy(ptr);
            _ = map.orderedRemove(id);
        }
        //std.debug.print("Destroy {}\n", .{id});
    }
}

export fn WolframLibrary_initialize(libData: wl.WolframLibraryData) c_int {
    arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    map = std.AutoArrayHashMap(wl.mint, *wl.MTensor).init(arena.allocator());
    return libData.registerLibraryExpressionManager("LCG", manageInstance);
}

export fn WolframLibrary_uninitialize(libData: wl.WolframLibraryData) void {
    _ = libData.unregisterLibraryExpressionManager("LCG");
    map.deinit();
    arena.deinit();
}

export fn WolframLibrary_getVersion() wl.mint {
    return wl.WolframLibraryVersion;
}

export fn releaseInstance(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    _ = Res;
    if (Argc != 1) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const id = wl.MArgument_getInteger(Args[0]);
    return libData.releaseManagedLibraryExpression("LCG", id);
}

export fn setInstanceState(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    _ = Res;
    if (Argc != 2) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const id = wl.MArgument_getInteger(Args[0]);
    var lcg_ptr = map.get(id);
    if (lcg_ptr == null) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const tensor_in = wl.MArgument_getMTensor(Args[1]);
    if (libData.MTensor_getType(tensor_in) != wl.MType_Integer) {
        return wl.LIBRARY_TYPE_ERROR;
    }
    if (libData.MTensor_getRank(tensor_in) != 1) {
        return wl.LIBRARY_RANK_ERROR;
    }
    if (libData.MTensor_getDimensions(tensor_in)[0] != 4) {
        return wl.LIBRARY_DIMENSION_ERROR;
    }

    return libData.MTensor_clone(tensor_in, lcg_ptr.?);
}

export fn getInstanceState(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    if (Argc != 1) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const id = wl.MArgument_getInteger(Args[0]);
    const lcg_ptr = map.get(id);
    if (lcg_ptr == null) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    var tensor_res: wl.MTensor = null;
    const err = libData.MTensor_clone(lcg_ptr.?.*, &tensor_res);
    if (err == wl.LIBRARY_NO_ERROR) {
        wl.MArgument_setMTensor(Res, tensor_res);
    }
    return err;
}

export fn generateFromInstance(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    if (Argc != 2) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const id = wl.MArgument_getInteger(Args[0]);
    const lcg_ptr = map.get(id);
    if (lcg_ptr == null) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    var lcg_data = libData.MTensor_getIntegerData(lcg_ptr.?.*);
    const a = lcg_data[0];
    const c = lcg_data[1];
    const m = lcg_data[2];
    var x = lcg_data[3];

    const res_dims = wl.MArgument_getMTensor(Args[1]);
    if (libData.MTensor_getType(res_dims) != wl.MType_Integer) {
        return wl.LIBRARY_TYPE_ERROR;
    }
    if (libData.MTensor_getRank(res_dims) != 1) {
        return wl.LIBRARY_RANK_ERROR;
    }

    const rank = libData.MTensor_getFlattenedLength(res_dims);
    const dims = libData.MTensor_getIntegerData(res_dims);
    var tensor_res: wl.MTensor = null;
    const err = libData.MTensor_new(wl.MType_Real, rank, dims, &tensor_res);
    if (err != wl.LIBRARY_NO_ERROR) {
        return err;
    }

    const tensor_len = libData.MTensor_getFlattenedLength(tensor_res);
    const tensor_data = libData.MTensor_getRealData(tensor_res);
    for (tensor_data[0..@intCast(usize, tensor_len)]) |*real| {
        x = @rem(a * x + c, m);
        real.* = @intToFloat(wl.mreal, x) / @intToFloat(wl.mreal, m);
    }

    lcg_data[3] = x;
    wl.MArgument_setMTensor(Res, tensor_res);
    return wl.LIBRARY_NO_ERROR;
}

export fn getAllInstanceIDs(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    _ = Args;
    if (Argc != 0) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    var tensor_res: wl.MTensor = null;
    const tensor_dims = [_]wl.mint{@intCast(wl.mint, map.count())};
    const err = libData.MTensor_new(wl.MType_Integer, 1, &tensor_dims, &tensor_res);
    if (err != wl.LIBRARY_NO_ERROR) {
        return err;
    }

    var tensor_data = libData.MTensor_getIntegerData(tensor_res);
    for (map.keys()) |k, i| {
        tensor_data[i] = k;
    }

    wl.MArgument_setMTensor(Res, tensor_res);
    return wl.LIBRARY_NO_ERROR;
}
