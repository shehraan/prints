# Parametric L-bracket

The `l-bracket/` directory contains a Mojulo 3.0.0 OpenSCAD recipe and a
true-scale STL export. All dimensions are in millimetres. OpenSCAD is the
editable representation; `mojulo-recipe.json` preserves Mojulo's source recipe.

## Coordinate frame and dimensions

The origin is the front-left bottom corner of the base. X spans the 100 mm
width, Y runs front to rear over the 60 mm base depth, and Z points up.

- Base: X = 0–100, Y = 0–60, Z = 0–6.
- Flange: X = 0–100, Y = 54–60, Z = 6–56. It rises 50 mm above the base top.
- Overall bounds: 100 × 60 × 56 mm.
- Four 4.5 mm base holes: axes along Z, centred at (X,Y) = (10,10),
  (90,10), (10,50), and (90,50). The rear holes also clear the inside fillet.
- Two 5.5 mm flange holes: axes along Y, centred at (X,Y,Z) = (30,57,31)
  and (70,57,31). Their X separation is 40 mm; Z is 25 mm above the base top.

## Edges and representation

The OpenSCAD program specifies a nominal 8 mm inside fillet, nominal 2 mm
rounding on the four outside vertical flange corners, and a 1 mm × 45°
chamfer on the top perimeter. The inside fillet tapers at its ends to leave
the four rounded flange corners exposed.

Mojulo stores an editable CSG program, but its curved sections are faceted at
`$fn = 256`. There is no exact B-rep fillet surface in either file. Maximum
chord deviation from the nominal circle is approximately 0.00060 mm for the
8 mm radius and 0.00015 mm for the 2 mm radius. Straight chamfer sections
have a measured 1 mm inset over 1 mm rise; the rounded corner transitions
are faceted. The STL is tessellated and does not carry parameters.

The STL was checked as one watertight solid with six through-holes. Its bounds
and hole centres were checked against the coordinates above. The exported
OpenSCAD program was also rendered independently with OpenSCAD.
