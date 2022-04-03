//! This is not a finished package.

const wl = @import("WolframLibrary.zig");
const wl_na = @import("WolframNumericArrayLibrary.zig");
const std = @import("std");

const WolframNumericArrayLibraryFunctions = wl_na.WolframNumericArrayLibrary_Functions;

/// FromNumericArrayDataType(data_type) returns the type T associated to the MNumericArray_Data_Type enum value data_type.
/// E.g. FromNumericArrayDataType(.MNumericArray_Type_UBit16) gives u16.
pub fn FromNumericArrayDataType(data_type: wl_na.MNumericArray_Data_Type) type {
    return switch (data_type) {
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

/// toNumericArrayDataType(T) returns the MNumericArray_Data_Type enum value associated to the type T.
/// E.g. toNumericArrayDataType(u16) gives .MNumericArray_Type_UBit16.
pub fn toNumericArrayDataType(comptime T: type) NumericArrayError!wl_na.MNumericArray_Data_Type {
    return switch (T) {
        i8 => .MNumericArray_Type_Bit8,
        u8 => .MNumericArray_Type_UBit8,
        i16 => .MNumericArray_Type_Bit16,
        u16 => .MNumericArray_Type_UBit16,
        i32 => .MNumericArray_Type_Bit32,
        u32 => .MNumericArray_Type_UBit32,
        i64 => .MNumericArray_Type_Bit64,
        u64 => .MNumericArray_Type_UBit64,
        f16 => .MNumericArray_Type_Real16,
        f32 => .MNumericArray_Type_Real32,
        f64 => .MNumericArray_Type_Real64,
        std.math.Complex(f16) => .MNumericArray_Type_Complex_Real16,
        std.math.Complex(f32) => .MNumericArray_Type_Complex_Real32,
        std.math.Complex(f64) => .MNumericArray_Type_Complex_Real64,
        else => .InvalidType,
    };
}

pub const NumericArrayError = error{
    InvalidType,
};

pub fn NumericArray(comptime T: type) type {
    return struct {
        const Self = @This();
        mnumeric_array: wl.MNumericArray,

        pub fn fromMNumericArray(mnumeric_array: wl.MNumericArray) Self {
            return .{
                .mnumeric_array = mnumeric_array,
            };
        }

        pub fn new(dims: []const usize) NumericArrayError!Self {
            const data_type = try toNumericArrayDataType(T);
            var mnumeric_array_ptr: *wl.MNumericArray = undefined;
            const error_code = WolframNumericArrayLibraryFunctions.MNumericArray_new(
                data_type,
                @intCast(wl.mint, dims.len),
                @ptrCast([*]const wl.mint, dims.ptr),
                mnumeric_array_ptr,
            );
            // switch on error_code
            return .{
                .mnumeric_array = mnumeric_array_ptr.*,
            };
        }

        pub fn free(self: *Self) void {
            WolframNumericArrayLibraryFunctions.MNumericArray_free(self.mnumeric_array);
        }

        pub fn getFlattenedLength(self: Self) usize {
            const c_length = WolframNumericArrayLibraryFunctions.MNumericArray_getFlattenedLength(self.mnumeric_array);
            return @intCast(usize, c_length);
        }

        pub fn getRank(self: Self) usize {
            const c_rank = WolframNumericArrayLibraryFunctions.MNumericArray_getRank(self.mnumeric_array);
            return @intCast(usize, c_rank);
        }

        pub fn getDimensions(self: Self) []const usize {
            const c_dims = WolframNumericArrayLibraryFunctions.MNumericArray_getDimensions(self.mnumeric_array);
            return @ptrCast([*]const usize, c_dims)[0..self.getFlattenedLength()];
        }

        pub fn getSlice(self: Self) []T {
            const data = WolframNumericArrayLibraryFunctions.MNumericArray_getData(self.mnumeric_array);
            return @ptrCast([*]T, @alignCast(@alignOf(T), data))[0..self.getFlattenedLength()];
        }
    };
}
