const wl = @import("WolframLibrary.zig");
const std = @import("std");
const testing = std.testing;

test "test" {
    const a: wl.mint = 0;
    std.debug.print("@sizeOf(mint): {}\n", .{a});
    // try testing.expect();
}
