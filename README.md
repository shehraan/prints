# Parametric L-bracket

The `l-bracket/` directory contains a Mojulo 3.0.0 OpenSCAD recipe and a
true-scale STL export. All dimensions are in millimetres. OpenSCAD is the
editable representation; `mojulo-recipe.json` preserves Mojulo's source recipe.

## Coordinate frame and dimensions

The origin is the front-left bottom corner of the base. X spans the 80 mm
width, Y runs front to rear over the 50 mm base depth, and Z points up.

- Base: X = 0–80, Y = 0–50, Z = 0–6.
- Flange: X = 0–80, Y = 44–50, Z = 6–56. It rises 50 mm above the base top.
- Overall bounds: 80 × 50 × 56 mm.
- Four 4.5 mm base holes: axes along Z, centred at (X,Y) = (10,10),
  (70,10), (10,40), and (70,40). The rear holes also clear the inside fillet.
- Two 5.5 mm flange holes: axes along Y, centred at (X,Y,Z) = (20,47,31)
  and (60,47,31). Their X separation is 40 mm; Z is 25 mm above the base top.

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
