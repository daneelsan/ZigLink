const wl = @import("WolframLibrary.zig");

export fn add(libData: wl.WolframLibraryData, argc: wl.mint, args: [*]wl.MArgument, res: wl.MArgument) c_int {
    _ = libData;
    _ = argc;

    const a: wl.mint = wl.MArgument_getInteger(args[0]);
    var b: wl.mint = a + 1;
    wl.MArgument_setInteger(res, b);
    return 0;
}
