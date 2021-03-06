/*++

Copyright (c) 2014 Minoca Corp.

    This file is licensed under the terms of the GNU General Public License
    version 3. Alternative licensing terms are available. Contact
    info@minocacorp.com for details. See the LICENSE file at the root of this
    project for complete licensing information.

Module Name:

    KD USB

Abstract:

    This library contains the USB kernel debugger support library.

Author:

    Evan Green 18-Apr-2014

Environment:

    Kernel, Boot

--*/

from menv import staticLibrary;

function build() {
    var entries;
    var includes;
    var lib;
    var sources;
    var stubLib;
    var stubSources;

    sources = [
        "ftdi.c",
        "hub.c",
        "kdehci.c",
        "kdusb.c"
    ];

    stubSources = [
        "kdnousb/stubs.c"
    ];

    includes = [
        "$S/drivers/usb/ehci"
    ];

    lib = {
        "label": "kdusb",
        "inputs": sources,
        "includes": includes
    };

    stubLib = {
        "label": "kdnousb",
        "inputs": stubSources
    };

    entries = staticLibrary(lib);
    entries += staticLibrary(stubLib);
    return entries;
}

