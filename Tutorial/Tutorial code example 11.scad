/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 11 rotate_extrude(). 

*/


// Extrusions can rotate around an axis, too, using the 
// rotate_extrude() command. Here we constuct a torus
// or doughnut, first defining a module,

translate([0,0,0])
for(i = [0:9]){
   translate([0,0,i*4])
   doughnut(section_radius = 1);
}

// and a complex shape like one might produce with a lathe.
translate([20,0,0])
for(i = [0:3]){
   translate([i * 20, 0,0])
      scale(i+1)
      rotate([0,0,0])
      rotate_extrude($fn=200)
      polygon( points=[[0,0],[1.5,1],[1,2],[1,3],[3,4],[0,5]] );
}

// Complex polygons or shapes with curves should be imported
// as DXF or SVG files.

// We can use the objects we create with extrude to interact with
// other objects via union(), difference(), and intersection().
// Let's use the intersection() command to create a novel shape 
// combining the torus (doughnut) and a rectangular solid.

translate([0,-20,0]) intersection()
   {
     scale(2){doughnut(section_radius = 1);}
     square(10, center=true);
   }


// Modules
module doughnut(section_radius = 1) {
   rotate_extrude(convexity = 10, $fn = 100)
   translate([2, 0, 0])
   circle(r = section_radius, $fn = 100);
}


   
/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/


