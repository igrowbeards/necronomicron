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
	public var chasing:Bool = false;
	public var sightedPlayer:Bool = false;
	public var runSpeed:Int = 30;
	public var enemyPath:FlxPath;
	public var pathStart:FlxPoint;
	public var pathEnd:FlxPoint;
	public var exclamtion:Array<Array<String>> = null;
	public var attackSpeed:Float;
	public var attackStrength:Int;
	public var attackTimer:Float;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);
		makeGraphic(8,8,0xff00ff00);
		attackTimer = Std.int(attackSpeed);

	}

	override public function update():Void {

		if (chaser) {

			pathStart = new FlxPoint(this.x + this.width / 2, this.y + this.height / 2);
			pathEnd = new FlxPoint(Registry.player.x + Registry.player.width / 2, Registry.player.y + Registry.player.height / 2);
			enemyPath = Registry.level.findPath(pathStart,pathEnd);

			if (Registry.level.ray(pathStart,pathEnd) && !sightedPlayer) {
				sightedPlayer = true;
				this.chasing = true;
			}

			if (enemyPath != null && pathSpeed == 0 && sightedPlayer) {
				this.followPath(enemyPath,this.runSpeed);
			}
		}

		if (wander == true && !sightedPlayer) {

			if (wanderDirection == "horizontal") {
				if (justTouched(FlxObject.LEFT)) {
					facing = FlxObject.RIGHT;
					velocity.x = wanderSpeed;
				}
				else if (justTouched(FlxObject.RIGHT)) {
					facing = FlxObject.LEFT;
					velocity.x = -wanderSpeed;
				}
			}
			else if (wanderDirection == "vertical") {
				if (justTouched(FlxObject.UP)) {
					facing = FlxObject.DOWN;
					velocity.y = wanderSpeed;
				}
				else if (justTouched(FlxObject.DOWN)) {
					facing = FlxObject.UP;
					velocity.y = -wanderSpeed;
				}
			}
		}

		attackTimer += FlxG.elapsed;
		super.update();

	}

	public function attack(target:FlxObject) {
		if (attackTimer > attackSpeed) {
			Registry.player.hurt(attackStrength);
			attackTimer = 0;
		}
	}

}