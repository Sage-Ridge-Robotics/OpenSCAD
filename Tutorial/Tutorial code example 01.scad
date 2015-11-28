/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 01 cubes. 



*/

// Cubes 
// Rectangular solids are constructed with the cube command.
// We use translate to position the solid. Note how the *entire line*
// ends with a semi-colon. 

translate([0,0,0]) cube(4,4,4);
translate([2,2,2]) cube(4,4,4, center=true);

// Use your mouse in the visualization pane to rotate the view
// around. See what happens when you change
// center=true to center=false in the second cube.

// What happens if you remove the translate() command? Where do 
// objects draw by default?

   
/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/

