/*++

Copyright (c) 2012 Minoca Corp.

    This file is licensed under the terms of the GNU General Public License
    version 3. Alternative licensing terms are available. Contact
    info@minocacorp.com for details. See the LICENSE file at the root of this
    project for complete licensing information.

Module Name:

    Kernel Debugger

Abstract:

    This library contains the support code necessary to enable debugging
    of a running kernel. This library is included in all versions of the
    operating system.

Author:

    Evan Green 10-Aug-2012

Environment:

    Kernel

--*/

from menv import staticLibrary, mconfig;

function build() {
    var arch = mconfig.arch;
    var archSources;
    var baseSources;
    var bootArchSources;
    var bootLib;
    var bootSources;
    var entries;
    var lib;

    baseSources = [
        "kdebug.c"
    ];

    bootSources = [
        ":kdebug.o",
    ];

    if ((arch == "armv7") || (arch == "armv6")) {
        archSources = [
            "armv7/kdarch.c",
            "armv7/kdatomic.S",
            "armv7/kdsup.S",
            "armv7/kdsupc.c"
        ];

        bootArchSources = [
            ":armv7/kdarch.o",
            "boot/armv7/kdatomic.S",
            ":armv7/kdsup.o",
            ":armv7/kdsupc.o"
        ];

    } else if ((arch == "x86") || (arch == "x64")) {
        archSources = [
            "x86/kdarch.c",
            "x86/kdsup.S"
        ];

        bootArchSources = [
            ":x86/kdarch.o",
            ":x86/kdsup.o"
        ];
    }

    lib = {
        "label": "kd",
        "inputs": baseSources + archSources,
    };

    bootLib = {
        "label": "kdboot",
        "inputs": bootSources + bootArchSources,
    };

    entries = staticLibrary(lib);
    entries += staticLibrary(bootLib);
    return entries;
}

