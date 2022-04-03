const wl = @import("WolframLibrary.zig");

// enum MNumericArray_Data_Type
// {
// 	MNumericArray_Type_Undef = 0,
// 	MNumericArray_Type_Bit8 = 1,
// 	MNumericArray_Type_UBit8,
// 	MNumericArray_Type_Bit16,
// 	MNumericArray_Type_UBit16,
// 	MNumericArray_Type_Bit32,
// 	MNumericArray_Type_UBit32,
// 	MNumericArray_Type_Bit64,
// 	MNumericArray_Type_UBit64,
// 	MNumericArray_Type_Real32,
// 	MNumericArray_Type_Real64,
// 	MNumericArray_Type_Complex_Real32,
// 	MNumericArray_Type_Complex_Real64,
// 	MNumericArray_Type_Real16,
// 	MNumericArray_Type_Complex_Real16,
// };
pub const MNumericArray_Data_Type = enum(c_int) {
    MNumericArray_Type_Undef,
    MNumericArray_Type_Bit8,
    MNumericArray_Type_UBit8,
    MNumericArray_Type_Bit16,
    MNumericArray_Type_UBit16,
    MNumericArray_Type_Bit32,
    MNumericArray_Type_UBit32,
    MNumericArray_Type_Bit64,
    MNumericArray_Type_UBit64,
    MNumericArray_Type_Real32,
    MNumericArray_Type_Real64,
    MNumericArray_Type_Complex_Real32,
    MNumericArray_Type_Complex_Real64,
    MNumericArray_Type_Real16,
    MNumericArray_Type_Complex_Real16,
};
pub const MNumericArray_Type_Undef = MNumericArray_Data_Type.MNumericArray_Type_Undef;
pub const MNumericArray_Type_Bit8 = MNumericArray_Data_Type.MNumericArray_Type_Bit8;
pub const MNumericArray_Type_UBit8 = MNumericArray_Data_Type.MNumericArray_Type_UBit8;
pub const MNumericArray_Type_Bit16 = MNumericArray_Data_Type.MNumericArray_Type_Bit16;
pub const MNumericArray_Type_UBit16 = MNumericArray_Data_Type.MNumericArray_Type_UBit16;
pub const MNumericArray_Type_Bit32 = MNumericArray_Data_Type.MNumericArray_Type_Bit32;
pub const MNumericArray_Type_UBit32 = MNumericArray_Data_Type.MNumericArray_Type_UBit32;
pub const MNumericArray_Type_Bit64 = MNumericArray_Data_Type.MNumericArray_Type_Bit64;
pub const MNumericArray_Type_UBit64 = MNumericArray_Data_Type.MNumericArray_Type_UBit64;
pub const MNumericArray_Type_Real32 = MNumericArray_Data_Type.MNumericArray_Type_Real32;
pub const MNumericArray_Type_Real64 = MNumericArray_Data_Type.MNumericArray_Type_Real64;
pub const MNumericArray_Type_Complex_Real32 = MNumericArray_Data_Type.MNumericArray_Type_Complex_Real32;
pub const MNumericArray_Type_Complex_Real64 = MNumericArray_Data_Type.MNumericArray_Type_Complex_Real64;
pub const MNumericArray_Type_Real16 = MNumericArray_Data_Type.MNumericArray_Type_Real16;
pub const MNumericArray_Type_Complex_Real16 = MNumericArray_Data_Type.MNumericArray_Type_Complex_Real16;

// typedef enum MNumericArray_Data_Type numericarray_data_t;
pub const numericarray_data_t = MNumericArray_Data_Type;

// enum MNumericArray_Convert_Method
// {
// 	MNumericArray_Convert_Check = 1,
// 	MNumericArray_Convert_Clip_Check,
// 	MNumericArray_Convert_Coerce,
// 	MNumericArray_Convert_Clip_Coerce,
// 	MNumericArray_Convert_Round,
// 	MNumericArray_Convert_Clip_Round,
// 	MNumericArray_Convert_Scale,
// 	MNumericArray_Convert_Clip_Scale,
// 	MNumericArray_Convert_Cast,
// 	MNumericArray_Convert_Clip_Cast
// };
pub const MNumericArray_Convert_Method = enum(c_int) {
    MNumericArray_Convert_Check = 1,
    MNumericArray_Convert_Clip_Check,
    MNumericArray_Convert_Coerce,
    MNumericArray_Convert_Clip_Coerce,
    MNumericArray_Convert_Round,
    MNumericArray_Convert_Clip_Round,
    MNumericArray_Convert_Scale,
    MNumericArray_Convert_Clip_Scale,
    MNumericArray_Convert_Cast,
    MNumericArray_Convert_Clip_Cast,
};
pub const MNumericArray_Convert_Check = MNumericArray_Convert_Method.MNumericArray_Convert_Check;
pub const MNumericArray_Convert_Clip_Check = MNumericArray_Convert_Method.MNumericArray_Convert_Clip_Check;
pub const MNumericArray_Convert_Coerce = MNumericArray_Convert_Method.MNumericArray_Convert_Coerce;
pub const MNumericArray_Convert_Clip_Coerce = MNumericArray_Convert_Method.MNumericArray_Convert_Clip_Coerce;
pub const MNumericArray_Convert_Round = MNumericArray_Convert_Method.MNumericArray_Convert_Round;
pub const MNumericArray_Convert_Clip_Round = MNumericArray_Convert_Method.MNumericArray_Convert_Clip_Round;
pub const MNumericArray_Convert_Scale = MNumericArray_Convert_Method.MNumericArray_Convert_Scale;
pub const MNumericArray_Convert_Clip_Scale = MNumericArray_Convert_Method.MNumericArray_Convert_Clip_Scale;
pub const MNumericArray_Convert_Cast = MNumericArray_Convert_Method.MNumericArray_Convert_Cast;
pub const MNumericArray_Convert_Clip_Cast = MNumericArray_Convert_Method.MNumericArray_Convert_Clip_Cast;

