# godot-headers

This folder contains C headers for [**Godot Engine**](https://github.com/godotengine/godot)'s *GDNative Extensions* API, as well as the equivalent nim binding file.

## Updating Headers

As of the time of this document's writing, Godot Engine is in beta. As such, if the current header files are not up-to-date with the Godot version you're using, you can update them with the following steps:

1. Download or compile [Godot Engine](https://godotengine.org/download) at the specific version/commit which you are using.
2. Use the downloaded/compiled executable to generate the `extension_api.json` file, then copy it to `godot-headers`:

        godot --dump-extension-api extension_api.json

3. Copy the file `core/extension/gdextension_interface.h` from [Godot's source code](https://github.com/godotengine/godot) at the specific version you are using (e.g. 4.0 beta 10) to `godot` .

4. Insert the following code at the top of the `gdextension_interface.h` file:

        #ifdef C2NIM
        #	cdecl
        #	mangle ssize_t int
        #	mangle uint64_t uint64
        #	mangle uint32_t uint32
        #	mangle uint16_t uint16
        #	mangle uint8_t uint8
        #	mangle int64_t int64
        #	mangle int32_t int32
        #	mangle int16_t int16
        #	mangle int8_t int8
        #	mangle wchar_t uint32
        #endif

5. Install c2nim, if it is not already installed:

        nimble install c2nim

6. Navigate to the `godot` folder and run the following command to generate the .nim binding file:

        c2nim gdextension_interface.h

7. This should generate the file `gdextension_interface.nim` . Copy it to `src/gdextension_nim/wrapped_header` .
