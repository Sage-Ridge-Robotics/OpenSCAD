/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 06 modules. 

*/

// Modules
// OpenSCAD allows us to define modules. The module()
// command creates named objects that can be used elsewhere
// in your design code. While it is entirely up to you where
// you place module() definitions, I like to put them toward
// the end of a project. In a more complex project, modules()
// can be placed in separate files and "included" into
// the main project file.

// Look at the bottom of this file for the definition
// of the object used here, a complex widget.
translate([0,0,0]) acme_widget_22();

// Here's an example of the acme_widget_22() module
// used in a programatic construct. First, the location
// of the group is set to (0, -100, 10) and then the
// group is constructed.

// The sine of the angle, i * 45, is used
// to calculate x, and the cosine, y. Multiplying a 
// constant, 10, by i increases z with each step.

hypothenuse = 30;
step_angle = 45;
translate([0,0,10]) 
   for (i = [0 : 7])
   {

      translate([
         (sin(i * step_angle) * hypothenuse),
         (cos(i * step_angle) * hypothenuse), 
         (i * 10)
      ])
      rotate(i*-45,0,0)
      acme_widget_22();

   };

/*

Define modules

We define larger modules used in code examples above in this section.

These modules include the

   acme_widget22() module
   match_box() module
   box_of_many_sizes()


*/


// The acme_widget_22() module
module acme_widget_22() {
   i = -10;
   difference() {

      union(){
         cylinder(r=2, h=20, center=true);
         translate([0,0,8]) cylinder(r=4,h=2);
         hull () {
            translate([0,0,i]) cylinder(r=2,h=2);
            translate([10,0,i]) cylinder(r=2,h=2);
            translate([5,10,i]) cylinder(r=2,h=2);
         }
      }

      # cylinder(r=1, h=22, center=true);
      # translate([0,0,8]) cylinder(r=2, h=2);
      # translate([10,0,i-1]) cylinder(r=1,h=4);
      # translate([5,10,i-1]) cylinder(r=1,h=4);

   }
}


// The match_box module
module match_box() {
   difference(){
      cube([40,20,10], center=true);
      translate([0,0,1]) cube([38,18,10], center=true);
   }
   translate([-60,100,15]) 
   union(){
      cube([40,20,2], center=true);
      translate(0,0,0) cube([38,18,4], center=true);
   }
}


// The box_of_many_sizes() module
module box_of_many_sizes(

   // sensible default values
   width = 60,
   length = 100,
   height = 40,

)
{

   wall_thickness = 2;

   translate([0,0,height/2])
   difference(){
      cube([width,length,height], center=true);
      translate([0,0,4]) cube([
         width-(2 * wall_thickness),
         length-(2 * wall_thickness),
         height-(2 * wall_thickness)], 
         center=true);

   } 
}

   
/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/



