include <BOSL/constants.scad>
use <BOSL/shapes.scad>

fileDescription = "Solid State Relay Enclosure";
fileType = "SSR-4";
fileVersion = "1B";

numberOfRelays = 4; // or 8

caseWidthX = 75;
caseDepthY = 70;
caseHeightZ = 30;
wallThickness = 3;

outputZ = 7; // 

overlap = 1; // overlap ensures that subtractions go beyond the edges
  
mountingScrewDiameter = 2.5; // M2.5
mountingScrewHeadDiameter = 4.5; // M2.5
mountingScrewHeadHeight = 2.7; // M2.5 

emboss = true;
  
$fn=60; //circle smoothness
  
difference(){
  union() {
    difference(){
      //base
      //rounded cuboid is from the BOSL library
      //I'm using p1 setting to zero bottom (z). X/Y are centered on 0,0,0
      color("steelblue")
      cuboid([caseWidthX,caseDepthY,caseHeightZ], fillet=4, 
       p1=[-(caseWidthX/2), -(caseDepthY/2), 0]);
      //subtract out the inner cuboid
      cuboid([caseWidthX-wallThickness,caseDepthY-wallThickness,caseHeightZ-wallThickness], fillet=4, 
       p1=[-((caseWidthX-wallThickness)/2), -((caseDepthY-wallThickness)/2), (wallThickness/2)]);
      if (emboss) {
        //emboss version on inside case
        color("whitesmoke")
         translate([-10, 0, 1])
          linear_extrude(2)
           text(fileType, size=5);
        color("whitesmoke")
         translate([-4,-6, 1])
          linear_extrude(2)
           text(fileVersion, size=5);
      }//emboss
    }//difference (base)

    //case screw mounts
    color("gold")
     translate([-(caseWidthX/2)+wallThickness, -2.5, 1])
      cube([5,5,caseHeightZ-1.15]);
    color("gold")
     translate([+(caseWidthX/2)-wallThickness-5, -2.5, 1])
      cube([5,5,caseHeightZ-1.15]);

    //board mounts
    color("khaki")
     translate([-26-2.5, 28, 1])
      cube([5,5,outputZ-1]);
    color("khaki")
     translate([+26-2.5, 28, 1])
      cube([5,5,outputZ-1]);
    color("khaki")
     translate([-26-2.5, -22, 1])
      cube([5,5,outputZ-1]);
    color("khaki")
     translate([+26-2.5, -22, 1])
      cube([5,5,outputZ-1]);
   
  }//union
  

  // Start of Difference stuff ************************************************************

  //External output connections
  color("coral")
   translate([-23,32,outputZ])
    cube([46, (wallThickness*2), 8]);

  //screw holes for case (goes through top of case)
  color("tomato")
   translate([-(caseWidthX/2)+wallThickness+2.5, 0, wallThickness])
    cylinder(h=caseHeightZ+overlap, d=mountingScrewDiameter);
  color("tomato")
   translate([+(caseWidthX/2)-wallThickness-2.5, -0, wallThickness])
    cylinder(h=caseHeightZ+overlap, d=mountingScrewDiameter);
  
  //countersinks
  color("darkorange")
   translate([-(caseWidthX/2)+wallThickness+2.5, 0, caseHeightZ-(mountingScrewHeadHeight/2)])
    cylinder(h=mountingScrewHeadHeight+overlap, d=mountingScrewHeadDiameter);
  color("darkorange")
   translate([+(caseWidthX/2)-wallThickness-2.5, -0, caseHeightZ-(mountingScrewHeadHeight/2)])  
    cylinder(h=mountingScrewHeadHeight+overlap, d=mountingScrewHeadDiameter);
    
  //screw holes for board mounts
  color("orangered")
   translate([-26, +30.5, 2])
    cylinder(h=outputZ, d=mountingScrewDiameter);
  color("orangered")
   translate([+26, +30.5, 2])
    cylinder(h=outputZ, d=mountingScrewDiameter); 
  color("orangered")
   translate([-26, -19.5, 2])
    cylinder(h=outputZ, d=mountingScrewDiameter);
  color("orangered")
   translate([+26, -19.5, 2])
    cylinder(h=outputZ, d=mountingScrewDiameter); 
    
  //-------------------------------------------------------------------------------------------------------

  splitAtZ=15; //actual top of usb opening is 10.75
  
  //remove the top for split
  color("crimson")  translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);
  // ******* OR ******
  //Remove everything but the top
  //color("crimson") translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ-caseHeightZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);

  //-------------------------------------------------------------------------------------------------------
  
  
}//difference
  