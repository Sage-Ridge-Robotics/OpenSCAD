/* 

Example gear design file.

A nice example of how to create parametric spur gears for 
3D protoyping. This file was originally developed Leemon Baird 
(Leemon@Leemon.com) and contributed to thingiverse in 2011
http://www.thingiverse.com/thing:5505 under the title of
Public Domain Parametric Involute Spur Gear (and involute 
helical gear and involute rack) version 1.1. 

This file has been modified for Sage Ridge Robotics
by Christopher von Nagy (July 2014). 

Copyright Leemon Baird (2011) and
Christopher von Nagy (2014)

This modified version is released under the terms of the 
Creative Commons Attribution 4.0 (CC by 4.0). 


I have moved the original and Creative Commons license text to 
the end of the file for readability and heavily edited 
Leemon Baird's text adding some comments along the way. 
I have added an inner cylinder on the gears to facilitate 
mounting to 1/8 inch rods (this can be changed as needed in the 
parameters, as always inmillimeters) and screw mount holes 
consistent with our robotics materials. 



This file will export a single object in stl, so do not
use it to print gears. You must modify it.

Tthe positioning of the screw holes must be modified for 
correct use with servos, 

For Leemon Baird's discussion of gears, see the end of this file.

*/


// Modifiable paramenters

// All sizes are in millimeters (float). 

// Number of teeth for each gear
// The number of teeth works in conjunction with the tooth
// width to determine the size of the pitch circle.
// See Leemon Baird's discussion at the end for definitions.
n1 = 50;  // Big green gear
n2 = 30;  // Medum red gear 3:5 mechanical advantage with green gear
n3 = 25;  // Small blue gear 1:2 mechanical advantage with green gear
n4 = 50;  // Gray rack

// Width of teeth. Any meshing gears require identical tooth width and
// pressure_angle settings. 
mm_per_tooth = 4;

// 4mm is a decent thickness for the gears. 
thickness = 4;

// The center hole is set to 3.175 or 1/8 inch
hole = 3.175;


// 
height = 12;

// Twist defines the angle of the teeth. A twist of 360 turns the
// gear into a screw gear.
twist = 0;

// teeth_to_hide allows you to define a partial gear (wedge)
teeth_to_hide = 0;

// Clearance is the gap between top of a tooth on one gear and 
// bottom of valley on a meshing gear (in millimeters)
clearance = 0;

// backlash os the gap between two meshing teeth, in the direction 
// along the circumference of the pitch circle
backlash = 0;



// The pitch_radius function is necessary if we wish to
// model a working gear system in OpenSCAD. This is
// not necessary if you are designing a set of gears to
// print and actually use.
d1 = pitch_radius(mm_per_tooth,n1);
d2 = pitch_radius(mm_per_tooth,n1) + pitch_radius(mm_per_tooth,n2);
d3 = pitch_radius(mm_per_tooth,n1) + pitch_radius(mm_per_tooth,n3);


// Big green gears
   translate([0, 0, 0]) 
      color([0.0,1.00,0.0]) 
      gear(mm_per_tooth, n1, thickness, hole, 0, 108);

// Medium red gears
   translate([d2, 0, 0])
      rotate([0,0,-($t+n2/2-0*n1+1/2)*360/n2])
      color([1.00,0.00,0.00]) 
      gear(mm_per_tooth, n2, thickness, hole);

// Small blue gears
   translate([0, d3, 0]) 
      color([0.00,0.00,1.00]) 
      gear(mm_per_tooth, n3, thickness, hole);

// Gray racks
   translate([-mm_per_tooth/2, -d1, 0]) 
      color([0.60,0.60,0.60]) 
      rack(mm_per_tooth, n4, thickness, height);


/*

Modules. Note how linear_extrude is used to create a 
gear from a polygon outline. Twist is a function
defined in the linear_extrude command.

Holes are added for connection to the robotics set. Their size
can be modified as required. The default size, here, should
fit a 4-40 screw.

*/

