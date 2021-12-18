fileDescription = "Solid State Relay Enclosure (x8)";
fileType = "SSR-8";
fileVersion = "1E";

// Designed to fit an 8 SSR board, QT PY mcu
// and CAP1188 Capacitive sensor board.

//The Belfry OpenSCAD Library
//https://github.com/revarbat/BOSL
include <BOSL/constants.scad>
use <BOSL/shapes.scad>

// using "high level trigger" so as to fail to "off"
// 8 solid state relay dimensions
// x=105, y=55, z=25
// z includes pins extending from PCB bottom
// mounting hole distance: x=100, y=50
// output jacks x=94, z=10

caseWidthX = 125;
caseDepthY = 80;
caseHeightZ = 32;
wallThickness = 3;

relayBoardMountX = 100;
relayBoardMountY = 50;
relayBoardOutputWidth = 94;

outputZ = 6; // height above Z-zero where connector is (works for both relay & cap board).

capBoardMountX = 36.83;
capBoardMountY = 12.7;
capBoardInputWidth = 20;
capBoardScrewDiameter = 2;

standoffSize = 5; // size of standoffs/mounts for boards and case enclosure
overlap = 1; // overlap ensures that subtractions go beyond the edges


// Using 2.5mm screws for boards and case
// M2.5* for relay board
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
         translate([-23, -28, 1])
          linear_extrude(2)
           text(fileType, size=5);
        color("whitesmoke")
         translate([-17,-34, 1])
          linear_extrude(2)
           text(fileVersion, size=5);
      }//emboss
    }//difference (base)

/* WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP

    //case screw mounts
    color("gold")
     translate([-(caseWidthX/2)+wallThickness, -(standoffSize/2), 1])
      cube([standoffSize,standoffSize,caseHeightZ-1.15]);
    color("gold")
     translate([+(caseWidthX/2)-wallThickness-standoffSize, -(standoffSize/2), 1])
      cube([standoffSize,standoffSize,caseHeightZ-1.15]);
    
*/ 

    //relay board mounts
    color("khaki")
     translate([-(relayBoardMountX/2)-(standoffSize/2), (relayBoardMountY/2)+standoffSize+wallThickness, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    color("khaki")
     translate([+(relayBoardMountX/2)-(standoffSize/2), (relayBoardMountY/2)+standoffSize+wallThickness, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    color("khaki")
     translate([-(relayBoardMountX/2)-(standoffSize/2), -(relayBoardMountY/2)+standoffSize+wallThickness, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    color("khaki")
     translate([+(relayBoardMountX/2)-(standoffSize/2), -(relayBoardMountY/2)+standoffSize+wallThickness, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
      
    //CAP1188 board mounts
    color("peachpuff")
     translate([0+0, -30+standoffSize, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    color("peachpuff")
     translate([0+capBoardMountX, -30+standoffSize, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    color("peachpuff")
     translate([0+0, -30+standoffSize-capBoardMountY, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    color("peachpuff")
     translate([0+capBoardMountX, -30+standoffSize-capBoardMountY, 1])
      cube([standoffSize,standoffSize,outputZ-2]);
    
   
  }//union
  

  // Start of Difference stuff ************************************************************

  //Relay output connections
  color("coral")
   translate([-(relayBoardOutputWidth/2),(caseDepthY/2)-wallThickness, outputZ])
    cube([relayBoardOutputWidth, (wallThickness*2), 8]);

  //CAP input connections
  color("coral")
   translate([+4,-(caseDepthY/2)-wallThickness, outputZ])
    cube([capBoardInputWidth, (wallThickness*2), 8]);

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
    
  //screw holes for relay board mounts
  color("orangered")
   translate([-(relayBoardMountX/2), +(relayBoardMountY/2)+standoffSize+(standoffSize/2)+wallThickness, (wallThickness/2)])
    cylinder(h=outputZ, d=mountingScrewDiameter);
  color("orangered")
   translate([+(relayBoardMountX/2), +(relayBoardMountY/2)+standoffSize+(standoffSize/2)+wallThickness, (wallThickness/2)])
    cylinder(h=outputZ, d=mountingScrewDiameter); 
  color("orangered")
   translate([-(relayBoardMountX/2), -(relayBoardMountY/2)+standoffSize+(standoffSize/2)+wallThickness, (wallThickness/2)])
    cylinder(h=outputZ, d=mountingScrewDiameter);
  color("orangered")
   translate([+(relayBoardMountX/2), -(relayBoardMountY/2)+standoffSize+(standoffSize/2)+wallThickness, (wallThickness/2)])
    cylinder(h=outputZ, d=mountingScrewDiameter); 
    
  //screw holes for cap board mounts
  color("orangered")
   translate([(standoffSize/2), -30+(standoffSize*1.5), (wallThickness/2)])
    cylinder(h=outputZ, d=capBoardScrewDiameter);
  color("orangered")
   translate([(standoffSize/2)+capBoardMountX, -30+(standoffSize*1.5), (wallThickness/2)])
    cylinder(h=outputZ, d=capBoardScrewDiameter);
  color("orangered")
   translate([(standoffSize/2), -30+(standoffSize*1.5)-capBoardMountY, (wallThickness/2)])
    cylinder(h=outputZ, d=capBoardScrewDiameter);
  color("orangered")
   translate([(standoffSize/2)+capBoardMountX, -30+(standoffSize*1.5)-capBoardMountY, (wallThickness/2)])
    cylinder(h=outputZ, d=capBoardScrewDiameter);


    
  //-------------------------------------------------------------------------------------------------------

  splitAtZ=14; 
  
  //remove the top for split
  color("crimson")  translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);
  // ******* OR ******
  //Remove everything but the top
  //color("crimson") translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ-caseHeightZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);

  //-------------------------------------------------------------------------------------------------------
  
  
}//difference
  