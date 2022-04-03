//! An example that demonstrates using Shared memory management for
//! communicating between Mathematica and a DLL.

const wl = @import("WolframLibrary");

var tensor: wl.MTensor = undefined;

export fn WolframLibrary_getVersion() wl.mint {
    return wl.WolframLibraryVersion;
}

export fn WolframLibrary_initialize(libData: wl.WolframLibraryData) c_int {
    _ = libData;

    return 0;
}

export fn loadArray(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = libData;
    _ = argc;

    tensor = wl.MArgument_getMTensor(args[0]);
    wl.MArgument_setInteger(res, 0);
    return 0;
}

export fn setElementVector(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = argc;

    var pos: [1]wl.mint = undefined;
    pos[0] = wl.MArgument_getInteger(args[0]);
    const value = wl.MArgument_getReal(args[1]);

    _ = libData.MTensor_setReal(tensor, pos[0..], value);

    wl.MArgument_setInteger(res, 0);
    return 0;
}

export fn getElementVector(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = argc;

    var pos: [1]wl.mint = undefined;
    pos[0] = wl.MArgument_getInteger(args[0]);

    var value: wl.mreal = undefined;
    const err = libData.MTensor_getReal(tensor, pos[0..], &value);

    wl.MArgument_setReal(res, value);
    return err;
}

export fn setElement(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = argc;

    var pos: [2]wl.mint = undefined;
    pos[0] = wl.MArgument_getInteger(args[0]);
    pos[1] = wl.MArgument_getInteger(args[1]);

    const value = wl.MArgument_getReal(args[2]);

    _ = libData.MTensor_setReal(tensor, pos[0..], value);

    wl.MArgument_setInteger(res, 0);
    return 0;
}

export fn getElement(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = argc;

    var pos: [2]wl.mint = undefined;
    pos[0] = wl.MArgument_getInteger(args[0]);
    pos[1] = wl.MArgument_getInteger(args[1]);

    var value: wl.mreal = undefined;
    const err: c_int = libData.MTensor_getReal(tensor, pos[0..], &value);

    wl.MArgument_setReal(res, value);
    return err;
}

export fn getArray(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = libData;
    _ = argc;
    _ = args;

    wl.MArgument_setMTensor(res, tensor);
    return 0;
}

export fn unloadArray(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = argc;
    _ = args;

    libData.MTensor_disown(tensor);
    wl.MArgument_setInteger(res, 0);
    return 0;
}
