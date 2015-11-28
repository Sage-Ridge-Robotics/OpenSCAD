# OpenSCAD
Example OpenSCAD files from simple to complex for Sage Ridge Robotics. 

Tutorials: The Tutorial directory contains a series of eleven progressively more complex examples demonstrating the use of graphics primitives and various techniques to create composite objects from these primitives. It will be useful to have the documentation from openscad.org open alongside. 

  Example 01: Using cubes as graphic primitives.
  Example 02: Using cylinders as graphic primitives.
  Example 03: Using spheres as graphic primitives.
  Example 04: Using for loops to create distributed sets of objects.
  Example 05: Combining graphics primitives into complex objects using union(), difference(), and intersection().
  Example 06: Defining fuctions ("modules") for beautiful coding.
  Example 07: Clever constructions. using the minkowski() function.
  Example 08: Defining functions that take parameters ("variables").
  Example 09: More examples of module and for loop use.
  Example 10: Extruding and twisting 2D primitives. Could be fun with a licorice printer!
  Example 11: Extruding and rotating to create a 3D torus.

Tutorial — Pulleys: The Tutorial — Pulleys directory contains example code to generate and visualize simple pulleys.

  Pulleys: Example OpenSCAD program implementing a one parameter module ("function") to create printable pulley components.
  Pulley group: An example blender file for visualization
  Various STL examples of pulleys.

Tutorial — Parametric gears: The Tutorial — Parametric gears directory contains an example application to create gears in OpenSCAD demonstrating the use of variables to configure the size and other aspects of the gear design. Gears may be circular, cylindrical, wedge form, rack form, and helical. Variables include:

  1.  The width of the gear teeth.
  2.  The number of teeth per gear.
  3.  Gear thickness.
  4.  Center hole diameter (if the gear has a center hole).
  5.  Height.
  6.  Twist (for heliacal gears).
  7.  Number of teeth to hide (for partial gears, i.e. wedges).
  8.  The pressure angle of the gear teeth.
  9.  Clearance, the distance between the top of the tooth and bottom of the corresponding valley.
  10. Backlash, the gap between two meshing teeth, in the direction along the circumference of the pitch circle
  
  Functions are provided to calculate the pitch radius of the gear.

  Gears: Example OpenSCAD program implementing parametric gear design.
  
Information on gears can be found at:

  http://en.wikipedia.org/wiki/Involute_gear
  http://en.wikipedia.org/wiki/Gear
  http://en.wikipedia.org/wiki/List_of_gear_nomenclature
  
  
