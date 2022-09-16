
$fn = 50;

// Defaults for slice
DEFAULT_INNER_RADIUS = 37.5 / 2; // For tea candle
DEFAULT_OUTER_RADIUS = 40;
DEFAULT_ALIGN_HOLE_RADIUS = 3.5 / 2;
DEFAULT_OUTER_FN = 5;

// Defaults for stack
DEFAULT_SLICE_HEIGHT = 3;
DEFAULT_ROTATION_PER_SLICE = 5;
DEFAULT_NUM_SLICES_IN_STACK = 19;

module Slice2D(
    rotation,
    innerRadius = DEFAULT_INNER_RADIUS,
    outerRadius = DEFAULT_OUTER_RADIUS,
    alighHoleRadius = DEFAULT_ALIGN_HOLE_RADIUS,
    outerFN = DEFAULT_OUTER_FN)
{
    offset = (outerRadius + innerRadius) / 2;
    
    difference()
    {
        circle(outerRadius, $fn=outerFN);
        circle(innerRadius);
        
        rotate([0, 0, -rotation])
        {
            translate([0, +offset]) circle(alighHoleRadius);
            translate([0, -offset]) circle(alighHoleRadius);
        }
    }
}

module Stack(
    innerRadius = DEFAULT_INNER_RADIUS,
    outerRadius = DEFAULT_OUTER_RADIUS,
    alighHoleRadius = DEFAULT_ALIGN_HOLE_RADIUS,
    outerFN = DEFAULT_OUTER_FN,

    height = DEFAULT_SLICE_HEIGHT,
    numSlices = DEFAULT_NUM_SLICES_IN_STACK,
    rotationPerSlice = DEFAULT_ROTATION_PER_SLICE)
{
    for (x = [0 : 1 : 19])
    {
        rotate([0, 0, x * rotationPerSlice])
        translate([0, 0, x * height])
        linear_extrude(height)
        Slice2D(rotationPerSlice * x, innerRadius,
            outerRadius, alighHoleRadius, outerFN);
    }
}

//Slice2D(0);
Stack();
