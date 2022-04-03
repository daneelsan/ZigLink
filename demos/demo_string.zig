//! An example that demonstrates using Shared memory management for
//! communicating between Mathematica and a Wolfram Library.
//! https://reference.wolfram.com/language/LibraryLink/tutorial/Examples.html (demo_string)

const wl = @import("WolframLibrary");
const std = @import("std");

export fn WolframLibrary_getVersion() wl.mint {
    return wl.WolframLibraryVersion;
}

export fn WolframLibrary_initialize(libData: wl.WolframLibraryData) c_int {
    _ = libData;
    return wl.LIBRARY_NO_ERROR;
}

var string: ?[*:0]u8 = null;

export fn WolframLibrary_uninitialize(libData: wl.WolframLibraryData) void {
    if (string) |s| {
        libData.UTF8String_disown(s);
    }
}

export fn countSubstring(libData: wl.WolframLibraryData, Argc: wl.mint, Args: [*]wl.MArgument, Res: wl.MArgument) c_int {
    _ = Argc;

    const in_string = wl.MArgument_getUTF8String(Args[0]);
    const sub_string = wl.MArgument_getUTF8String(Args[1]);

    const in_slice = std.mem.span(in_string);
    const sub_slice = std.mem.span(sub_string);

    var count: wl.mint = 0;
    if (in_slice.len > sub_slice.len) {
        const len_dif = in_slice.len - sub_slice.len;
        var i: usize = 0;
        while (i <= len_dif) : (i += 1) {
            if (std.mem.eql(u8, in_slice[i .. i + sub_slice.len], sub_slice)) {
                count += 1;
            }
        }
    }

    wl.MArgument_setInteger(Res, count);

    libData.UTF8String_disown(in_string);
    libData.UTF8String_disown(sub_string);
    return wl.LIBRARY_NO_ERROR;
}

export fn encodeString(libData: wl.WolframLibraryData, Argc: wl.mint, Args: [*]wl.MArgument, Res: wl.MArgument) c_int {
    _ = Argc;

    if (string) |s| {
        libData.UTF8String_disown(s);
    }

    string = wl.MArgument_getUTF8String(Args[0]);
    const in_shift = wl.MArgument_getInteger(Args[1]);

    // Find shift mod 127 so we only deal with positive numbers below
    const shift = @intCast(u8, @mod(in_shift, 127) - 1);

    const slice = std.mem.span(string.?);
    for (slice) |*c| {
        // Error for non ASCII string
        if (c.* > 127) {
            return wl.LIBRARY_FUNCTION_ERROR;
        }
        c.* = @mod(c.* + shift, 127);
        c.* += 1;
    }

    wl.MArgument_setUTF8String(Res, string.?);
    return wl.LIBRARY_NO_ERROR;
}

export fn reverseString(libData: wl.WolframLibraryData, Argc: wl.mint, Args: [*]wl.MArgument, Res: wl.MArgument) c_int {
    _ = Argc;

    if (string) |s| {
        libData.UTF8String_disown(s);
    }

    string = wl.MArgument_getUTF8String(Args[0]);
    const slice = std.mem.span(string.?);

    for (slice) |c| {
        // Error for non ASCII string
        if (c > 127) {
            return wl.LIBRARY_FUNCTION_ERROR;
        }
    }

    const n = slice.len / 2;
    for (slice[0..n]) |*c, i| {
        const c_i = c.*;
        c.* = slice[slice.len - i - 1];
        slice[slice.len - i - 1] = c_i;
    }

    wl.MArgument_setUTF8String(Res, string.?);
    return wl.LIBRARY_NO_ERROR;
}
