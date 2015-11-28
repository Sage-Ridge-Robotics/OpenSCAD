/*

Sage Ridge Robotics OpenSCAD tutorial file.
Christopher von Nagy, July 2014.

This tutorial is released under the terms of the
Creative Commons Attribnution 4.0 license 
(CC by 4.0). See the end of this tutorial file for the license code.


Note: You may need to change the zoom factor of text or drag the
divider between the code pane and the visualization pane for
correct display of explanatory text. 

Turn on Automatic Reload and Compile to force OpenSCAD to compile
everytime use use the save command [Cntl+S on Windows and Linux, 
Command+s on OSX.

This tutorial file is meant to be completely transformed by your
experimentation with the examples.

*/

/*

Discussion

OpenSCAD is an open source tool used in 3D design and prototyping. 
Unlike visual tools like SketchUp and Blender, OpenSCAD allows for 
the easy construction of parametric shapes. It is not a visual 
development environment, rather OpenSCAD will take the code you 
write in the coding pane and compile it into a 3D visualization 
shown in the pane to the right. It is a bit like Processing. 

Before you read any further, note that the user manual is located at:

http://en.wikibooks.org/wiki/OpenSCAD_User_Manual

This tutorial is written in the form of commented source code.
Please play around with each example and read the approriate 
section in the User Manual if necessary. The intent of this
tutorial is to help you become familiar with tool to allow
you to design objects for 3D printing and to export them as STL
files used to generate g-code for the 3D printer.

OpenSCAD is a powerful tool for designing parts. It is not
really intended for artistic or architectural 3D design.
SketchUp (commercial, AutoCAD (also commercial), and 
Blender (open source) are better tools for that. We will 
combine OpenSCAD with Blender for visualization and 
OpenSCAD and slic3r for prototyping.

Consider each unit to be a millimeter. That is how slic3r will
interpret coordinates. OpenSCAD files do not actually specify
units. All numbers in OpenSCAD are floating point. There are
no integers.

*/



// ** Important.** If there is an error in code, 
// nothing will display in the visualization pane
// and the results pane (text at bottom right) will
// indicate a compile error.


// #### Part One ####


// Primitives
// Design in OpenSCAD begins with 2D and 3D primitives. Let's start


// Cubes (Example 01)
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


// Cylinders (Example 02)
// We use the cylinder command to construct cylindrical objects. 
// Note how $fn controls the number of faces (smoothness) of the 
// object
translate([15,0,0]) cylinder(r=2,h=4, center=true, $fn=50);
translate([20,0,5]) cylinder(r=1,h=6, center=true, $fn=10);

// We'll set the default $fn to 30 for now
$fn=30;

// cylinder() can be used to draw conical objects by setting
// each of the two associated radii to a differnt value
translate([40,0,0]) cylinder(r1=6,r2=2,h=10, $fn=80);
translate([40,0,12]) cylinder(r1=2, r2=6,h=10);

// Spheres (Example 03)
// Spheres are created with the sphere() command. 
translate([0,40,0]) sphere(r=10, $fn=80);



// #### Part Two ####


// Creating sets of objects (Example 04)
// You'll recognize the for() loop from Processing, though
// its syntax is a bit different. The loop is used to 
// create sets of objects. Here, [0 : 4 : 12] means start at zero 
// and count by 4s to 12. [0 : 12] would mean count by ones, and
// [0 : 0.5 : 12] would mean count by halves.

for (i = [0 : 4 : 12]) 
{

   translate([60,5,i]) cube(size = 2, center = true);
   translate([63,5,i]) cube([2,5,2], center = true);
   translate([68,5,i]) cube([5,2,2], center = true);
   translate([63,-5,i]) sphere(d = 3, center = true);

}

// rotate() allows you to spin objects around
// rotation takes three variables: degrees of rotation
// about the x axis, y axis, and z axis. 

// Which direction do objects rotate? Clockwise? Counter clockwise?

for(i = [1 : 6])
{
   translate([0,0,40])
   rotate([0,90,60 * i]) 
   cylinder(r=2,h=10,center = false);
}



// #### Part Three ####

// Object math (Example 05)
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
      translate([0,0,70])
      rotate([0,45,60 * n]) 
      cylinder(r=2,h=10,center = false);
   }
   translate([0,0,69.6]) sphere(r=1.8, center=true, $fn=60);
}


