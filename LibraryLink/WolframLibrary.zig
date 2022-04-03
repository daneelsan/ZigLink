//! This file was generated first by using zig translate-c on WolframLibrary.h
//! Some #defines were not working properly, so it has been tweeked by hand to work correctly.
//! In most cases, a comment shows the C counterpart of the snippet of code it precedes.
//!
//! Some further comments:
//! - Using structMethod: fn (...) instead of structMethod: ?fn (...). That is, we assume
//!   structMethod is never null.

pub const wl_na = @import("WolframNumericArrayLibrary.zig");

// #ifndef WOLFRAMLIBRARY_H
// #define WOLFRAMLIBRARY_H
pub const WOLFRAMLIBRARY_H = "";

// #define WolframLibraryVersion 6
pub const WolframLibraryVersion: mint = 6;

// #define True 1
// #define False 0
pub const True: c_int = 1;
pub const False: c_int = 0;

// #ifdef MINT_32
// typedef int32_t mint;
// typedef uint32_t umint;
// #else
// typedef int64_t mint;
// typedef uint64_t umint;
// #endif
pub const mint = isize;
pub const umint = usize;

// typedef int mbool;
pub const mbool = c_int;

// typedef double mreal;
pub const mreal = f64;

// typedef int type_t;
pub const type_t = c_int;

// typedef int errcode_t;
pub const errcode_t = c_int;

// typedef uint32_t UBIT32;
pub const UBIT32 = u32;

// typedef uint64_t UBIT64;
pub const UBIT64 = u64;

// /* Platform specific variants in mcomplex.h */

// typedef struct {
//   mreal ri[2];
// } mcomplex;
pub const mcomplex = extern struct {
    ri: [2]mreal,
};

// #define mcreal(z) (((z).ri)[0])
pub inline fn mcreal(z: mcomplex) mreal {
    return z.ri[@as(c_int, 0)];
}
// #define mcimag(z) (((z).ri)[1])
pub inline fn mcimag(z: mcomplex) mreal {
    return z.ri[@as(c_int, 1)];
}

// /* Incomplete types */

// typedef struct st_MNumericArray* MTensor;
// typedef struct st_MNumericArray* MRawArray;
// typedef struct st_MNumericArray* MNumericArray;
pub const struct_st_MNumericArray = opaque {};
pub const st_MNumericArray = struct_st_MNumericArray;
pub const MTensor = ?*st_MNumericArray;
pub const MRawArray = ?*st_MNumericArray;
pub const MNumericArray = ?*st_MNumericArray;

// typedef struct MSparseArray_struct* MSparseArray;
pub const struct_MSparseArray_struct = opaque {};
pub const MSparseArray_struct = struct_MSparseArray_struct;
pub const MSparseArray = ?*MSparseArray_struct;

// typedef struct IMAGEOBJ_ENTRY* MImage;
pub const struct_IMAGEOBJ_ENTRY = opaque {};
pub const IMAGEOBJ_ENTRY = struct_IMAGEOBJ_ENTRY;
pub const MImage = ?*IMAGEOBJ_ENTRY;

// #define MType_Integer 2
// #define MType_Real 3
// #define MType_Complex 4
pub const MType_Integer: c_int = 2;
pub const MType_Real: c_int = 3;
pub const MType_Complex: c_int = 4;

// typedef union {
//   mbool *boolean;
//   mint *integer;
//   mreal *real;
//   mcomplex *cmplex;
//   MTensor *tensor;
//   MSparseArray *sparse;
//   MNumericArray *numeric;
//   MImage *image;
//   char **utf8string;
// } MArgument;
pub const MArgument = extern union {
    boolean: *mbool,
    integer: *mint,
    real: *mreal,
    cmplex: *mcomplex,
    tensor: *MTensor,
    sparse: *MSparseArray,
    numeric: *MNumericArray,
    image: *MImage,
    utf8string: *[*:0]u8,
};

