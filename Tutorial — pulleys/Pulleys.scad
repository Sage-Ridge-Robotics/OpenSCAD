/*

Sage Ridge Robotics OpenSCAD file.
Christopher von Nagy, July 2014.

Pulleys example. Version 0.1

Usage: pulley_wheel(diameter in mm);

3"   = 76.20mm
2"   = 50.80mm
1"   = 25.40mm
3/4" = 19.05mm
1/2" = 12.70mm

*/


pulley_wheel(25.4);


// Modules
module pulley_wheel(wheel_diameter = 50.8) {

   assign(

     wheel_radius = wheel_diameter/2,
     wheel_thickness = 4,
     belt_guide = wheel_thickness/2,
     shaft_radius = 3.175/2,
     screw_radius = 2.845/2,
     step_angle = 90,
     hub_radius = 6,
     mount_holes_01 = 9.78,
     mount_holes_02 = 19.05

   ){

      translate([0,0,wheel_thickness/2])

      difference(){    

         union(){

            // Wheel and hub
            cylinder(r=wheel_radius, h=wheel_thickness, center=true, $fn=100);
            translate([0,0,wheel_thickness/2])
            cylinder(r=hub_radius, h=wheel_thickness+4, center=true, $fn=100);

         }

         // Remove drive shaft
         cylinder(r=shaft_radius, h=wheel_thickness*3, center=true, $fn=100);

         // Remove screw hole in drive shaft hub
         translate([shaft_radius*2,0,wheel_thickness]) 
            rotate([0,90,0])
            cylinder(r=1, h=hub_radius, center=true, $fn = 100);

         // Remove drive belt guide
         rotate_extrude(convexity = 10, $fn = 100)
            translate([wheel_radius, 0, 0])
            circle(r = belt_guide, center=true, $fn = 100);

         // Drill inner set of mounting screw holes for Acrobotics system
         if (wheel_diameter >= 19.05) {
            for (i = [0 : 3]) {
               translate([
                  (sin(i * step_angle) * mount_holes_01),
                  (cos(i * step_angle) * mount_holes_01), 
                  0
               ])
               cylinder(
                  r=screw_radius,
                  h=wheel_thickness * 1.5, 
                  center=true, 
                  $fn=100
               );
            }
         }

         // Drill outer set of mounting screw holes for Acrobotics system
         if (wheel_diameter >= 38.1) {
            for (i = [0 : 3]) {
               translate([
                  (sin(i * step_angle + 45) * mount_holes_02),
                  (cos(i * step_angle + 45) * mount_holes_02), 
                  0
               ])
               cylinder(
                  r=screw_radius,
                  h=wheel_thickness * 1.5, 
                  center=true, 
                  $fn=100
               );
            }
         }

      }

   }
}


   
/*

License code:

Creative Commons Atribution 4.0

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


*/