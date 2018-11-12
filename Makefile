# Make the libgeo wrapper to interface Julia to libGeographics

TARGET = myLibGeo.dylib
LIBS   = -lGeographic

SRC = libGeo.cpp

$(TARGET): $(SRC)
	g++ -dynamiclib -undefined suppress -flat_namespace $(SRC) -o $(TARGET) $(LIBS)

clean:
	rm -f $(TARGET) *~