// #define MArgument_getBooleanAddress(marg) ((marg).boolean)
pub inline fn MArgument_getBooleanAddress(marg: MArgument) *mbool {
    return marg.boolean;
}
// #define MArgument_getIntegerAddress(marg) ((marg).integer)
pub inline fn MArgument_getIntegerAddress(marg: MArgument) *mint {
    return marg.integer;
}
// #define MArgument_getRealAddress(marg) ((marg).real)
pub inline fn MArgument_getRealAddress(marg: MArgument) *mreal {
    return marg.real;
}
// #define MArgument_getComplexAddress(marg) ((marg).cmplex)
pub inline fn MArgument_getComplexAddress(marg: MArgument) *mcomplex {
    return marg.cmplex;
}
// #define MArgument_getMTensorAddress(marg) ((marg).tensor)
pub inline fn MArgument_getMTensorAddress(marg: MArgument) *MTensor {
    return marg.tensor;
}
// #define MArgument_getMSparseArrayAddress(marg) ((marg).sparse)
pub inline fn MArgument_getMSparseArrayAddress(marg: MArgument) *MSparseArray {
    return marg.sparse;
}
// #define MArgument_getMRawArrayAddress(marg) ((marg).numeric)
pub inline fn MArgument_getMRawArrayAddress(marg: MArgument) *MNumericArray {
    return marg.numeric;
}
// #define MArgument_getMNumericArrayAddress(marg) ((marg).numeric)
pub inline fn MArgument_getMNumericArrayAddress(marg: MArgument) *MNumericArray {
    return marg.numeric;
}
// #define MArgument_getMImageAddress(marg) ((marg).image)
pub inline fn MArgument_getMImageAddress(marg: MArgument) *MImage {
    return marg.image;
}
// #define MArgument_getUTF8StringAddress(marg) ((marg).utf8string)
pub inline fn MArgument_getUTF8StringAddress(marg: MArgument) *[*:0]u8 {
    return marg.utf8string;
}

// #define MArgument_getAddress(marg) ((void*) ((marg).integer))
pub inline fn MArgument_getAddress(marg: MArgument) ?*anyopaque {
    return @ptrCast(?*anyopaque, marg.integer);
}
// #define MArgument_setAddress(marg, add) (((marg).integer) = ((mint*) (add)))
pub inline fn MArgument_setAddress(marg: MArgument, add: ?*anyopaque) void {
    marg.integer = @ptrCast(*mint, add);
}

// #define MArgument_getBoolean(marg) (*MArgument_getBooleanAddress(marg))
pub inline fn MArgument_getBoolean(marg: MArgument) mbool {
    return MArgument_getBooleanAddress(marg).*;
}
// #define MArgument_getInteger(marg) (*MArgument_getIntegerAddress(marg))
pub inline fn MArgument_getInteger(marg: MArgument) mint {
    return MArgument_getIntegerAddress(marg).*;
}
// #define MArgument_getReal(marg) (*MArgument_getRealAddress(marg))
pub inline fn MArgument_getReal(marg: MArgument) mreal {
    return MArgument_getRealAddress(marg).*;
}
// #define MArgument_getComplex(marg) (*MArgument_getComplexAddress(marg))
pub inline fn MArgument_getComplex(marg: MArgument) mcomplex {
    return MArgument_getComplexAddress(marg).*;
}
// #define MArgument_getMTensor(marg) (*MArgument_getMTensorAddress(marg))
pub inline fn MArgument_getMTensor(marg: MArgument) MTensor {
    return MArgument_getMTensorAddress(marg).*;
}
// #define MArgument_getMSparseArray(marg) (*MArgument_getMSparseArrayAddress(marg))
pub inline fn MArgument_getMSparseArray(marg: MArgument) MSparseArray {
    return MArgument_getMSparseArrayAddress(marg).*;
}
// #define MArgument_getMRawArray(marg) (*MArgument_getMRawArrayAddress(marg))
pub inline fn MArgument_getMRawArray(marg: MArgument) MNumericArray {
    return MArgument_getMRawArrayAddress(marg).*;
}
// #define MArgument_getMNumericArray(marg) (*MArgument_getMNumericArrayAddress(marg))
pub inline fn MArgument_getMNumericArray(marg: MArgument) MNumericArray {
    return MArgument_getMNumericArrayAddress(marg).*;
}
// #define MArgument_getMImage(marg) (*MArgument_getMImageAddress(marg))
pub inline fn MArgument_getMImage(marg: MArgument) MImage {
    return MArgument_getMImageAddress(marg).*;
}
// #define MArgument_getUTF8String(marg) (*MArgument_getUTF8StringAddress(marg))
pub inline fn MArgument_getUTF8String(marg: MArgument) [*:0]u8 {
    return MArgument_getUTF8StringAddress(marg).*;
}

