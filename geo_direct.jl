#!/usr/bin/env julia

# Example of calling C++ functions directly from Julia.
# On Mac OS I had to trim one leading '_' from the function mangled name

# --------------------------------------------------------------
# Julia wrapper to C++ functions in libGeographic.dylib
# --------------------------------------------------------------

function get_UTM_Exact_handle()
    utm = ccall( (:_ZN13GeographicLib23TransverseMercatorExact3UTMEv,
                  "libGeographic"),
                 Ptr{Cvoid}, ())
    return utm
end

function latlon_to_xy(utm, lon0, lat, lon)
    x = Ref{Cdouble}(0.0)
    y = Ref{Cdouble}(0.0)
    gamma = Ref{Cdouble}(0.0)
    k = Ref{Cdouble}(0.0)

    
    ccall( (:_ZNK13GeographicLib23TransverseMercatorExact7ForwardEdddRdS1_S1_S1_,
            "libGeographic"),
           Cvoid,
           (Ref{Cvoid}, Cdouble, Cdouble, Cdouble, Ref{Cdouble}, Ref{Cdouble},
            Ref{Cdouble}, Ref{Cdouble}),
           utm, lon0, lon, lat, x, y, gamma, k)
    return x[], y[]
end

function xy_to_latlon(utm, lon0, x, y)
    lat = Ref{Cdouble}(0.0)
    lon = Ref{Cdouble}(0.0)
    gamma = Ref{Cdouble}(0.0)
    k = Ref{Cdouble}(0.0)
    
    ccall( (:_ZNK13GeographicLib23TransverseMercatorExact7ReverseEdddRdS1_S1_S1_,
            "libGeographic"),
           Cvoid,
           (Ref{Cvoid}, Cdouble, Cdouble, Cdouble, Ref{Cdouble}, Ref{Cdouble},
            Ref{Cdouble}, Ref{Cdouble}),
           utm, lon0, x, y, lat, lon, gamma, k)
    return lat[], lon[]
end

# --------------------------------------------------------------
# Use the wrappers aboce
# --------------------------------------------------------------

# Get a handle to a TransverseMercatorExact object.

utm = get_UTM_Exact_handle()

x, y = latlon_to_xy(utm, 0, -45, 10)
println("x: ", x, ", y: ", y)

lat, lon = xy_to_latlon(utm, 0, x, y)
println("lat: ", lat, ", lon: ", lon)




