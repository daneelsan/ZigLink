const wl = @import("WolframLibrary");
const wstp = @import("WolframSymbolicTransferProtocol");

const std = @import("std");

var arena: std.heap.ArenaAllocator = undefined;

export fn WolframLibrary_getVersion() wl.mint {
    return wl.WolframLibraryVersion;
}

export fn WolframLibrary_initialize(libData: wl.WolframLibraryData) c_int {
    _ = libData;
    arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    return wl.LIBRARY_NO_ERROR;
}

export fn WolframLibrary_uninitialize(libData: wl.WolframLibraryData) void {
    _ = libData;
    arena.deinit();
}

fn addtwoImpl(x: c_int, y: c_int) c_int {
    return x + y;
}

export fn addtwo(libData: wl.WolframLibraryData, wsp: wstp.WSLINK) c_int {
    _ = libData;

    var n1: c_int = undefined;
    var n2: c_int = undefined;
    var len: c_int = undefined;

    if (wstp.WSTestHead(wsp, "List", &len) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;
    if (len != 2)
        return wl.LIBRARY_FUNCTION_ERROR;

    if (wstp.WSGetInteger(wsp, &n1) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;
    if (wstp.WSGetInteger(wsp, &n2) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;
    if (wstp.WSNewPacket(wsp) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;

    const sum = addtwoImpl(n1, n2);

    if (wstp.WSPutInteger(wsp, sum) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;

    return wl.LIBRARY_NO_ERROR;
}

fn strlen(ptr: [*:0]u8) usize {
    var i: usize = 0;
    while (ptr[i] != 0) {
        i += 1;
    }
    return i;
}

fn reverseStringImpl(inStr: [:0]const u8, outStr: [:0]u8) void {
    const len = inStr.len;
    for (outStr) |*c, i| {
        c.* = inStr[len - i - 1];
    }
}

export fn reverseString(libData: wl.WolframLibraryData, wsp: wstp.WSLINK) c_int {
    _ = libData;

    var argsCount: c_int = undefined;
    var inStr: [:0]u8 = undefined;

    if (wstp.WSTestHead(wsp, "List", &argsCount) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;
    if (argsCount != 1)
        return wl.LIBRARY_FUNCTION_ERROR;

    if (wstp.WSGetString(wsp, &inStr.ptr) == 0)
        return wl.LIBRARY_FUNCTION_ERROR;

    inStr.len = strlen(inStr.ptr);

    if (wstp.WSNewPacket(wsp) == 0) {
        wstp.WSReleaseString(wsp, inStr.ptr);
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const allocator = arena.allocator();

    var outStr = allocator.allocSentinel(u8, inStr.len, 0) catch {
        wstp.WSReleaseString(wsp, inStr.ptr);
        return wl.LIBRARY_FUNCTION_ERROR;
    };

    reverseStringImpl(inStr, outStr);

    if (wstp.WSPutString(wsp, outStr) == 0) {
        wstp.WSReleaseString(wsp, inStr.ptr);
        allocator.free(outStr);
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    return wl.LIBRARY_NO_ERROR;
}