// #define MArgument_setBoolean(marg, v) ((*MArgument_getBooleanAddress(marg)) = (v))
pub inline fn MArgument_setBoolean(marg: MArgument, v: mbool) void {
    MArgument_getBooleanAddress(marg).* = v;
}
// #define MArgument_setInteger(marg, v) ((*MArgument_getIntegerAddress(marg)) = (v))
pub inline fn MArgument_setInteger(marg: MArgument, v: mint) void {
    MArgument_getIntegerAddress(marg).* = v;
}
// #define MArgument_setReal(marg, v) ((*MArgument_getRealAddress(marg)) = (v))
pub inline fn MArgument_setReal(marg: MArgument, v: mreal) void {
    MArgument_getRealAddress(marg).* = v;
}
// #define MArgument_setComplex(marg, v) ((*MArgument_getComplexAddress(marg)) = (v))
pub inline fn MArgument_setComplex(marg: MArgument, v: mcomplex) void {
    MArgument_getComplexAddress(marg).* = v;
}
// #define MArgument_setMTensor(marg, v) ((*MArgument_getMTensorAddress(marg)) = (v))
pub inline fn MArgument_setMTensor(marg: MArgument, v: MTensor) void {
    MArgument_getMTensorAddress(marg).* = v;
}
// #define MArgument_setMSparseArray(marg, v) ((*MArgument_getMSparseArrayAddress(marg)) = (v))
pub inline fn MArgument_setMSparseArray(marg: MArgument, v: MSparseArray) void {
    MArgument_getMSparseArrayAddress(marg).* = v;
}
// #define MArgument_setMRawArray(marg, v) ((*MArgument_getMRawArrayAddress(marg)) = (v))
pub inline fn MArgument_setMRawArray(marg: MArgument, v: MNumericArray) void {
    MArgument_getMRawArrayAddress(marg).* = v;
}
// #define MArgument_setMNumericArray(marg, v) ((*MArgument_getMNumericArrayAddress(marg)) = (v))
pub inline fn MArgument_setMNumericArray(marg: MArgument, v: MNumericArray) void {
    MArgument_getMNumericArrayAddress(marg).* = v;
}
// #define MArgument_setMImage(marg, v) ((*MArgument_getMImageAddress(marg)) = (v))
pub inline fn MArgument_setMImage(marg: MArgument, v: MImage) void {
    MArgument_getMImageAddress(marg).* = v;
}
// #define MArgument_setUTF8String(marg, v) ((*MArgument_getUTF8StringAddress(marg)) = (v))
pub inline fn MArgument_setUTF8String(marg: MArgument, v: [*:0]u8) void {
    MArgument_getUTF8StringAddress(marg).* = v;
}

// #define __MLINK__
pub const __MLINK__ = "";
// typedef struct MLink* MLINK;
// typedef struct MLink* WSLINK;
pub const struct_MLink = opaque {};
pub const MLink = struct_MLink;
pub const MLINK = ?*MLink;
pub const WSLINK = ?*MLink;

// #define __MLENV__
pub const __MLENV__ = "";
// typedef struct ml_environment* MLENV;
// typedef MLENV MLEnvironment;
// typedef struct ml_environment* WSENV;
// typedef WSENV WSEnvironment;
pub const struct_ml_environment = opaque {};
pub const ml_environment = struct_ml_environment;
pub const MLENV = ?*ml_environment;
pub const MLEnvironment = MLENV;
pub const WSENV = ?*ml_environment;
pub const WSEnvironment = WSENV;

// #define MSTREAM_TYPEDEF
pub const MSTREAM_TYPEDEF = "";
// typedef struct st_MInputStream* MInputStream;
pub const struct_st_MInputStream = opaque {};
pub const st_MInputStream = struct_st_MInputStream;
pub const MInputStream = ?*st_MInputStream;

// typedef struct st_MOutputStream* MOutputStream;
pub const struct_st_MOutputStream = opaque {};
pub const st_MOutputStream = struct_st_MOutputStream;
pub const MOutputStream = ?*st_MOutputStream;

