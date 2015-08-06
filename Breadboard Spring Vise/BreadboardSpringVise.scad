$fn=60;

t=3;    // Thickness
tt=t+t; // Thickness * 2

breadboardWidth=56.3;
breadboardLength=165.1;
breadboardHeight=9.6;

rodWidth=8;
rodLength=breadboardWidth*1.2;

baseHeight=8;


module rod (rodWidth, rodLength) {
  rotate([60,0,0]) rotate([0, 90, 0])
    cylinder(h=rodLength, r=rodWidth/2, $fn=3);
}


module outerJaw (length) {
  difference () {
    cube([tt, length, tt]);
    translate([tt*0.9,0,0])
      cube([tt, length, tt]);
    translate([t*1.3, 0, t])
      rotate([0,45,0])
      cube([tt, length, tt]);
  }
}

module jawAssembly () {
  union() {
    translate([0, breadboardLength*0.025/2, tt])
      outerJaw(breadboardLength*0.89/2);
    
    translate([0, breadboardLength*0.025/2, -1.4])
      union() {
      difference() {
        cube([tt*0.9, breadboardLength*0.89/2, tt+1.4]);
        translate([0, 0.5, 0])
          translate([-2, breadboardLength/11*3 - t*3 +1, tt*0.9]) // -3 for lazy
          rotate([45,0,0])
          rotate([180,0,0])
          cube([tt+4, tt+2, tt+2]);
      }
      
      translate([0, -3.15, 0])
        translate([t, breadboardLength/11*3 -tt*0.75, 0]) // -3 for lazy
        cylinder(r1=t*1.5/2, r2=t*0.4, h=tt);
      
      translate([t,-2,0])
        cylinder(r=4, h=0.6);
      translate([t, breadboardLength*0.89/2+2,0])
        cylinder(r=4, h=0.6);
    }
    
    translate([tt*0.9, -3, 1])  // Why is this 1mm?
      difference() {
      union() {
        translate([0, -3.15, 0])
          translate([-1, breadboardLength/11*1, -0.4]) // 0.24 is too magic
          union() {
          rod(rodWidth, rodLength);
          translate([rodLength+3.5, 0, -2]) // 0.24 is too magic
            cylinder(r=4, h=0.6);
        }

        translate([0, -3.15, 0])
          translate([-1, breadboardLength/11*4, -0.4])      
          union() {
          rod(rodWidth, rodLength);
          translate([rodLength+3.5, 0, -2]) // 0.24 is too magic
            cylinder(r=4, h=0.6);
        }
      }
      translate([0, 0, 1.5])
        cube([breadboardLength, rodLength, 4]);
    }
  }

}

module base () {
  union() {
    difference() {

      union() {
        cube([breadboardWidth, breadboardLength, baseHeight]);
      
        translate([breadboardWidth, 0, tt+3.5])
          outerJaw(breadboardLength);
        translate([breadboardWidth, 0, 0])
          cube([tt, breadboardLength, tt+3.5]);

        translate([0, 0, tt*2+3.5])  //  Too much magic because of the 3 sided cylinders
          rotate([0, 180,0])
          outerJaw(breadboardLength);
        translate([-tt, 0, 0])
          cube([tt, breadboardLength, tt+3.5]);
      }

      translate([(breadboardWidth-t)/2, 0, 0])
        cube([t, breadboardLength, t/2]);
        
      translate([t, t, tt])
        cube([breadboardWidth-tt, breadboardLength-tt, breadboardHeight]);

      translate([0, 0, tt])
        cube([breadboardWidth, breadboardLength, breadboardHeight]);

    
      for (i= [1:10]) {
        translate([-tt-1, breadboardLength/11*i, t*1.5])
          rod(rodWidth*1.18, 2+rodLength+tt*2);
      }
    }
  }
}


//base();

jawAssembly();
