poleDiameter=48.3; // 1.9"

baseWidth=100.6; // 3.960"
baseToBack=57.3;

centerToBack=poleDiameter/2+baseToBack;

cablePass=19;
cablePassHeight=40;

holeWidth=28; // 1.130"
dooberHeight=25;
heightToHole=60; // guesstimate

snapHeight=1.4; //guesstimate
snapWidth=1.4;

thickness=3;
height=124; // 5.0"

$fn=100;

module solidCover() {
    difference() {

        union() {
            hull() {
                cylinder(r=poleDiameter/2, h=height);
                translate([0,baseToBack,thickness/2])
                cube([poleDiameter+thickness*2, cablePass, thickness], center=true );
            }

            translate([0, baseToBack, -cablePassHeight/2])
            cube([poleDiameter+thickness*2, cablePass, cablePassHeight], center=true);
        }
    
        translate([0,0,-2])
        cylinder(r=poleDiameter/2, h=height*2);
    }
}

module snapDoober() {
    translate([-holeWidth/2, 0, heightToHole])
    difference() {
        union() {
            cube([holeWidth, 40, dooberHeight]);

            translate([0, -snapWidth*2, 0])
            for (i = [0 : 7]) {
                translate([-snapHeight, i *2 + snapWidth , 0])
                cube([holeWidth+snapHeight*2, snapWidth, dooberHeight]);
            }
        }

        translate([4, -2, 0])
        cube([holeWidth-8, 25, dooberHeight+2]);
    }
}

         
module hollowCover() {
    difference() {
        solidCover();
        scale([0.85, 0.92, 0.85]) translate([0, 0, -12]) solidCover();
    }
}


module fullCover() {
    difference() {
        union() {
            difference() {
                hollowCover();
                translate([-450,-13,-450])
                cube([900,20,900]);
            }

            difference() {
                snapDoober();

                for (i = [1 : 5]) {
                    translate([0, i*2, 0]) hollowCover();
                }
            }
        }

        // Take a few mm off the top
        translate([-100,0,120])
        cube([200,200,20]);
    }
}

module testSlice() {
    difference() {
        fullCover();

        translate([-50,-50,5])
        cube([300,200,300]);

        translate([-50,-50,-308])
        cube([300,200,300]);
    }
}

fullCover();
