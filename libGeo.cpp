#include <iostream>
#include <GeographicLib/TransverseMercatorExact.hpp>

// Expose a couple of functions in libGeographics so that they can be called from Julia
// I tried to call the mangled name directly with ccall, but Julia failed to find them.

extern "C" {

  void XY_to_LatLon(float lon0, float x, float y, double &lat, double &lon)
  {
    const GeographicLib::TransverseMercatorExact& proj = GeographicLib::TransverseMercatorExact::UTM();
    proj.Reverse(lon0, x, y, lat, lon);
  }

  void LatLon_to_XY(float lon0, float lon, float lat, double &x, double &y)
  {
    const GeographicLib::TransverseMercatorExact& proj = GeographicLib::TransverseMercatorExact::UTM();
    proj.Forward(lon0, lat, lon, x, y);
  }
}
