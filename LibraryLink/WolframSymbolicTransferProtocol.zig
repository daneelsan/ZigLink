const struct_WSLINK = opaque {};
pub const WSLINK = ?*struct_WSLINK;

pub extern fn WSNewPacket(wsp: WSLINK) c_int;

pub extern fn WSGetInteger(wsp: WSLINK, ip: *c_int) c_int;

pub extern fn WSGetString(wsp: WSLINK, sp: *[*:0]u8) c_int;

pub extern fn WSReleaseString(wsp: WSLINK, s: [*:0]const u8) void;

pub extern fn WSTestHead(wsp: WSLINK, s: [*:0]const u8, countp: *c_int) c_int;

pub extern fn WSPutInteger(wsp: WSLINK, i: c_int) c_int;

pub extern fn WSPutString(wsp: WSLINK, s: [*:0]const u8) c_int;
