//! An example that demonstrates catching errors when calling
//! a Wolfram Library function from Mathematica.
//! https://reference.wolfram.com/language/LibraryLink/tutorial/Examples.html (demo_error)

const wl = @import("WolframLibrary");

export fn WolframLibrary_getVersion() wl.mint {
    return wl.WolframLibraryVersion;
}

export fn WolframLibrary_initialize(libData: wl.WolframLibraryData) c_int {
    _ = libData;
    return 0;
}

export fn WolframLibrary_uninitialize(libData: wl.WolframLibraryData) void {
    _ = libData;
}

export fn errordemo1(libData: wl.WolframLibraryData, Argc: wl.mint, Args: [*]wl.MArgument, Res: wl.MArgument) c_int {
    _ = Argc;

    const tensor = wl.MArgument_getMTensor(Args[0]);
    var pos: [1]wl.mint = undefined;
    pos[0] = wl.MArgument_getInteger(Args[1]);

    var res: wl.mreal = undefined;
    const err = libData.MTensor_getReal(tensor, pos[0..], &res);

    wl.MArgument_setReal(Res, res);
    return err;
}

export fn errordemo4(libData: wl.WolframLibraryData, Argc: wl.mint, Args: [*]wl.MArgument, Res: wl.MArgument) c_int {
    _ = Argc;

    const tensor = wl.MArgument_getMTensor(Args[0]);
    const part = wl.MArgument_getInteger(Args[1]);

    wl.MArgument_setReal(Res, 0);

    if (libData.MTensor_getRank(tensor) != 1) {
        libData.Message("rankerror");
        return wl.LIBRARY_RANK_ERROR;
    }

    const dims = libData.MTensor_getDimensions(tensor);
    if ((part < 1) or (part > dims[0])) {
        libData.Message("outofrange");
        return wl.LIBRARY_DIMENSION_ERROR;
    }

    // Generate a second error
    var pos: [1]wl.mint = .{part};
    var res: wl.mreal = undefined;
    const err = libData.MTensor_getReal(tensor, pos[0..], &res);
    wl.MArgument_setReal(Res, res);
    return err;
}
