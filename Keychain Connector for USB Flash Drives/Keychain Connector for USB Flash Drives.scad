
insideThickness=2.16;       // 0.085 inches
insideWidth=11.35;          // 0.447 inches

outsideThickness=4.52;      // 0.178 inches
outsideWidth=insideWidth;   // Easier to print on its side
connectorThickness=0.35;

ringhole=4.1;               // Measures at 0.125 inches.  Sized up a bit to actually fit
depth=7;                    // Measures about 8-9mm max


module usbThing (cScale) {
    rotate(a=[90, -90, 0])
    union() {
        cube([insideThickness*cScale, insideWidth, depth]);
        
        translate([0, -connectorThickness, -ringhole-8])
        difference() {
            cube([outsideThickness, outsideWidth+connectorThickness*2, ringhole+8]);
            
            rotate(a=[-90, 0, 90])
            translate([outsideWidth/2, -2-ringhole*1.25/2, -outsideThickness/2])
            cylinder(r=ringhole/2, h=outsideThickness*1.05, center=true);
        }
    }
}

usbThing(1);  // Print at 100% scale

// Print smaller copies in 2% increments
//
// translate([20, 0, 0])
// usbThing(0.98);
//
// translate([40, 0, 0])
// usbThing(0.96);
//
// translate([60, 0, 0])
// usbThing(0.94);
//
// translate([80, 0, 0])
// usbThing(0.92);