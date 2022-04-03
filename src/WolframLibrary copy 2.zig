const wl = @This();

comptime {
    _ = wl.WolframLibraryVersion;
}

pub usingnamespace @cImport({
    @cDefine("MArgument_getInteger", {});
    @cDefine("MArgument_setInteger", {});

    @cInclude("WolframLibrary.h");

    @cUndef("MArgument_getInteger");
    @cUndef("MArgument_setInteger");
});

pub inline fn MArgument_getInteger(marg: wl.MArgument) wl.mint {
    return wl.MArgument_getIntegerAddress(marg).*;
}

pub inline fn MArgument_setInteger(marg: wl.MArgument, v: wl.mint) void {
    wl.MArgument_getIntegerAddress(marg).* = v;
}
