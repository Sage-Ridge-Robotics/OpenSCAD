/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 02 cylinders. 

Usage: The circle_of_columns() module takes
one variable, the angle between each column.


*/


// Cylinders
// We use the cylinder command to construct cylindrical objects. 
// Note how $fn controls the number of faces (smoothness) of the 
// object
translate([0,0,0]) cylinder(r=2,h=4, center=true, $fn=50);
translate([10,10,5]) cylinder(r=1,h=6, center=true, $fn=10);

// We'll set the default $fn to 30 for now
$fn=30;

// cylinder() can be used to draw conical objects by setting
// each of the two associated radii to a differnt value
translate([40,0,0]) cylinder(r1=6,r2=2,h=10, $fn=80);
translate([40,0,12]) cylinder(r1=2, r2=6,h=10);

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/



