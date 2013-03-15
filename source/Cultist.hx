package;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.FlxPath;
import org.flixel.FlxPoint;

class Cultist extends Enemy {

	override public function new(X:Int,Y:Int,wanderD:String):Void {

		super(X,Y);
		wander = false;

		loadGraphic("assets/cultist.png",true,true,16,16,true);

		chaser = true;
		runSpeed = 45;
		wanderSpeed = 30;
		attackSpeed = 1;
		attackStrength = 1;
		facing = FlxObject.DOWN;

		addAnimation("idle", [0,1], 2, true);
		addAnimation("walk", [0,1], 10, true);
		addAnimation("idle_down", [2,3], 2, true);
		addAnimation("walk_down", [2,3], 10, true);
		addAnimation("idle_up", [4,5], 2, true);
		addAnimation("walk_up", [4,5], 10, true);

		play("idle");

		if (wanderD == "horizontal") {
			//velocity.x = wanderSpeed;
			//wanderDirection = "horizontal";
		}
		else if (wanderD == "vertical") {
			//velocity.y = -wanderSpeed;
			//wanderDirection = "vertical";
		}

	}

	override public function update():Void {

		super.update();

		// Walk left and right
		if (velocity.x > 0 && velocity.y >= 0) {
			facing = FlxObject.RIGHT;
			play("walk");
		}
		else if (velocity.x < 0 && velocity.y >= 0) {
			facing = FlxObject.LEFT;
			play("walk");
		}

		// Idle Animation Handling
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

		// Walk up & down
		if ( velocity.y < 0 && velocity.x == 0) {
			facing = FlxObject.UP;
			play("walk_up");
		}
		else if (velocity.y > 0 && velocity.x == 0) {
			facing = FlxObject.DOWN;
			play("walk_down");
		}
	}
}