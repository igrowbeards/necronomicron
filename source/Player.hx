package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class Player extends FlxSprite
{
	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(14,14,0xff224330);

		if (FlxG.getPlugin(FlxControl) == null) {
			FlxG.addPlugin(new FlxControl());
		}

		// The player sprite will accelerate and decelerate smoothly
		FlxControl.create(this, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT, 1, true, false);
		// Enable cursor keys, but only the left and right ones
		FlxControl.player1.setCursorControl(true,true,true,true);
		// All speeds are in pixels per second, the follow lets the player run left/right
		FlxControl.player1.setStandardSpeed(100);

	}

	override public function update() {
		if (x > FlxG.width - width) {
			x = FlxG.width - width;
		}
		if (x < 0) {
			x = 0;
		}
		if (y < 0) {
			y = 0;
		}
		if (y > FlxG.height - height) {
			y = FlxG.height - height;
		}
	}
}