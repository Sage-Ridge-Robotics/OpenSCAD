/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 05 Object math. 

*/

// Object math
// Using union() we can combine objects into a single object, and
// using difference() we can subtract one object from another.
// difference() is really important. You use the command to make
// holes. Finally, the command intersection() is the reverse of
// difference().

// Here's the same command as above placed within a union() 
// command. Note the use of the curley brackets.

union(){
   for(n = [1:6])
   {
      translate([0,0,0])
      rotate([0,45,60 * n]) 
      cylinder(r=2,h=10,center = false);
   }
   translate([0,0,-0.6]) sphere(r=1.8, center=true, $fn=60);
}


// Here's an example of difference. The first line defines an 
// object from which we will subtract other objects. The pound 
// sign, #, tells the compiler to display the negative objects
// so we can see them. They may be deleted.

difference() 
{

   translate([0,0,30]) cube(size=10, center = true);
   translate([0,0,30]) # cube([6,12,6], center = true);
   translate([0,0,30]) # cube([12,6,6], center = true);
   translate([0,0,30]) # cube([6,6,12], center = true);

}

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/