// Here's an example of difference. The first line defines an 
// object from which we will subtract other objects. The pound 
// sign, #, tells the compiler to display the negative objects
// so we can see them. They may be deleted.

difference() 
{

   translate([100,0,0]) cube(size=10, center = true);
   translate([100,0,0]) # cube([6,12,6], center = true);
   translate([100,0,0]) # cube([12,6,6], center = true);
   translate([100,0,0]) # cube([6,6,12], center = true);

}



// #### Part Four ####

// Modules (Example 06)
// OpenSCAD allows us to define modules. The module()
// command creates named objects that can be used elsewhere
// in your design code. While it is entirely up to you where
// you place module() definitions, I like to put them toward
// the end of a project. In a more complex project, modules()
// can be placed in separate files and "included" into
// the main project file.

// Look at the bottom of this file for the definition
// of the object used here, a complex widget.
translate([0,-50,10]) acme_widget_22();

// Here's an example of the acme_widget_22() module
// used in a programatic construct. First, the location
// of the group is set to (0, -100, 10) and then the
// group is constructed.

// The sine of the angle, i * 45, is used
// to calculate x, and the cosine, y. Multiplying a 
// constant, 10, by i increases z with each step.

hypothenuse = 30;
step_angle = 45;
translate([-80,-80,10]) 
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



// #### Part Five ####


// Other ways to build parts (Example 07)
// OpenSCAD has a few tricks for constructing objects
// that inolve the clever combination of geometric
// primitives, cubes, spheres, etc.

// The minkowski() command is one such tool. We are 
// going to use it to create a small box with rounded corners.

// First the basic shape is generated. You can change the size
// of the cylinders to alter the rounding of the corner.

translate([-50,0,0])
minkowski()
{
   cube([20,10,1], center=true);
   cylinder(r=4,h=2);
};

// Great. Let's build the box by defining the outer box
// as a minkowski() object then subtracting a slightly
// smaller box to leave 1mm walls.

translate([-60,60,0])
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

translate([-60,100,0])
difference(){
   cube([40,20,10], center=true);
   translate([0,0,1]) cube([38,18,10], center=true);
}

translate([-60,100,15]) 
union(){
   cube([40,20,2], center=true);
   translate(0,0,0) cube([38,18,4], center=true);
}


// Example 08
// Another way to build objects from primitives is 
// through the use of the hull() command. I used a 
// hull command in the acme_widget_22() module.
// Let's see how it works.

// Using a bit of trigonometry, we will arrange a group of 
// cylinders around an axis at 100, 100, 0. First, we will 
// define a small module.

module circle_of_columns() {
   hypothenuse = 30;
   step_angle = 45;

   for (i = [0 : 7])
   {
      translate([
         (sin(i * step_angle) * hypothenuse),
         (cos(i * step_angle) * hypothenuse), 
         0
   ])
   cylinder(r=2,h=2);
   };
}

// The we will position the construct and invoke the module

translate([100,100,20]) circle_of_columns();

// Let's try the same thing while placing the 
// circle_of_columns() module within a hull() 
// command. Note how the command constructs a polygon 
// by linking the columns.

translate([100,100,0]) hull() {circle_of_columns();}


// Example 09
// One could quickly build a model of a Roman city using 
// modules. Of course, it would be nice to be able to size
// the construct with some simple parameters. 
// Let's go back to the match_box() module and make a 
// few changes to the module. We'll call the module
// box_of_many_sizes(). See below the module section below.

translate([-200,0,0]) 
   box_of_many_sizes(50,20,10);

// We can automate box making with a nested for() loop
base_size_unit = 10;

translate([-230,30,0]) 
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



// #### Part Six ####

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

// linear_extrude  (Example 10)
translate([50,-50,0])
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
      circle(r=2, center = true);
}


// rotate_extrude() (Example 11)
// Extrusions can rotate around an axis, too, using the 
// rotate_extrude() command. Here we constuct a torus
// or doughnut, first defining a module,

module doughnut(section_radius = 1) {
   rotate_extrude(convexity = 10, $fn = 100)
   translate([2, 0, 0])
   circle(r = section_radius, $fn = 100);
}

translate([50,-75,0])
for(i = [0:9]){
   translate([0,0,i*4])
   doughnut(section_radius = 1);
}

// and a complex shape like one might produce with a lathe.
translate([70,-75,0])
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

translate([50,-120,0]) intersection()
   {
     scale(2){doughnut(section_radius = 1);}
     square(10, center=true);
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

