// Two hours minus one latte and 2-3 rounds of payload

beefiness=3;

tabWidth=3;

brickHeight=52; // was 49.5, actual 50.927
brickWidth=34; // was 26.75, actual 33.3248
brickLength=115;

armWidth=33; // was 25.4, actual 31.75
armHeight=33;
armLength=brickLength;
armBuffer=6;

speakerPegDistance=100;
speakerPegDepth=6.3;
speakerPegWidth=3.5;
speakerSlotWidth=8.1; // was 8.4
speakerSlotLength=13;
speakerSlotDepth=speakerPegDepth + 3;

screwDiameterM3=3.2; // caliper says 0.112 inches / 2.8448 mm

bracketWidth=13;


module sBracket() {
    union() {
        difference() {
            
            cube([beefiness + armWidth + armBuffer + brickWidth + beefiness,
                    bracketWidth,
                    beefiness + brickHeight]);
            
            translate([beefiness, 0, 0])
            cube([armWidth,
                    bracketWidth,
                    armHeight]);
            
            translate([beefiness + armWidth + armBuffer, 0, beefiness])
            cube([brickWidth,
                    bracketWidth,
                    brickHeight]);
        }
    }
}

rotate([90, 0, 0])
union() {
    sBracket();
    
    translate([armWidth, 0, brickHeight + beefiness])
    cube([speakerSlotWidth, speakerSlotLength, speakerSlotDepth]);
}

rotate([90, 0, 0])
translate([0, 0, brickHeight+30])
difference() {
    sBracket();
    
    translate([armWidth + speakerSlotWidth/2, bracketWidth/2, brickHeight + beefiness - 10])
    cylinder(r=screwDiameterM3/2, h=10);
}
