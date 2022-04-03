const wl = @import("WolframLibrary");
const wl_na = @import("WolframNumericArrayLibrary");
const std = @import("std");

export fn WolframLibrary_getVersion() wl.mint {
    return wl.WolframLibraryVersion;
}

export fn WolframLibrary_initialize(libData: wl.WolframLibraryData) c_int {
    _ = libData;
    return wl.LIBRARY_NO_ERROR;
}

export fn WolframLibrary_uninitialize(libData: wl.WolframLibraryData) void {
    _ = libData;
    return;
}

fn NumericArrayType(na_type: wl_na.MNumericArray_Data_Type) type {
    return switch (na_type) {
        .MNumericArray_Type_Undef => unreachable,
        .MNumericArray_Type_Bit8 => i8,
        .MNumericArray_Type_UBit8 => u8,
        .MNumericArray_Type_Bit16 => i16,
        .MNumericArray_Type_UBit16 => u16,
        .MNumericArray_Type_Bit32 => i32,
        .MNumericArray_Type_UBit32 => u32,
        .MNumericArray_Type_Bit64 => i64,
        .MNumericArray_Type_UBit64 => u64,
        .MNumericArray_Type_Real32 => f32,
        .MNumericArray_Type_Real64 => f64,
        .MNumericArray_Type_Complex_Real32 => std.math.Complex(f32),
        .MNumericArray_Type_Complex_Real64 => std.math.Complex(f64),
        .MNumericArray_Type_Real16 => f16,
        .MNumericArray_Type_Complex_Real16 => std.math.Complex(f16),
    };
}

fn tplNumericArrayReverse(
    comptime T: type,
    out_ptr: *anyopaque,
    in_ptr: *anyopaque,
    len0: wl.mint,
) void {
    const len = @intCast(usize, len0);
    var out_slice = @ptrCast([*]T, @alignCast(@alignOf(T), out_ptr))[0..len];
    var in_slice = @ptrCast([*]T, @alignCast(@alignOf(T), in_ptr))[0..len];

    for (in_slice) |elem, i| {
        out_slice[len - i - 1] = elem;
    }
}

