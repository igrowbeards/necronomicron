package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Player extends FlxSprite
{

	public var pistol:FlxWeapon;

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		//makeGraphic(14,14,0xff224330);
		loadGraphic("assets/player.png",true,true,16,16,true);
		addAnimation("idle", [0,1], 2, true);
		addAnimation("walk", [0,2,0,3], 4, true);
		addAnimation("idle_down", [4,5], 2, true);
		addAnimation("walk_down", [4,6,4,7], 4, true);
		addAnimation("idle_up", [8,9], 2, true);
		addAnimation("walk_up", [8,10,8,11], 4, true);
		play("idle");

		if (FlxG.getPlugin(FlxControl) == null) {
			FlxG.addPlugin(new FlxControl());
		}

		// The player sprite will accelerate and decelerate smoothly
		FlxControl.create(this, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT, 1, true, true);
		// Enable cursor keys, but only the left and right ones
		FlxControl.player1.setCursorControl(true,true,true,true);
		//FlxControl.player1.setHJKLControl();
		// All speeds are in pixels per second, the follow lets the player run left/right
		FlxControl.player1.setStandardSpeed(50);
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

		if (velocity.x != 0) {
			play("walk");
		}

		if (velocity.y == 0 && velocity.x == 0) {
			if (facing == FlxObject.DOWN) {
				play("idle_down");
			}
			else if (facing == FlxObject.UP){
				play("idle_up");
			}
			else {
				play("idle");
			}
		}

		if ( velocity.y < 0 && velocity.x == 0) {
			play("walk_up");
		}
		else if (velocity.y > 0 && velocity.x == 0) {
			play("walk_down");
		}

	}
}