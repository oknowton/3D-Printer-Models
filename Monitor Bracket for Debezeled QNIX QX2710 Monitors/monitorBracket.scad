angle=131;
height=11;
length=22;
width=9.5;
t=2;
tt=t*2;

plugOffset=5;
heightToPlug=2;
plugWidth=13;

module monitorBracket(plug) {
    difference() {
        union() {
            cube([length, width+tt, height+tt], center=false);

            rotate(a=[0,0,-angle])
            translate([0,-width-tt,0])
            cube([length, width+tt, height+tt], center=false);

            hull(){
                cube([0.1, width+tt, height+tt], center=false);

                rotate(a=[0,0,-angle])
                translate([0,-width-tt,0])
                cube([0.1, width+tt, height+tt], center=false);
            }
        }

        translate([-1.2, t, t])
        cube([length*2, width, height*2], center=false);

        rotate(a=[0,0,-angle])
        translate([-1.2,-width-t,t])
        cube([length*2, width, height*2], center=false);

        if(plug) {
            rotate(a=[0,0,-angle])
            translate([plugOffset, -width-tt-1, t+heightToPlug])
            cube([plugWidth, width+1, height*2], center=false);
        }
    

    }
}

monitorBracket(1);

translate([-15,25,0])
monitorBracket(0);