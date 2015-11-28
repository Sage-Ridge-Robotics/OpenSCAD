/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 04 sets. 

*/


// Creating sets of objects
// You'll recognize the for() loop from Processing, though
// its syntax is a bit different. The loop is used to 
// create sets of objects. Here, [0 : 4 : 12] means start at zero 
// and count by 4s to 12. [0 : 12] would mean count by ones, and
// [0 : 0.5 : 12] would mean count by halves.

for (i = [0 : 4 : 12]) 
{

   translate([0,5,i]) cube(size = 2, center = true);
   translate([3,5,i]) cube([2,5,2], center = true);
   translate([8,5,i]) cube([5,2,2], center = true);
   translate([3,-5,i]) sphere(d = 3, center = true);

}

// rotate() allows you to spin objects around
// rotation takes three variables: degrees of rotation
// about the x axis, y axis, and z axis. 

// Which direction do objects rotate? Clockwise? Counter clockwise?

for(i = [1 : 6])
{
   translate([0,0,20])
   rotate([0,90,60 * i]) 
   cylinder(r=2,h=10,center = false);
}

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/



