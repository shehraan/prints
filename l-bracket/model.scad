// ──────────────────────────────────────────────────────────────────────────
// Parametric L-bracket 80x50x56 mm
//
// minted by mojulo · recipe sk_bgtvvgbpr7 · kind scad
//
// This recipe IS an OpenSCAD program: the text below is the stored source, verbatim.
// Change it with update_sketch (`/source`, `/parts/<name>`) or own it from here.
// Authored in mm.
// ──────────────────────────────────────────────────────────────────────────

// Parametric L-bracket. All dimensions are millimetres.
// Coordinates: x = 80 mm width; y = 50 mm base depth; z = height.
// Base occupies z=0..6. Flange occupies y=44..50 and z=6..56.
// Circular sections are tessellated by OpenSCAD; nominal radii are below.

$fn = 256;

width = 80;
depth = 50;
base_thickness = 6;
flange_thickness = 6;
flange_height = 50; // Above the top face of the base.
inside_radius = 8;
outside_vertical_radius = 2;
top_chamfer = 1;
base_hole_diameter = 4.5;
flange_hole_diameter = 5.5;

flange_front = depth - flange_thickness;

// Counter-clockwise 2D outline, starting at the lower right corner.
function arc_points(cx, cy, r, start, n) =
    [for (i = [0:n]) [cx + r*cos(start + 90*i/n),
                       cy + r*sin(start + 90*i/n)]];
function rounded_outline(x0, y0, x1, y1, r, n) = concat(
    arc_points(x1-r, y0+r, r, -90, n),
    arc_points(x1-r, y1-r, r,   0, n),
    arc_points(x0+r, y1-r, r,  90, n),
    arc_points(x0+r, y0+r, r, 180, n)
);

// The top outline is inset 1 mm on every side. Its corner radius is 1 mm,
// sharing the lower outline's corner centres. This makes a 45-degree chamfer
// on the straight top edges and conical, faceted transitions at the corners.
module top_chamfer_band() {
    n = $fn/4;
    construction_overlap = 0.02;
    upper_inset = top_chamfer + construction_overlap;
    lower = rounded_outline(0, flange_front, width, depth,
                            outside_vertical_radius, n);
    upper = rounded_outline(upper_inset, flange_front+upper_inset,
                            width-upper_inset, depth-upper_inset,
                            outside_vertical_radius-upper_inset, n);
    // The upper construction slice extends 0.02 mm past the final top and
    // is clipped. Its 1.02 mm inset makes the visible z=49..50 band exactly
    // 1 mm inset over 1 mm rise. The lower slice overlaps the flange body.
    intersection() {
        hull() {
            translate([0, 0, flange_height-top_chamfer-construction_overlap])
                linear_extrude(height=construction_overlap) polygon(lower);
            translate([0, 0, flange_height])
                linear_extrude(height=construction_overlap) polygon(upper);
        }
        translate([-1, -1, 0]) cube([width+2, depth+2, flange_height]);
    }
}

module flange() {
    linear_extrude(height = flange_height-top_chamfer)
        polygon(rounded_outline(0, flange_front, width, depth,
                                outside_vertical_radius, $fn/4));
    top_chamfer_band();
}

// Additive concave fillet: a square corner with an r8 quarter cylinder
// removed. Tangencies are at y=36,z=6 and y=44,z=14.
module inside_fillet() {
    intersection() {
        difference() {
            translate([0, flange_front-inside_radius, base_thickness])
                cube([width, inside_radius, inside_radius]);
            translate([-1, flange_front-inside_radius,
                       base_thickness+inside_radius])
                rotate([0, 90, 0])
                    cylinder(r=inside_radius, h=width+2);
        }
        // The fillet dies into the two rounded front corners of the flange;
        // otherwise it would refill their r2 cuts below z=14.
        translate([0, 0, base_thickness])
            linear_extrude(height=inside_radius)
                polygon([[0, flange_front-inside_radius],
                         [width, flange_front-inside_radius],
                         [width-outside_vertical_radius, flange_front],
                         [outside_vertical_radius, flange_front]]);
    }
}

module bracket_blank() {
    union() {
        cube([width, depth, base_thickness]);
        translate([0, 0, base_thickness]) flange();
        inside_fillet();
    }
}

// Holes are cut last, so the rear base holes also pass through any material
// added by the r8 internal fillet.
difference() {
    bracket_blank();
    for (x = [10, width-10], y = [10, depth-10])
        translate([x, y, -1])
            cylinder(d=base_hole_diameter, h=base_thickness+inside_radius+2);
    for (x = [width/2-20, width/2+20])
        translate([x, depth+1, base_thickness+25])
            rotate([90, 0, 0])
                cylinder(d=flange_hole_diameter,
                         h=flange_thickness+2);
}
