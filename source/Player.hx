package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Player extends FlxSprite
{

	public var pistol:FlxWeapon;

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(14,14,0xff224330);

		if (FlxG.getPlugin(FlxControl) == null) {
			FlxG.addPlugin(new FlxControl());
		}

		// The player sprite will accelerate and decelerate smoothly
		FlxControl.create(this, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT, 1, true, true);
		// Enable cursor keys, but only the left and right ones
		FlxControl.player1.setCursorControl(true,true,true,true);
		//FlxControl.player1.setHJKLControl();
		// All speeds are in pixels per second, the follow lets the player run left/right
		FlxControl.player1.setStandardSpeed(100);
		//FlxControl.player1.setFireButton("Z",FlxControlHandler.KEYMODE_JUST_DOWN,1000,pistol.fire);


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