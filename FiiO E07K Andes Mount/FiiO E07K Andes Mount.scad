include <MCAD/boxes.scad>

width=55;
length=90;
height=14.53;

edgeRadius=3;

thickness=4;
tabwidth=2.5;
volumeButtonDistance=13;
buttonLength=44.9;
buttonRadius=5.5;
buttonHeight=1;

footFromEdge=3.3;
footWidth=8.4;
footHeight=17-height;

micRubberDiameter=9.96;
micRubberLen=3;
micHexLen=22;
micHexDia=11.5;
micThinRubDiameter=7.75;
micThinRubLen=18;
wireDia=3.35;

bumpRadius=3.3/2;

union() {
    difference() {
        union() {
            translate([(width+thickness*2)/2, (length+thickness*2)/2, (height+thickness*2)/2])
            roundedBox([width+thickness*2, length+thickness*2, height+thickness*2], edgeRadius);

            translate([(width+thickness*2)/2, (length+thickness*2)/2, thickness/2])
            roundedBox([width+thickness*2, length+thickness*2, thickness], edgeRadius, true);
        } 
        
        translate([thickness, thickness, thickness])
        cube([width, length, height]);

        translate([thickness-buttonHeight, 0, height/2+thickness-buttonRadius])
        cube([width+buttonHeight, length, buttonRadius*2]);
        
        translate([thickness+tabwidth, -1, thickness])
        cube([width - ( (tabwidth)*2),
                length*2,
                height*2]);
        
        translate([-.1, volumeButtonDistance, thickness])
        cube([width*2, buttonLength, height*2]);
        
        translate([thickness,0,thickness])
        cube([width, thickness*2+tabwidth*2, height]);

        translate([footFromEdge+thickness, 0, thickness-footHeight])
        cube([footWidth, length+footFromEdge, footHeight+1]);        

        translate([width-footWidth, 0, thickness-footHeight])
        cube([footWidth, length+footFromEdge, footHeight+1]);        

        translate([width/2 + thickness, (length + 2*thickness)/3, 0])
        cylinder(r=2.54/2, h=10);
        
        translate([width/2 + thickness, (length + 2*thickness)/3*2, 0])
        cylinder(r=2.54/2, h=10);

        translate([width/2 + thickness, (length + 2*thickness)/3, thickness-1.8;])
        cylinder(r=5.3/2, h=10);
        
        translate([width/2 + thickness, (length + 2*thickness)/3*2, thickness-1.8])
        cylinder(r=5.3/2, h=10);
    }

    difference() {
        translate([-(thickness*2+micHexDia), edgeRadius, 0])
        cube([micHexDia+thickness*2, length+thickness/2, height/2+thickness]);


        rotate(a=[-90,0,0])
        translate([-(thickness+micHexDia/2), -(thickness+micHexDia/2), edgeRadius-0.2])
        union() {
            cylinder(r=wireDia/2, h=length+10);
            
            translate([-(wireDia*0.9/2), -(thickness+micHexDia/2+wireDia+2), micRubberLen+micHexLen+micThinRubLen])
            cube([wireDia*0.9, height, length]);

            cylinder(r=micRubberDiameter/2, h=micRubberLen);

            translate([0, 0, micRubberLen])
            cylinder(r=micHexDia/2, h=micHexLen);

            translate([0, 0, micRubberLen+micHexLen])
            cylinder(r=micThinRubDiameter/2, h=micThinRubLen+1);
            
        }

    }

    translate([thickness*3+footWidth, bumpRadius, thickness])
    sphere(r=bumpRadius);

    translate([width-footWidth-thickness, bumpRadius, thickness])
    sphere(r=bumpRadius);
}