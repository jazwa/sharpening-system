




/*                    USER CONFIGURABLE VARIABLES

	Change these according to your situation. 
	All dimensions are in mm. Angles are in degrees. 
*/



// "Plate" here could also mean a sharpening stone. 
plateHeight = 2.4;
plateWidth  = 63.2;
plateLength = 152.3;



// This list determines the angle bracket jigs to generate. 
// Each value, d, here results in a bracket with angle d being 
// generated. Remove all values to not generate any brackets.
bracketAngles = [25, 30];


/*                 END OF USER CONFIGURABLE VARIABLES 

  
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




base();
// plate();



slackXY = 0.2;
slackZ = 0.05;

baseLengthExtraBack = 30;
baseLengthExtraFront = 8;
baseSideThickness = 1;

baseLength = plateLength + baseLengthExtraBack + baseLengthExtraFront;
baseWidth  = plateWidth + 2*baseSideThickness;
baseHeight = 20; 


bracketGuideRailWidth = 18;
bracketGuideRailDepression = 5;
bracketGuideRailWallThickness = 5;
bracketGuideRailWallHeight = 5;

module plate() {
	color("salmon")
	cube([plateLength, plateWidth, plateHeight]);
}

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

module bracket(angle) {
	// TODO
}