// typedef enum MNumericArray_Convert_Method numericarray_convert_method_t;
pub const numericarray_convert_method_t = MNumericArray_Convert_Method;

// typedef struct st_WolframNumericArrayLibrary_Functions {
pub const struct_st_WolframNumericArrayLibrary_Functions = extern struct {
    // 	errcode_t (*MNumericArray_new)(const numericarray_data_t, const mint, const mint*, MNumericArray*);
    /// is a library callback function that creates a new MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_new.html
    MNumericArray_new: fn (
        data_type: numericarray_data_t,
        rank: wl.mint,
        dims: [*]const wl.mint,
        res: *wl.MNumericArray,
    ) callconv(.C) wl.errcode_t,

    // 	void (*MNumericArray_free)(MNumericArray);
    /// is a library callback function that frees an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_free.html
    MNumericArray_free: fn (na: wl.MNumericArray) callconv(.C) void,

    // 	errcode_t (*MNumericArray_clone)(const MNumericArray, MNumericArray*);
    /// is a library callback function that puts a clone of in into out*.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_clone.html
    MNumericArray_clone: fn (in: wl.MNumericArray, out: ?*wl.MNumericArray) callconv(.C) wl.errcode_t,

    // 	void (*MNumericArray_disown)(MNumericArray);
    /// disowns a reference to an MNumericArray that was passed between a library function and the Wolfram Language
    /// using shared memory management.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_disown.html
    MNumericArray_disown: fn (na: wl.MNumericArray) callconv(.C) void,

    // 	void (*MNumericArray_disownAll)(MNumericArray);
    /// disowns all references to an MNumericArray that was passed between a library function and the Wolfram Language
    /// using shared memory management.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_disownAll.html
    MNumericArray_disownAll: fn (na: wl.MNumericArray) callconv(.C) void,

    // 	mint (*MNumericArray_shareCount)(const MNumericArray);
    /// returns the number of sharing references to an MNumericArray held by the Wolfram Language.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_shareCount.html
    MNumericArray_shareCount: fn (na: wl.MNumericArray) callconv(.C) wl.mint,

    // 	numericarray_data_t (*MNumericArray_getType)(const MNumericArray);
    /// gets the type of an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_getType.html
    MNumericArray_getType: fn (na: wl.MNumericArray) callconv(.C) numericarray_data_t,

    // 	mint (*MNumericArray_getRank)(const MNumericArray);
    /// gets the rank of an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_getRank.html
    MNumericArray_getRank: fn (na: wl.MNumericArray) callconv(.C) wl.mint,

    // 	mint const* (*MNumericArray_getDimensions)(const MNumericArray);
    /// gets an array of the dimensions of an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_getDimensions.html
    MNumericArray_getDimensions: fn (na: wl.MNumericArray) callconv(.C) [*]const wl.mint,

    // 	mint (*MNumericArray_getFlattenedLength)(const MNumericArray);
    /// gets the total number of elements in an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_getFlattenedLength.html
    MNumericArray_getFlattenedLength: fn (na: wl.MNumericArray) callconv(.C) wl.mint,

    // 	void* (*MNumericArray_getData)(const MNumericArray);
    /// gets a void pointer to an array of the data elements of an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_getData.html
    MNumericArray_getData: fn (na: wl.MNumericArray) callconv(.C) ?*anyopaque,

    // 	errcode_t (*MNumericArray_convertType)(MNumericArray*, const MNumericArray, const numericarray_data_t,
    // 										   const numericarray_convert_method_t, const mreal);
    /// is a library callback function that converts the data type of an MNumericArray.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MNumericArray_convertType.html
    MNumericArray_convertType: fn (
        out: ?*wl.MNumericArray,
        na: wl.MNumericArray,
        data_type: numericarray_data_t,
        method: numericarray_convert_method_t,
        tol: wl.mreal,
    ) callconv(.C) wl.errcode_t,
};

// } * WolframNumericArrayLibrary_Functions;
pub const st_WolframNumericArrayLibrary_Functions = struct_st_WolframNumericArrayLibrary_Functions;
pub const WolframNumericArrayLibrary_Functions = *st_WolframNumericArrayLibrary_Functions;