// /* Error types for LibraryErrorHandler */
// enum {
//   LIBRARY_NO_ERROR = 0,
//   LIBRARY_TYPE_ERROR,
//   LIBRARY_RANK_ERROR,
//   LIBRARY_DIMENSION_ERROR,
//   LIBRARY_NUMERICAL_ERROR,
//   LIBRARY_MEMORY_ERROR,
//   LIBRARY_FUNCTION_ERROR,
//   LIBRARY_VERSION_ERROR
// };
pub const LIBRARY_NO_ERROR: c_int = 0;
pub const LIBRARY_TYPE_ERROR: c_int = 1;
pub const LIBRARY_RANK_ERROR: c_int = 2;
pub const LIBRARY_DIMENSION_ERROR: c_int = 3;
pub const LIBRARY_NUMERICAL_ERROR: c_int = 4;
pub const LIBRARY_MEMORY_ERROR: c_int = 5;
pub const LIBRARY_FUNCTION_ERROR: c_int = 6;
pub const LIBRARY_VERSION_ERROR: c_int = 7;

// typedef struct st_DataStore* DataStore;
pub const struct_st_DataStore = opaque {};
pub const st_DataStore = struct_st_DataStore;
pub const DataStore = ?*st_DataStore;

// struct st_WolframRuntimeData *runtimeData;
pub const struct_st_WolframRuntimeData = opaque {};
pub const st_WolframRuntimeData = struct_st_WolframRuntimeData;

// struct st_WolframCompileLibrary_Functions *compileLibraryFunctions;
pub const struct_st_WolframCompileLibrary_Functions = opaque {};
pub const st_WolframCompileLibrary_Functions = struct_st_WolframCompileLibrary_Functions;

// struct st_WolframIOLibrary_Functions *ioLibraryFunctions;
pub const struct_st_WolframIOLibrary_Functions = opaque {};
pub const st_WolframIOLibrary_Functions = struct_st_WolframIOLibrary_Functions;

// struct st_WolframSparseLibrary_Functions *sparseLibraryFunctions;
pub const struct_st_WolframSparseLibrary_Functions = opaque {};
pub const st_WolframSparseLibrary_Functions = struct_st_WolframSparseLibrary_Functions;

// struct st_WolframImageLibrary_Functions *imageLibraryFunctions;
pub const struct_st_WolframImageLibrary_Functions = opaque {};
pub const st_WolframImageLibrary_Functions = struct_st_WolframImageLibrary_Functions;

// struct st_WolframRawArrayLibrary_Functions *rawarrayLibraryFunctions;
pub const struct_st_WolframRawArrayLibrary_Functions = opaque {};
pub const st_WolframRawArrayLibrary_Functions = struct_st_WolframRawArrayLibrary_Functions;

// struct st_WolframNumericArrayLibrary_Functions *numericarrayLibraryFunctions;
// pub const struct_st_WolframNumericArrayLibrary_Functions = opaque {};
// pub const st_WolframNumericArrayLibrary_Functions = struct_st_WolframNumericArrayLibrary_Functions;
pub const st_WolframNumericArrayLibrary_Functions = wl_na.st_WolframNumericArrayLibrary_Functions;

