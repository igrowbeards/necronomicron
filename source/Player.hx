package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Player extends FlxSprite
{

	public var pistol:FlxWeapon;
	public var pistolAmmo:Int;
	public var hasPistol:Bool = false;
	public var sanity:Int = 10;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);
		health = 5;
		width = 14;
		offset.x = 1;
		height = 14;
		offset.y = 1;
		pistolAmmo = 0;

		loadGraphic("assets/player.png",true,true,16,16,true);

		addAnimation("idle", [0,1], 2, true);
		addAnimation("walk", [0,2,0,3], 10, true);
		addAnimation("idle_down", [4,5], 2, true);
		addAnimation("walk_down", [4,6,4,7], 10, true);
		addAnimation("idle_up", [8,9], 2, true);
		addAnimation("walk_up", [8,10,8,11], 10, true);

		play("idle");

		if (FlxG.getPlugin(FlxControl) == null) {
			FlxG.addPlugin(new FlxControl());
		}

		FlxControl.create(this, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT, 1, true, true);
		FlxControl.player1.setCursorControl(true,true,true,true);
		FlxControl.player1.setStandardSpeed(50);


	}

	override public function update() {

		if (velocity.x != 0 && velocity.y >= 0) {
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

		if (FlxG.keys.justPressed("Z") && Registry.player.pistolAmmo > 0 && hasPistol) {
			if (Registry.pistol.fire()) {
				Registry.player.pistolAmmo--;
			}
		}
	}

	override public function kill() {
		FlxG.fade(0xff000000,1,deathChange);
		Registry.cod = "death";
	}

	public function deathChange() {
        FlxG.switchState(new EndGame());
	}

	public function resetController():Void {
		FlxControl.clear();
	}
}