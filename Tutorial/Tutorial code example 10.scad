/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 10 linear_extrude. 

*/


// 2D primitives with extrude
// If you ever have made pasta, you know that you can
// extrude a three-dimensional shape from a 
// two-dimensional opening. OpenSCAD allows you to do
// something similar with two-dimensional shapes. 
// Two-dimensional shapes can be drawn in the program
// or imported in the form of SVG or DXF line drawings.

// Here, we extrude a circle, twirling it as we do so.
// The twist and convexity commands control this
// curvature. The for() loop increments twist and 
// convexity.

// linear_extrude
translate([-40,0,0])
for (i = [0: 4]){

   translate([i * 20,0,0])
      linear_extrude(
         height = 50, 
         center = false, 
         convexity = 0, 
         twist = i * 1000, 
         slices = 200
      )
      translate([2,0,0])
      circle(r=2, center = true, $fn=60);
}

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/


