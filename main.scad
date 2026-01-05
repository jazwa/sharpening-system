
/*                    
	USER CONFIGURABLE VARIABLES

	Change these according to your situation. 
	All dimensions are in mm. Angles are in degrees. 
*/



// "Plate" here could also mean a sharpening stone. 
plateHeight = 2.4;
plateWidth  = 63.5;
plateLength = 152.5;



// This list determines the angle bracket jigs to generate. 
// Each value, d, here results in a bracket with angle d being 
// generated. Remove all values to not generate any brackets.
bracketAngles = [25, 30];


/*                 
	END OF USER CONFIGURABLE VARIABLES 

  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠇
  ⠀⠀⠀⠀⠀⠙⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢟⠦⡀
  ⠀⠠⢤⣀⣀⡠⠛⢫⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠑⠢⢄⣀⡆
  ⠀⠀⠀⠙⡾⣥⠈⠀⡉⡆⠀⢠⠦⣀⠀⠀⠀⠀⠀⠀⠑⡄⠀⣸⠞⡇
  ⠀⠀⠀⠀⠸⠈⠳⡄⠀⢡⠀⠀⣎⠲⣙⣿⣶⠦⠀⠀⠀⠘⡄⠀⠀⢁
  ⠀⠀⠀⠀⠀⡏⠀⢈⠢⠘⡄⠀⠈⢦⠽⣻⠺⣆⣄⠀⠀⠀⡧⠁⠒⢞⡄
  ⠀⠀⠀⠀⢰⣆⣀⠤⡄⠀⠳⡀⠀⠀⠏⢟⢄⠉⣮⢦⠀⢀⡃⠠⠀⠀⢙⣦
  ⠀⠀⠀⠈⠉⢋⡉⠉⢀⠒⠂⢣⡀⠀⠀⢸⡄⠆⣮⣇⢀⠎⠀⠀⡀⢠⠂
  ⠀⠀⠀⠀⠀⠀⢃⡄⠀⢀⡄⠀⠙⠢⠤⡜⠠⠈⢰⣥⠊⠀⠐⠁⣔⡇
  ⠀⠀⠀⠀⠀⠀⢸⣶⠾⠓⠉⠑⡀⠁⣀⡄⠀⡀⢸⣹⠆⠀⠀⠀⢛⡂
  ⠀⠀⠀⠀⠀⠀⠞⠃⠀⠒⠒⢤⣄⡀⠋⢱⢀⠀⠸⢻⣭⢁⠔⠈⠙⡇
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣦⡆⡎⠜⣧⠿⣾⡃
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⠐⠀⣰⡜⠀⠘⡇
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠠⡍
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⣅⠐⠰⠋
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠀⡡⠒⠁
  ⠀⠀⠀⠀⠀⠀⠀⢀⣤⣋⣄⠤⠊
  ⠀⠀⠀⠀⠀⣠⣶⠟⠛⠉
  ⠀⠀⠀⣠⡾⠟
  ⠀⢠⡾⠋
  ⢠⠏
  ⡯
  ⠡  ... Here be Dragons ... */



// base();

// translate([0, 100, 0])
bracket(15);

eps = 0.00001;

slackXY = 0.2;
slackZ = 0.05;

baseLengthExtraBack = 35;
baseLengthExtraFront = 8;
baseSideThickness = 1;

baseLength = plateLength + baseLengthExtraBack + baseLengthExtraFront;
baseWidth  = plateWidth + 2*baseSideThickness;
baseHeight = 20; 


bracketGuideRailWidth = 18;
bracketGuideRailDepression = 5;
bracketGuideRailWallThickness = 5;
bracketGuideRailWallHeight = 4;
bracketGuideRailSlotWidth = bracketGuideRailWidth-2*bracketGuideRailWallThickness; 

module base() {

	module bracketGuideRail() {
		// Bottom of guide rail
		cube([baseLength, bracketGuideRailWidth, baseHeight-bracketGuideRailDepression]);

		// Walls of guide rail
		cube([
			baseLength, 
			bracketGuideRailWallThickness-slackXY, 
			baseHeight-bracketGuideRailDepression+bracketGuideRailWallHeight
		]);

