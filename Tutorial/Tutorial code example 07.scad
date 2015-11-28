// Other ways to build parts
/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 07 Constructing objects. 

*/


// OpenSCAD has a few tricks for constructing objects
// that inolve the clever combination of geometric
// primitives, cubes, spheres, etc.

// The minkowski() command is one such tool. We are 
// going to use it to create a small box with rounded corners.

// First the basic shape is generated. You can change the size
// of the cylinders to alter the rounding of the corner.

translate([0,0,0])
minkowski()
{
   cube([20,10,1], center=true);
   cylinder(r=4,h=2);
};

// Great. Let's build the box by defining the outer box
// as a minkowski() object then subtracting a slightly
// smaller box to leave 1mm walls.

translate([0,50,0])
difference(){
   minkowski()
   {
      cube([40,20,10], center=true);
      cylinder(r=3,h=2);
   }
   translate([0,0,1])
   minkowski()
   {
      cube([38,18,10], center=true);
      cylinder(r=3,h=2);
   }
};


// Building a box and top is even easier if you do
// not want rounded corners.

translate([0,100,0])
difference(){
   cube([40,20,10], center=true);
   translate([0,0,1]) cube([38,18,10], center=true);
}

translate([0,100,15]) 
union(){
   cube([40,20,2], center=true);
   translate(0,0,0) cube([38,18,4], center=true);
}

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/


