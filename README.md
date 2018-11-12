# libgeo-from-julia

A couple of examples on how to call C++ from Julia.
I looked into this because the Cxx package is not available for Julia 1.x yet.

## geo_direct.jl calls the C++ mangled names diretly

This is pretty fragile and most likely not portable between compilers.
But obviously it can be done.

## geo.jl

This interfaces to a C wrapper around the libGeographic.dylib
More portable, but one added indirection, and the added task of managing the shared library.

## Testing

This has only been tested on Mac OS 10.13 with LLVM 9.1.0

