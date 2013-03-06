package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxPath;
import org.flixel.FlxPoint;
import org.flixel.FlxObject;

class Enemy extends FlxSprite {

	public var wander:Bool = false;
	public var wanderDirection:String;
	public var wanderSpeed:Int = 20;

	public var chaser:Bool = false;
	public var sightedPlayer:Bool = false;
	public var runSpeed:Int = 30;
	public var enemyPath:FlxPath;
	public var pathStart:FlxPoint;
	public var pathEnd:FlxPoint;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);
		makeGraphic(8,8,0xff00ff00);

	}

	override public function update():Void {



		if (chaser) {

			pathStart = new FlxPoint(this.x + this.width / 2, this.y + this.height / 2);
			pathEnd = new FlxPoint(Registry.player.x + Registry.player.width / 2, Registry.player.y + Registry.player.height / 2);
			enemyPath = Registry.level.findPath(pathStart,pathEnd);

			if (Registry.level.ray(pathStart,pathEnd) && !sightedPlayer) {
				sightedPlayer = true;
			}

			if (enemyPath != null && pathSpeed == 0 && sightedPlayer) {
				this.followPath(enemyPath,this.runSpeed);
			}
		}


		if (wander == true && !sightedPlayer) {

			FlxG.log("Yes Wander");
			if (wanderDirection == "horizontal") {
				if (justTouched(FlxObject.LEFT)) {
					facing = FlxObject.RIGHT;
					velocity.x = wanderSpeed;
					FlxG.log("Hit 1");
				}
				else if (justTouched(FlxObject.RIGHT)) {
					facing = FlxObject.LEFT;
					velocity.x = -wanderSpeed;
					FlxG.log("Hit 2");
				}
			}
			else if (wanderDirection == "vertical") {
				// do the opposite
			}
		}
		else {
			FlxG.log("No Wander");
		}

		super.update();

	}

}