/// Reverses elements in a one-dimensional NumericArray
export fn numericArrayReverse(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    if (Argc != 1) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    const naFuns: wl_na.WolframNumericArrayLibrary_Functions = libData.numericarrayLibraryFunctions.?;

    const na_in = wl.MArgument_getMNumericArray(Args[0]);

    const rank = naFuns.MNumericArray_getRank(na_in);
    if (rank != 1) {
        return wl.LIBRARY_RANK_ERROR;
    }

    const na_type = naFuns.MNumericArray_getType(na_in);
    if (na_type == wl_na.MNumericArray_Type_Undef) {
        return wl.LIBRARY_TYPE_ERROR;
    }

    const length = naFuns.MNumericArray_getFlattenedLength(na_in);

    var na_out: wl.MNumericArray = null;
    const err = naFuns.MNumericArray_clone(na_in, &na_out);
    if (err != wl.LIBRARY_NO_ERROR) {
        return err;
    }

    var data_in = naFuns.MNumericArray_getData(na_in);
    var data_out = naFuns.MNumericArray_getData(na_out);
    if (data_in == null or data_out == null) {
        naFuns.MNumericArray_free(na_out);
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    inline for (@typeInfo(wl_na.MNumericArray_Data_Type).Enum.fields) |field| {
        const tag = @intToEnum(wl_na.MNumericArray_Data_Type, field.value);
        if (tag == wl_na.MNumericArray_Type_Undef) {
            continue;
        }
        if (na_type == tag) {
            const T = NumericArrayType(tag);
            tplNumericArrayReverse(T, data_out.?, data_in.?, length);
        }
    }

    wl.MArgument_setMNumericArray(Res, na_out);
    return wl.LIBRARY_NO_ERROR;
}

fn tplNumericArrayComplexConjugate(
    comptime T: type,
    in_out_ptr: *anyopaque,
    len0: wl.mint,
) void {
    const len = @intCast(usize, len0);
    var in_out_slice = @ptrCast([*]T, @alignCast(@alignOf(T), in_out_ptr))[0..len];

    for (in_out_slice) |*elem| {
        elem.* = elem.*.conjugate();
    }
}

/// Computes the complex conjugate of each element in a NumericArray.
/// NumericArrays of non-complex types are converted to MNumericArray_Type_Complex_Real64.
export fn numericArrayComplexConjugate(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    if (Argc != 1) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    var err = wl.LIBRARY_NO_ERROR;

    const naFuns: wl_na.WolframNumericArrayLibrary_Functions = libData.numericarrayLibraryFunctions.?;

    const na_in = wl.MArgument_getMNumericArray(Args[0]);

    const na_type = naFuns.MNumericArray_getType(na_in);

    var na_out: wl.MNumericArray = null;

    if (na_type != wl_na.MNumericArray_Type_Complex_Real32 and na_type != wl_na.MNumericArray_Type_Complex_Real64) {
        err = naFuns.MNumericArray_convertType(
            &na_out,
            na_in,
            wl_na.MNumericArray_Type_Complex_Real64,
            wl_na.MNumericArray_Convert_Coerce,
            0,
        );
        if (err != wl.LIBRARY_NO_ERROR) {
            return err;
        }
    } else {
        err = naFuns.MNumericArray_clone(na_in, &na_out);
        if (err != wl.LIBRARY_NO_ERROR) {
            return err;
        }

        const data_out = naFuns.MNumericArray_getData(na_out);
        if (data_out == null) {
            naFuns.MNumericArray_free(na_out);
            return err;
        }

        const length = naFuns.MNumericArray_getFlattenedLength(na_out);
        switch (na_type) {
            .MNumericArray_Type_Complex_Real32 => {
                tplNumericArrayComplexConjugate(std.math.Complex(f32), data_out.?, length);
            },
            .MNumericArray_Type_Complex_Real64 => {
                tplNumericArrayComplexConjugate(std.math.Complex(f64), data_out.?, length);
            },
            else => unreachable,
        }
    }

    wl.MArgument_setMNumericArray(Res, na_out);
    return wl.LIBRARY_NO_ERROR;
}

fn readAllBytes(absolute_path_c: [*:0]const u8, allocator: std.mem.Allocator) ![]u8 {
    const file = try std.fs.openFileAbsoluteZ(absolute_path_c, .{ .read = true });
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    return try in_stream.readAllAlloc(allocator, std.math.maxInt(usize));
}

// /* Reads data from a file and returns it as a ByteArray */
// EXTERN_C DLLEXPORT int readBytesFromFile(WolframLibraryData libData, mint Argc, MArgument *Args, MArgument res) {
export fn readBytesFromFile(
    libData: wl.WolframLibraryData,
    Argc: wl.mint,
    Args: [*]wl.MArgument,
    Res: wl.MArgument,
) c_int {
    if (Argc != 1) {
        return wl.LIBRARY_FUNCTION_ERROR;
    }

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const naFuns = libData.numericarrayLibraryFunctions.?;

    const filename = wl.MArgument_getUTF8String(Args[0]);
    defer libData.UTF8String_disown(filename);

    const bytes = readAllBytes(filename, allocator) catch return wl.LIBRARY_FUNCTION_ERROR;

    const dims: [1]wl.mint = .{@intCast(isize, bytes.len)};
    var byte_array: wl.MNumericArray = null;
    var err = naFuns.MNumericArray_new(.MNumericArray_Type_UBit8, 1, &dims, &byte_array);
    if (err != wl.LIBRARY_NO_ERROR) {
        return err;
    }

    const byte_array_data = naFuns.MNumericArray_getData(byte_array);
    const byte_array_ptr = @ptrCast([*]u8, @alignCast(@alignOf(u8), byte_array_data));

    std.mem.copy(u8, byte_array_ptr[0..bytes.len], bytes);
    wl.MArgument_setMNumericArray(Res, byte_array);

    return wl.LIBRARY_NO_ERROR;
}