// struct st_WolframLibraryData {
pub const struct_st_WolframLibraryData = extern struct {
    //   void (*UTF8String_disown)(char *);
    /// disowns a string argument.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/UTF8String_disown.html
    UTF8String_disown: fn ([*:0]u8) callconv(.C) void,

    //   int (*MTensor_new)(mint, mint, mint const *, MTensor *);
    /// is a library callback function that creates a new MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_new.html
    MTensor_new: fn (type: mint, rank: mint, dims: [*]const mint, pres: *MTensor) callconv(.C) c_int,

    //   void (*MTensor_free)(MTensor);
    /// is a library callback function that frees an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_free.html
    MTensor_free: fn (t: MTensor) callconv(.C) void,

    //   int (*MTensor_clone)(MTensor, MTensor *);
    /// is a library callback function that puts a clone of f into *t.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_clone.html
    MTensor_clone: fn (f: MTensor, t: *MTensor) callconv(.C) c_int,

    //   mint (*MTensor_shareCount)(MTensor);
    /// returns the number of sharing references to an MTensor held by the Wolfram Language.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_shareCount.html
    MTensor_shareCount: fn (t: MTensor) callconv(.C) mint,

    //   void (*MTensor_disown)(MTensor);
    /// disowns a reference to an MTensor that was passed between a library function and the Wolfram Language
    /// using shared memory management.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_disown.html
    MTensor_disown: fn (t: MTensor) callconv(.C) void,

    //   void (*MTensor_disownAll)(MTensor);
    /// disowns all references to an MTensor that was passed between a library function and the Wolfram Language
    /// using shared memory management.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_disownAll.html
    MTensor_disownAll: fn (t: MTensor) callconv(.C) void,

    //  int (*MTensor_setInteger)(MTensor, mint *, mint);
    /// sets a single element of an MTensor of integer type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_setInteger.html
    MTensor_setInteger: fn (t: MTensor, pos: [*]mint, value: mint) callconv(.C) c_int,

    //  int (*MTensor_setReal)(MTensor, mint *, mreal);
    /// sets a single element of an MTensor of real type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_setReal.html
    MTensor_setReal: fn (t: MTensor, pos: [*]mint, value: mreal) callconv(.C) c_int,

    //  int (*MTensor_setComplex)(MTensor, mint *, mcomplex);
    /// sets a single element of an MTensor of complex type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_setComplex.html
    MTensor_setComplex: fn (t: MTensor, pos: [*]mint, value: mcomplex) callconv(.C) c_int,

    //  int (*MTensor_setMTensor)(MTensor, MTensor, mint *, mint);
    /// sets a subtensor element in an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_setMTensor.html
    MTensor_setMTensor: fn (t: MTensor, val: MTensor, pos: [*]mint, numpos: mint) callconv(.C) c_int,

    //   int (*MTensor_getInteger)(MTensor, mint *, mint *);
    /// gets an element from an MTensor of integer type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getInteger.html
    MTensor_getInteger: fn (t: MTensor, pos: [*]mint, pres: *mint) callconv(.C) c_int,

    //   int (*MTensor_getReal)(MTensor, mint *, mreal *);
    /// gets a single element of an MTensor of real type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getReal.html
    MTensor_getReal: fn (t: MTensor, pos: [*]mint, pres: *mreal) callconv(.C) c_int,

    //   int (*MTensor_getComplex)(MTensor, mint *, mcomplex *);
    /// gets a single element of an MTensor of complex type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getComplex.html
    MTensor_getComplex: fn (t: MTensor, pos: [*]mint, pres: *mcomplex) callconv(.C) c_int,

    //   int (*MTensor_getMTensor)(MTensor, mint *, mint, MTensor *);
    /// gets a subtensor element from an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getMTensor.html
    MTensor_getMTensor: fn (t: MTensor, pos: [*]mint, numpos: mint, pres: *MTensor) callconv(.C) c_int,

    //   mint (*MTensor_getRank)(MTensor);
    /// gets the rank of an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getRank.html
    MTensor_getRank: fn (t: MTensor) callconv(.C) mint,

    //   mint const *(*MTensor_getDimensions)(MTensor);
    /// gets an array of the dimensions of an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getDimensions.html
    MTensor_getDimensions: fn (t: MTensor) callconv(.C) [*]const mint,

    //   mint (*MTensor_getType)(MTensor);
    /// gets the type of an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getType.html
    MTensor_getType: fn (t: MTensor) callconv(.C) mint,

    //   mint (*MTensor_getFlattenedLength)(MTensor);
    /// gets the total number of elements in an MTensor.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getFlattenedLength.html
    MTensor_getFlattenedLength: fn (t: MTensor) callconv(.C) mint,

    //   mint *(*MTensor_getIntegerData)(MTensor);
    /// gets an array of the data elements of an MTensor of real type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getIntegerData.html
    MTensor_getIntegerData: fn (t: MTensor) callconv(.C) [*]mint,

    //   mreal *(*MTensor_getRealData)(MTensor);
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getRealData.html
    MTensor_getRealData: fn (t: MTensor) callconv(.C) [*]mreal,

    //   mcomplex *(*MTensor_getComplexData)(MTensor);
    /// gets an array of the data elements of an MTensor of complex type.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/MTensor_getComplexData.html
    MTensor_getComplexData: fn (t: MTensor) callconv(.C) [*]mcomplex,

    //   void (*Message)(const char *);
    /// issues a message from a library function.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/Message.html
    Message: fn (txt: [*:0]const u8) callconv(.C) void,

    //   mint (*AbortQ)(void);
    /// returns TRUE if the Wolfram Language is in the process of an abort.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/AbortQ.html
    AbortQ: fn () callconv(.C) mint,

    //   WSLINK (*getWSLINK)(WolframLibraryData);
    /// gets a WSLINK connection to use for evaluations in the Wolfram Language.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/getWSLINK.html
    getWSLINK: fn (libData: WolframLibraryData) callconv(.C) WSLINK,

    //   int (*processWSLINK)(WSLINK);
    /// calls the Wolfram Language to process the expression written onto a link.
    /// http://reference.wolframcloud.com/language/LibraryLink/ref/callback/processWSLINK.html.en
    processWSLINK: fn (link: WSLINK) callconv(.C) c_int,

    //   int (*evaluateExpression)(WolframLibraryData, char *, int, mint, void *);
    /// https://mathematica.stackexchange.com/questions/47311/undocumented-wolframlibrarydataevaluateexpression
    evaluateExpression: fn (
        libData: WolframLibraryData,
        expr_string: [*:0]const u8,
        type: c_int,
        rank: mint,
        vres: ?*anyopaque,
    ) callconv(.C) c_int,

    //   struct st_WolframRuntimeData *runtimeData;
    runtimeData: ?*st_WolframRuntimeData,

    //   struct st_WolframCompileLibrary_Functions *compileLibraryFunctions;
    compileLibraryFunctions: ?*st_WolframCompileLibrary_Functions,

    //   mint VersionNumber;
    VersionNumber: mint,

    //   /* Added in WolframLibraryVersion 2 */
    //   mbool (*registerInputStreamMethod)(
    //       const char *name,
    //       void (*ctor)(MInputStream, const char *msgHead, void *optionsIn),
    //       mbool (*handlerTest)(void *, char *), void *methodData,
    //       void (*destroyMethod)(void *methodData));
    /// https://mathematica.stackexchange.com/questions/31433/librarylink-what-can-we-do-with-minputstream-and-moutputstream
    registerInputStreamMethod: fn (
        name: [*:0]const u8,
        ctor: ?fn (MInputStream, msgHead: [*:0]const u8, optionsIn: ?*anyopaque) callconv(.C) void,
        handlerTest: ?fn (?*anyopaque, [*:0]const u8) callconv(.C) mbool,
        methodData: ?*anyopaque,
        destroyMethod: ?fn (methodData: ?*anyopaque) callconv(.C) void,
    ) callconv(.C) mbool,

    //  mbool (*unregisterInputStreamMethod)(const char *name);
    unregisterInputStreamMethod: fn (name: [*:0]const u8) callconv(.C) mbool,

    //   mbool (*registerOutputStreamMethod)(
    //       const char *name,
    //       void (*ctor)(MOutputStream, const char *msgHead, void *optionsIn,
    //                    mbool appendMode),
    //       mbool (*handlerTest)(void *, char *), void *methodData,
    //       void (*destroyMethod)(void *methodData));
    registerOutputStreamMethod: fn (
        name: [*:0]const u8,
        ctor: ?fn (MOutputStream, msgHead: [*:0]const u8, optionsIn: ?*anyopaque, appendMode: mbool) callconv(.C) void,
        handlerTest: ?fn (?*anyopaque, [*:0]const u8) callconv(.C) mbool,
        methodData: ?*anyopaque,
        destroyMethod: ?fn (methodData: ?*anyopaque) callconv(.C) void,
    ) callconv(.C) mbool,

    //   mbool (*unregisterOutputStreamMethod)(const char *name);
    unregisterOutputStreamMethod: fn (name: [*:0]const u8) callconv(.C) mbool,

    //   struct st_WolframIOLibrary_Functions *ioLibraryFunctions;
    ioLibraryFunctions: ?*st_WolframIOLibrary_Functions,

    //   WSENV (*getWSLINKEnvironment)(WolframLibraryData);
    getWSLINKEnvironment: fn (libData: WolframLibraryData) callconv(.C) WSENV,

    //   struct st_WolframSparseLibrary_Functions *sparseLibraryFunctions;
    /// https://reference.wolfram.com/language/LibraryLink/tutorial/Examples.html (demo_sparse)
    sparseLibraryFunctions: ?*st_WolframSparseLibrary_Functions,

    //   struct st_WolframImageLibrary_Functions *imageLibraryFunctions;
    /// https://reference.wolfram.com/language/LibraryLink/tutorial/Examples.html (demo_image)
    imageLibraryFunctions: ?*st_WolframImageLibrary_Functions,

    //   int (*registerLibraryExpressionManager)(const char *mname,
    //                                           void (*mfun)(WolframLibraryData,
    //                                                        mbool, mint));
    /// is a library callback function that registers a library expression manager name mgr with the function manageFun.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/registerLibraryExpressionManager.html
    registerLibraryExpressionManager: fn (
        mngr: [*:0]const u8,
        manageFun: ?fn (libData: WolframLibraryData, mode: mbool, id: mint) callconv(.C) void,
    ) callconv(.C) c_int,

    //   int (*unregisterLibraryExpressionManager)(const char *mname);
    /// is a library callback function that unregisters a library expression manager with name mgr.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/unregisterLibraryExpressionManager.html
    unregisterLibraryExpressionManager: fn (mngr: [*:0]const u8) callconv(.C) c_int,

    //   int (*releaseManagedLibraryExpression)(const char *mname, mint id);
    /// is a library callback function that releases a library expression managed by mgr with the positive integer id.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/releaseManagedLibraryExpression.html
    releaseManagedLibraryExpression: fn (mngr: [*:0]const u8, id: mint) callconv(.C) c_int,

    //   int (*registerLibraryCallbackManager)(const char *name,
    //                                         mbool (*mfun)(WolframLibraryData, mint,
    //                                                       MTensor));
    /// is a library callback function that registers a library callback manager name mgr with the function mfun.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/registerLibraryCallbackManager.html
    registerLibraryCallbackManager: fn (
        mngr: [*:0]const u8,
        mfun: ?fn (libData: WolframLibraryData, id: mint, argtypes: MTensor) callconv(.C) mbool,
    ) callconv(.C) c_int,

    //   int (*unregisterLibraryCallbackManager)(const char *name);
    /// is a library callback function that unregisters a library expression manager with name mgr.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/unregisterLibraryCallbackManager.html
    unregisterLibraryCallbackManager: fn (mngr: [*:0]const u8) callconv(.C) c_int,

    //   int (*callLibraryCallbackFunction)(mint id, mint ArgC, MArgument *Args,
    //                                      MArgument Res);
    /// is a library callback function that rcalls the library callback function associated with the specified
    /// positive integer id.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/callLibraryCallbackFunction.html
    callLibraryCallbackFunction: fn (id: mint, ArgC: mint, Args: [*]MArgument, Res: MArgument) callconv(.C) c_int,

    //   int (*releaseLibraryCallbackFunction)(mint id);
    /// is a library callback function that releases the library callback function associated with the specified
    /// positive integer id.
    /// https://reference.wolfram.com/language/LibraryLink/ref/callback/releaseLibraryCallbackFunction.html
    releaseLibraryCallbackFunction: fn (id: mint) callconv(.C) c_int,

    //   /* security callback */
    //   mbool (*validatePath)(char *path, char type);
    validatePath: fn (path: [*:0]const u8, type: u8) callconv(.C) mbool,

    //   mbool (*protectedModeQ)(void);
    protectedModeQ: fn () callconv(.C) mbool,

    //   struct st_WolframRawArrayLibrary_Functions *rawarrayLibraryFunctions;
    rawarrayLibraryFunctions: ?*st_WolframRawArrayLibrary_Functions,

    //   struct st_WolframNumericArrayLibrary_Functions *numericarrayLibraryFunctions;
    /// https://reference.wolframcloud.com/language/LibraryLink/tutorial/InteractionWithWolframLanguage.html
    /// (MNumericArray [Experimental])
    numericarrayLibraryFunctions: ?*st_WolframNumericArrayLibrary_Functions,

    //   /*
    //      Sets the value ParallelThreadNumber and returns the old value, or the
    //      input if invalid. The old value should be stored in a local variable. The
    //      old value must be restored using restoreParallelThreadNumber before the
    //      setting routine exits.
    //    */
    //   int (*setParallelThreadNumber)(int);
    setParallelThreadNumber: fn (num: c_int) callconv(.C) c_int,

    //   void (*restoreParallelThreadNumber)(int);
    restoreParallelThreadNumber: fn (num: c_int) callconv(.C) void,

    //   int (*getParallelThreadNumber)(void);
    getParallelThreadNumber: fn () callconv(.C) c_int,
};

// typedef struct st_WolframLibraryData* WolframLibraryData;
pub const st_WolframLibraryData = struct_st_WolframLibraryData;
pub const WolframLibraryData = *struct_st_WolframLibraryData;
