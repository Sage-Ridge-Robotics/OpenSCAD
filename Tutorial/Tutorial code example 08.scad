/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 08 circle_of_columns() module. 

Usage: The circle_of_columns() module takes
one variable, the angle between each column.

*/


circle_of_columns(15);

// Let's try the same thing while placing the 
// circle_of_columns() module within a hull() 
// command. Note how the command constructs a polygon 
// by linking the columns.

translate([0,0,-20]) hull() {circle_of_columns(120);}

translate([0,0,-40]) hull() {circle_of_columns(90);}

translate([0,0,-60]) hull() {circle_of_columns(45);}


module circle_of_columns(step_angle = 45) {
   hypothenuse = 30;

   for (i = [0 : (360/step_angle)])
   {
      translate([
         (sin(i * step_angle) * hypothenuse),
         (cos(i * step_angle) * hypothenuse), 
         0
   ])
   cylinder(r=2,h=2, center=true, $fn=80);
   };
}

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/