module gear (
	mm_per_tooth    = 3,    
	number_of_teeth = 11,   
	thickness       = 6,    
	hole_diameter   = 10,    
	twist           = 0,    
	teeth_to_hide   = 0,    
	pressure_angle  = 28,   
	clearance       = 0.0,
	backlash        = 0.0
) {
	
   assign(pi = 3.1415926)
   assign(p  = mm_per_tooth * number_of_teeth / pi / 2)  
   assign(c  = p + mm_per_tooth / pi - clearance)
   assign(b  = p*cos(pressure_angle))
   assign(r  = p-(c-p)-clearance)
   assign(t  = mm_per_tooth/2-backlash/2) 
   assign(k  = -iang(b, p) - t/2/p/pi*180) 
   assign(screw_radius = 2.845/2)

   difference() {
      union() {
         for (i = [0:number_of_teeth-teeth_to_hide-1] )
            rotate([0,0,i*360/number_of_teeth])
            linear_extrude(
               height = thickness, 
               center = true, 
               convexity = 10, 
               twist = twist
            )
            polygon(
               points=[[0, -hole_diameter/10],
                  polar(r, -181/number_of_teeth),
                  polar(r, r<b ? k : -180/number_of_teeth),
                  q7(0/5,r,b,c,k, 1),
                  q7(1/5,r,b,c,k, 1),
                  q7(2/5,r,b,c,k, 1),
                  q7(3/5,r,b,c,k, 1),
                  q7(4/5,r,b,c,k, 1),
                  q7(5/5,r,b,c,k, 1),
                  q7(5/5,r,b,c,k,-1),
                  q7(4/5,r,b,c,k,-1),
                  q7(3/5,r,b,c,k,-1),
                  q7(2/5,r,b,c,k,-1),
                  q7(1/5,r,b,c,k,-1),
                  q7(0/5,r,b,c,k,-1),
                  polar(r, r<b ? -k : 180/number_of_teeth),
                  polar(r, 181/number_of_teeth)],
            paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]
         );
         translate ([0,0,thickness/2]) cylinder(
            h=8, 
            r=5, 
            center=true, 
            $fn=100
         );
         }

         cylinder(
            h=2*thickness+8, 
            r=hole_diameter/2, 
            center=true, 
            $fn=100);

         if (pitch_radius(mm_per_tooth, number_of_teeth) >= 16){
            translate([0,9.78,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
            translate([0,-9.78,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
            translate([9.78,0,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
            translate([-9.78,0,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
         }

         if (pitch_radius(mm_per_tooth, number_of_teeth) >= 25){
            translate([0,19,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
            translate([0,-19,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
            translate([19,0,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
            translate([-19,0,0]) cylinder(
               h=2*thickness, 
               r=screw_radius,
               center=true,
               $fn=100
            );
         }


   } 
};	



module rack (
	mm_per_tooth    = 3,
	number_of_teeth = 11,
	thickness       = 6,
	height          = 120,
	pressure_angle  = 28,
	backlash        = 0.0
) {

   assign(pi = 3.1415926)
   assign(a = mm_per_tooth / pi)
   assign(t = a*cos(pressure_angle)-0.5)

   difference() {
   
      union () {
         for (i = [0:number_of_teeth-1] )
            translate([i*mm_per_tooth,0,0])
            linear_extrude(height = thickness, center = true, convexity = 10)
            polygon(
               points=[
                  [-mm_per_tooth * 3/4, a-height],
                  [-mm_per_tooth * 3/4 - backlash, -a],
                  [-mm_per_tooth * 1/4 + backlash - t, -a],
                  [-mm_per_tooth * 1/4 + backlash + t, a],
                  [ mm_per_tooth * 1/4 - backlash - t, a],
                  [ mm_per_tooth * 1/4 - backlash + t, -a],
                  [ mm_per_tooth * 3/4 + backlash, -a],
                  [ mm_per_tooth * 3/4, a-height],
               ],
               paths=[[0,1,2,3,4,5,6,7]]
            );
      }
      for (i = [0:((number_of_teeth*mm_per_tooth)/11.15)] )
         translate([(i*11.15+(2.45)),(a-height/1.5),(thickness/4)])
         cylinder(
            h=2*thickness+1, 
            r=2.845/2,
            $fn=100,
            center = true
         );
   }
};	



/*

Functions required by the gear module

*/

//convert polar to cartesian coordinates
function polar(r,theta)
   = r*[sin(theta), cos(theta)]; 

//unwind a string this many degrees to go from radius r1 to radius r2                          
function iang(r1,r2)
   = sqrt((r2/r1)*(r2/r1) - 1)/3.1415926*180 - acos(r1/r2);

//radius a fraction f up the curved side of the tooth 
function q7(f,r,b,r2,t,s) 
   = q6(b,s,t,(1-f)*max(b,r)+f*r2);

//point at radius d on the involute curve                          
function q6(b,s,t,d)      = polar(d,s*(iang(b,d)+t));                              



/*

User functions

These 5 functions let the user find the derived dimensions of the gear.
A gear fits within a circle of radius outer_radius, and two gears 
should have their centers separated by the sum of their pictch_radius.

function circular_pitch  (mm_per_tooth=3) = mm_per_tooth;                     

*/

//tooth density expressed as "circular pitch" in millimeters
function diametral_pitch (mm_per_tooth=3) 
   = 3.1415926 / mm_per_tooth;

//tooth density expressed as "diametral pitch" in teeth per millimeter
function module_value (mm_per_tooth=3) 
   = mm_per_tooth / pi;

//tooth density expressed as "module" or "modulus" in millimeters
function pitch_radius (mm_per_tooth=3,number_of_teeth=11) 
   = mm_per_tooth * number_of_teeth / 3.1415926 / 2;

//The gear fits entirely within a cylinder of this radius.
function outer_radius (mm_per_tooth=3,number_of_teeth=11,clearance=0.1) 
    = mm_per_tooth*(1+number_of_teeth/2)/pi -clearance;              



/*

License

This file is public domain.  Use it for any purpose, including 
commercial applications.  Attribution would be nice, but is not 
required.  There is no warranty of any kind, including its 
correctness, usefulness, or safety.

*/



/*

Development history

2014
Code clean up and example use rewrite.


2011
This is parameterized involute spur (or helical) gear.  It is much simpler and less powerful than others on Thingiverse.  But it is public domain.  I implemented it from scratch from the descriptions and equations on Wikipedia and the web, using Mathematica for calculations and testing, and I now release it into the public domain.

http://en.wikipedia.org/wiki/Involute_gear
http://en.wikipedia.org/wiki/Gear
http://en.wikipedia.org/wiki/List_of_gear_nomenclature
http://gtrebaol.free.fr/doc/catia/spur_gear.html
http://www.cs.cmu.edu/~rapidproto/mechanisms/chpt7.html

*/

/*

The module gear() gives an involute spur gear, with reasonable defaults for all the parameters. Normally, you should just choose the first 4 parameters, and let the rest be default values. The module gear() gives a gear in the XY plane, centered on the origin, with one tooth centered on the positive Y axis.  The various functions below it take the same parameters, and return various measurements for the gear.  The most important is pitch_radius, which tells how far apart to space gears that are meshing, and adendum_radius, which gives the size of the region filled by the gear. 

A gear has a "pitch circle", which is an invisible circle that cuts through the middle of each tooth (though not the exact center. In order for two gears to mesh, their pitch circles should just touch.  So the distance between their centers should be pitch_radius() for one, plus pitch_radius() for the other, which gives the radii of their pitch circles.

In order for two gears to mesh, they must have the same mm_per_tooth and pressure_angle parameters. mm_per_tooth gives the number of millimeters of arc around the pitch circle covered by one tooth and one space between teeth.  The pitch angle controls how flat or bulged the sides of the teeth are.  Common values include 14.5 degrees and 20 degrees, and occasionally 25.  Though I've seen 28 recommended for plastic gears. Larger numbers bulge out more, giving stronger teeth, so 28 degrees is the default here.

The ratio of number_of_teeth for two meshing gears gives how many times one will make a full revolution when the the other makes one full revolution.  If the two numbers are coprime (i.e. are not both divisible by the same number greater than 1), then every tooth on one gear will meet every tooth on the other, for more even wear.  So coprime numbers of teeth are good.

The module rack() gives a rack, which is a bar with teeth.  A rack can mesh with any gear that has the same mm_per_tooth and pressure_angle.


Some terminology: 
pitch circle: The outline of a gear is a smooth circle (the "pitch circle") which has mountains and valleys added so it is toothed.  

Root circle: There is an inner circle (the "root circle") that touches the base of all the teeth

Outer circle: An outer circle touches the tips of all the teeth, and the invisible pitch circle in between them.  

Base circle: There is also a "base circle", which can be smaller than all three of the others, which controls the shape of the teeth.  The side of each tooth lies on the path that the end of a string would follow if it were wrapped tightly around the base circle, then slowly unwound. 

That shape is an "involute", which gives this type of gear its name.

*/

/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/






