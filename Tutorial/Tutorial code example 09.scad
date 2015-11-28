/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Example 09 box_of_many_sizes() module. 

*/


// One could quickly build a model of a Roman city using 
// modules. Of course, it would be nice to be able to size
// the construct with some simple parameters. 
// Let's go back to the match_box() module and make a 
// few changes to the module. We'll call the module
// box_of_many_sizes(). See below the module section below.

translate([0,0,0]) 
   box_of_many_sizes(50,20,10);

// We can automate box making with a nested for() loop
base_size_unit = 10;

translate([-100,-30,0]) 
for (i = [1 : 5]){

   assign(
      translation_distance = 
         (0.7 *(i * i * base_size_unit)),
      width = i * base_size_unit,
      length = i * base_size_unit,
      height = i * base_size_unit
   ){
      translate([translation_distance,translation_distance,0]) 
         box_of_many_sizes(
            width,
            length,
            height
         );
   }
}

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