		translate([0,bracketGuideRailWidth-bracketGuideRailWallThickness,0])
		cube([
			baseLength, 
			bracketGuideRailWallThickness, 
			baseHeight-bracketGuideRailDepression+bracketGuideRailWallHeight
		]);

		// // A stop at the back of the guide rail
		// translate([baseLength-5,0,baseHeight-bracketGuideRailDepression])
		// cube([5, bracketGuideRailWidth, bracketGuideRailWallHeight]);
	}

	difference() {

		union() {

			// Actual body of base
			cube([baseLength, baseWidth, baseHeight]);


			// Left and right guide rails
			translate([0, -bracketGuideRailWidth, 0])
			bracketGuideRail();
			
			translate([0, baseWidth+bracketGuideRailWidth, 0])
			mirror([0,1,0])
			bracketGuideRail();
		}

		union() {

			// Depression for sharpening plate
			translate([baseLengthExtraFront, baseSideThickness, baseHeight-plateHeight])
			translate([-slackXY/2, -slackXY/2, -slackZ/2])
			cube([plateLength+slackXY, plateWidth+slackXY, plateHeight+slackZ]);


			// Indent for removing plate from base
			indentWidth = 20;
			translate([0, (baseWidth-indentWidth)/2,baseHeight-plateHeight])
			cube([baseLengthExtraFront, indentWidth, plateHeight+slackZ]);
		}
	}


	
}

// Empty space between guide rails
guideRailSpace = baseWidth + 2*bracketGuideRailWallThickness;

guideRailClearance = 2;

guideRailTopZThickness = 3;
guideRailWallThickness = 3;

// bracketWidth = guideRailSpace + 2*bracketGuideRailSlotWidth+2*bracket;
bracketWidth = baseWidth+ 2*bracketGuideRailWidth;
bracketLength = 35;

// TODO: this is way too complicated
module bracket(angle) {

	bracketHeight = tan(angle)*bracketLength;

	module c000() { 
		translate([0, -bracketGuideRailSlotWidth+slackXY/2, 0]) 
		cube([guideRailWallThickness, bracketGuideRailSlotWidth-slackXY, guideRailTopZThickness]); 
	}
	module c010() { 
		translate([0, guideRailSpace+slackXY/2, 0]) 
		cube([guideRailWallThickness, bracketGuideRailSlotWidth-slackXY, guideRailTopZThickness]); 
	}
	
	module c001() { 
		translate([0, -bracketGuideRailSlotWidth+slackXY/2, bracketHeight]) 
		cube([eps, bracketGuideRailSlotWidth-slackXY, guideRailTopZThickness]); 
	}
	module c011() { 
		translate([0, guideRailSpace+slackXY/2, bracketHeight]) 
		cube([eps, bracketGuideRailSlotWidth-slackXY, guideRailTopZThickness]); 
	}
	
	module c100() {
		translate([bracketLength, -bracketGuideRailSlotWidth+slackXY/2, 0]) 
		cube([guideRailWallThickness, bracketGuideRailSlotWidth-slackXY, guideRailTopZThickness]); 
	}
	
	module c110() {
		translate([bracketLength, guideRailSpace+slackXY/2, 0]) 
		cube([guideRailWallThickness, bracketGuideRailSlotWidth-slackXY, guideRailTopZThickness]); 
	}

	difference () {

		// Actual bracket
		translate([0,bracketGuideRailSlotWidth, bracketGuideRailDepression+guideRailClearance])
		union() {
			// side
			hull() {
				translate([0,0,-bracketGuideRailDepression-guideRailClearance])
				c000();

				c001();
		
				translate([0,0,-bracketGuideRailDepression-guideRailClearance])
				c100();
		
				c100();
			}

			// side
			hull() {
				translate([0,0,-bracketGuideRailDepression-guideRailClearance])
				c010();

				c011();
		
				translate([0,0,-bracketGuideRailDepression-guideRailClearance])
				c110();
		
				c110();
			}

			// top
			hull() { c001(); c011(); c110(); c100(); }
		}


		// Angle text
		translate([2,1,1])
		rotate([90,0,0])
		linear_extrude(2)
		text(str(angle), size=8);
	}
}

