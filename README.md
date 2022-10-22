# ZigLink

Call Zig code from Wolfram Language via the LibraryLink interface.

## Objectives

There are three objectives:

1. Translate the Wolfram LibraryLink C headers (WolframLibrary.h, WolframNumericArrayLibrary.h) to zig and use
   zig code to generate dynamic libraries callable from Wolfram Language.

2. Write a WolframLibraryLink.zig package that uses the translated libraries from 1) but using a more zig-like style, i.e. following the style from the zig standard library.

3. Write Wolfram Language paclet that allows to call the zig built-in compiler/linker, in a similar vein to how CCompilerDriver`CreateLibrary compiles C code.

Objective 1) is underway. Objectives 2) and 3) are TODO.

## Directory layout

```
├── demos                               # LibraryLink demos written in zig
├── LibraryLink                         # LibraryLink C headers translated to zig
    ├── WolframLibrary.zig
    ├── WolframNumericArrayLibrary.zig
├── LibraryResources                    # Directory containing all libraries
    ├── Linux-x86-64
    ├── MacOSX-ARM64
    ├── MacOSX-x86-64
    ├── Windows-x86-64
├── Tests
    ├── demos                           # Tests for the demos in zig
        ├── demo_XXXX.nb                # Notebook testing the demo_XXXX
        ├── demo_XXXX.wlt               # Automatic file generated from its .nb counterpart
        ├── ...
├── WolframResources                    # Resources that come from your standard Mathematica installation
    ├── LibraryLink                     # Wolfram LibraryLink files
        ├── demos
        ├── headers
├── build.zig                           # Zig build "script"
└── README.md
```

## LibraryLink header and demo translation

### demo_XXXX.zig

These are zig translated versions of the C LibraryLink demos found in WolframResources/LibraryLink/demos.

#### building

To build these libraries we will use the zig building system, which is all contained in `build.zig`.

First, make sure you have zig version 0.9.1 (or later):

```shell
$ zig version
0.9.1
```

Next, build all the demos:

```shell
$ zig build demos
```

The amazing thing about the zig build system is it that allows simple cross-platform compilation.
Not only did the previous command created libraries for all the demos, but it also did so for all
the major supported Wolfram platforms:

```shell
$ ls LibraryResources/
Linux-x86-64   MacOSX-ARM64   MacOSX-x86-64  Windows-x86-64
```

```shell
$ find LibraryResources/ -maxdepth 2  -type f
LibraryResources/MacOSX-x86-64/demo.dylib
LibraryResources/MacOSX-x86-64/demo_string.dylib
...
LibraryResources/MacOSX-ARM64/demo.dylib
LibraryResources/MacOSX-ARM64/demo_string.dylib
...
LibraryResources/Linux-x86-64/demo.so
LibraryResources/Linux-x86-64/demo_managed.so
...
LibraryResources/Windows-x86-64/demo_numericarray.pdb
LibraryResources/Windows-x86-64/demo_string.lib
```

Note: The current paths to Mathematica's headers and libraries is hardcoded in `build.zig`:

```zig
    const mathematica_path = "/Applications/Mathematica.app";
```

so modify these as appropriate.

#### testing

First add the demo libraries to the `$LibraryPath` so that these libraries can be found via `FindLibrary`:

```Mathematica
$LibraryPath = PrependTo[$LibraryPath, FileNameJoin[{$ZigLinkDirectory, "LibraryResources", $SystemID}]]
```

Next, run the .wlt tests found in Tests/demos:

```Mathematica
In[]:= TestReport[FileNames["*.wlt", FileNameJoin[{$ZigLinkDirectory, "Tests", "demos"}]]]
Out[]= TestReportObject[<...>]
```

`$ZigLinkDirectory` is the directory where the ZigLink repository is located.

### How?

The .zig packages where first generated using translate-c. However, many of the macros present in these headers where not translated correctly (or at all) by zig or types where not the most suitable, so they had to be manually tweaked after being translated by zig.
This is mentioned in zig's documentation:

> [...] if you would like to edit the translated code, it is recommended to use zig translate-c and save the results to a file. Common reasons for editing the generated code include: changing anytype parameters in function-like macros to more specific types; changing [*c]T pointers to [*]T or \*T pointers for improved type safety [...]

The .zig demos where manually translated from the C demos. They mostly follow the C style of coding, minus some uses of the zig standard library.

### Progress

Here is a list of the files that need to be translated (and the ones that already have).

#### headers:

-   [ ] WolframCompileLibrary.h
-   [ ] WolframImageLibrary.h
-   [ ] WolframIOLibraryFunctions.h
-   [x] WolframLibrary.h
-   [x] WolframNumericArrayLibrary.h
-   [ ] WolframRawArrayLibrary.h
-   [ ] WolframRTL.h
-   [ ] WolframSparseLibrary.h
-   [ ] WolframStreamsLibrary.h

#### demos:

-   [ ] arbitraryTensor.c
-   [ ] async-examples-libmain.c
-   [ ] async-examples.h
-   [ ] async-tasks-oneshot.c
-   [ ] async-tasks-repeating.c
-   [ ] async-tasks-timing.c
-   [ ] async-tasks-without-thread.c
-   [ ] demo_callback.c
-   [x] demo_error.c
-   [ ] demo_eval.c
-   [ ] demo_image.cxx
-   [x] demo_LinkObject.c
-   [x] demo_managed.cxx
-   [ ] demo_numerical.c
-   [x] demo_numericarray.cxx
-   [x] demo_shared.c
-   [ ] demo_sparse.c
-   [x] demo_string.c
-   [ ] demo.c
-   [ ] image_external.c
-   [ ] image_video.cxx

## References

LibraryLink:

-   https://reference.wolfram.com/language/LibraryLink/tutorial/Overview.html
-   https://reference.wolfram.com/language/guide/LibraryLink.html

Zig:

-   https://ziglearn.org
-   https://ziglang.org
-   https://github.com/ziglang/zig
-   https://ziglang.org/documentation/
-   https://www.lagerdata.com/articles/an-intro-to-zigs-integer-casting-for-c-programmers
-   https://zig.news/xq/zig-build-explained-part-1-59lf

Other:

-   https://github.com/WolframResearch/wolfram-library-link-rs
