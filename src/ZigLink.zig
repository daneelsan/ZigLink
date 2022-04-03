const wl = @import("WolframLibrary.zig");

pub inline fn MArgument_getInteger(marg: wl.MArgument) wl.mint {
    return wl.MArgument_getIntegerAddress(marg).*;
}

pub inline fn MArgument_setInteger(marg: wl.MArgument, v: wl.mint) void {
    wl.MArgument_getIntegerAddress(marg).* = v;
}
