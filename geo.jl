#!/usr/bin/env julia

# Wrappers to make our lives easier
# These use the interface functions in the myLibGeo to access the
# correct functions in libGeographics

function latlon_to_xy(lon0, lon, lat)
    x = Ref{Cdouble}(0.0)
    y = Ref{Cdouble}(0.0)
    ccall( (:LatLon_to_XY, "/Users/bpmelli/devel/notebooks/tryit/myLibGeo.dylib"),
           Cdouble,
           (Cfloat, Cfloat, Cfloat, Ref{Cdouble}, Ref{Cdouble}),
           lon0, lon, lat, x, y)
    #     println( "in wrapper: x=", x[], ", y=", y[])
    return x[], y[]
end

function xy_to_latlon(lon0, x, y)
    lat = Ref{Cdouble}(0.0)
    lon = Ref{Cdouble}(0.0)
    ccall( (:XY_to_LatLon, "/Users/bpmelli/devel/notebooks/tryit/myLibGeo.dylib"),
           Cdouble,
           (Cfloat, Cfloat, Cfloat, Ref{Cdouble}, Ref{Cdouble}),
           lon0, x, y, lat, lon)
    return lat[], lon[]
end
    
# My code, using my wrappers

x, y = latlon_to_xy(0, -45, 10)
println("x: ", x, ", y: ", y)

lat, lon = xy_to_latlon(0, x, y)
println("lat: ", lat, ", lon: ", lon)
