const std = @import("std");

const CrossTarget = std.zig.CrossTarget;

const MathematicaSystemID = enum {
    @"Windows-x86-64",
    @"Linux-x86-64",
    @"MacOSX-x86-64",
    @"MacOSX-ARM64",
};

const MathematicaPlatform = struct {
    system_id: MathematicaSystemID,
    cross_target: CrossTarget,

    pub fn init(system_id: MathematicaSystemID, arch_os_abi: []const u8) MathematicaPlatform {
        @setEvalBranchQuota(10000);
        const cross_target = CrossTarget.parse(.{ .arch_os_abi = arch_os_abi }) catch unreachable;
        return .{
            .system_id = system_id,
            .cross_target = cross_target,
        };
    }
};

const mathematica_platforms = [_]MathematicaPlatform{
    // TODO: download wstp for Windows
    // MathematicaPlatform.init(.@"Windows-x86-64", "x86_64-windows"),
    MathematicaPlatform.init(.@"Linux-x86-64", "x86_64-linux"),
    MathematicaPlatform.init(.@"MacOSX-x86-64", "x86_64-macos"),
    MathematicaPlatform.init(.@"MacOSX-ARM64", "aarch64-macos"),
};

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    _ = b.standardTargetOptions(.{});

    const demos = [_][]const u8{
        "demo",
        "demo_error",
        "demo_managed",
        "demo_numericarray",
        "demo_shared",
        "demo_string",
        "demo_LinkObject",
    };
    const step_demos = b.step("demos", "Compiles all demos");
    inline for (demos) |demo| {
        const demo_src = "demos/" ++ demo ++ ".zig";
        const step_demo = b.step(demo, "Compiles " ++ demo_src);
        inline for (mathematica_platforms) |platform| {
            const demo_lib = b.addSharedLibrary(demo, demo_src, .unversioned);

            demo_lib.setBuildMode(mode);
            demo_lib.setTarget(platform.cross_target);

            addMathematicaResources(demo_lib, platform);

            addZigLinkPackages(demo_lib);

            fixLibraryName(demo_lib, platform);
            demo_lib.install();

            step_demo.dependOn(&demo_lib.step);
            step_demos.dependOn(&demo_lib.step);
        }
    }
}

fn addMathematicaResources(lib: *std.build.LibExeObjStep, platform: MathematicaPlatform) void {
    _ = platform;
    // TODO: make this path custom.
    const mathematica_path = "/Applications/Mathematica.app";

    const c_headers = mathematica_path ++ "/Contents/SystemFiles/IncludeFiles/C";
    lib.addIncludeDir(c_headers);

    const libraries_path = lib.builder.pathJoin(&.{
        mathematica_path,
        "/Contents/SystemFiles/Libraries/",
        @tagName(platform.system_id),
    });

    lib.addLibPath(libraries_path);

    switch (platform.system_id) {
        .@"MacOSX-x86-64", .@"MacOSX-ARM64" => {
            const wstp_dir = lib.builder.pathJoin(&.{
                mathematica_path,
                "/Contents/SystemFiles/Links/WSTP/DeveloperKit/",
                @tagName(platform.system_id),
                "CompilerAdditions",
            });
            lib.addIncludeDir(wstp_dir);
            lib.addFrameworkDir(wstp_dir);
            lib.linkFramework("wstp");
        },
        else => {},
    }
}

fn addZigLinkPackages(lib: *std.build.LibExeObjStep) void {
    lib.addPackagePath("WolframLibrary", "./LibraryLink/WolframLibrary.zig");
    lib.addPackagePath("WolframNumericArrayLibrary", "./LibraryLink/WolframNumericArrayLibrary.zig");
    lib.addPackagePath("WolframSymbolicTransferProtocol", "./LibraryLink/WolframSymbolicTransferProtocol.zig");
}

fn fixLibraryName(lib: *std.build.LibExeObjStep, platform: MathematicaPlatform) void {
    // Mathematica does not use the convention of adding lib if not in windows.
    if (platform.cross_target.getOsTag() != .windows) {
        lib.out_lib_filename = lib.out_lib_filename[3..];
    }
    lib.emit_bin = .{ .emit_to = lib.builder.pathJoin(&.{
        "LibraryResources",
        @tagName(platform.system_id),
        lib.out_lib_filename,
    }) };
    // lib.setOutputDir(outputDir);
}
