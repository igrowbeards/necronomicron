package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxPath;
import org.flixel.FlxPoint;
import org.flixel.FlxObject;
import org.flixel.FlxTilemap;
import org.flixel.plugin.photonstorm.FlxVelocity;

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
	public var lineOfSightDistance:Float = 120;

	override public function new(X:Int,Y:Int) {
		super(X * 16,Y * 16);
		makeGraphic(8,8,0xff00ff00);
		attackTimer = Std.int(attackSpeed);
	}

	override public function update():Void {

		//FlxG.log(FlxVelocity.angleBetween(this, Registry.player,true));
		//FlxG.log(FlxVelocity.distanceBetween(this,Registry.player));

		//if (chaser && !sightedPlayer) {
		if (chaser) {

<<<<<<< HEAD
			// facing right && player is in range
			if (facing == FlxObject.RIGHT && Registry.player.x > this.x && Registry.player.x - this.x < lineOfSightDistance) {
				// and if they're in the proper vertical range
				if (y > Registry.player.y && y - Registry.player.y < 25) {
					//and if the level isn't blocking their view
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on upper right");
						sightedPlayer = true;
					}
				}
				else if (y < Registry.player.y && Registry.player.y - y < 25) {
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						sightedPlayer = true;
						FlxG.log("spotted on lower right");
					}
				}
			}
			// facing left && player is in range
			else if (facing == FlxObject.LEFT && Registry.player.x < this.x && this.x - Registry.player.x < lineOfSightDistance) {
				// and if they're in the proper vertical range
				if (y > Registry.player.y && y - Registry.player.y < 25) {
					//and if the level isn't blocking their view
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on upper left");
						sightedPlayer = true;
					}
				}
				else if (y < Registry.player.y && Registry.player.y - y < 25) {
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on lower left");
						sightedPlayer = true;
					}
				}
			}
			// facing up && player is in range
			else if (facing == FlxObject.UP && Registry.player.y < this.y && this.y - Registry.player.y < lineOfSightDistance) {
				// and if they're in the proper horizontal range
				if (x > Registry.player.x && x - Registry.player.x < 25) {
					//and if the level isn't blocking their view
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on up and left");
						sightedPlayer = true;
					}
				}
				else if (x < Registry.player.x && Registry.player.x - x < 25) {
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on up and right");
						sightedPlayer = true;
					}
				}
			}
			// facing down && player is in range
			else if (facing == FlxObject.DOWN && Registry.player.y > this.y && Registry.player.y - this.y < lineOfSightDistance) {
				// and if they're in the proper horizontal range
				if (x > Registry.player.x && x - Registry.player.x < 25) {
					//and if the level isn't blocking their view
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on down and left");
						sightedPlayer = true;
					}
				}
				else if (x < Registry.player.x && Registry.player.x - x < 25) {
					if (Registry.level.ray(new FlxPoint(this.x,this.y),new FlxPoint(Registry.player.x, Registry.player.y))) {
						// they've sighted the player - start chasing
						FlxG.log("spotted on down and right");
						sightedPlayer = true;
=======
			var angle:Float = FlxVelocity.angleBetween(this,Registry.player,true);
			var distance:Int = FlxVelocity.distanceBetween(this,Registry.player);
			pathStart = new FlxPoint(this.x + this.width / 2, this.y + this.height / 2);
			pathEnd = new FlxPoint(Registry.player.x + Registry.player.width / 2, Registry.player.y + Registry.player.height / 2);

			//vision right
			if (facing == FlxObject.RIGHT) {
				if (this.x < Registry.player.x && distance <= lineOfSightDistance) {
					if (angle > -10 && angle < 10) {
						if (Registry.level.ray(pathStart,pathEnd,null,2)) {
							sightedPlayer = true;
							FlxG.log("spotted right");
						}
					}
				}
			}

			// vision left
			if (facing == FlxObject.LEFT) {
				if (this.x > Registry.player.x && distance <= lineOfSightDistance) {
					if (angle > 170 || angle < -170) {
						if (Registry.level.ray(pathStart,pathEnd,null,2)) {
							sightedPlayer = true;
							FlxG.log("spotted left");
						}
					}
				}
			}

			// vision up
			if (facing == FlxObject.UP) {
				if (this.y > Registry.player.y && distance <= lineOfSightDistance) {
					if (angle > -100 && angle < -80) {
						if (Registry.level.ray(pathStart,pathEnd,null,2)) {
							sightedPlayer = true;
							FlxG.log("spotted up");
						}
					}
				}
			}

			// vision down
			if (facing == FlxObject.DOWN) {
				if (this.y < Registry.player.y && distance <= lineOfSightDistance) {
					if (angle < 110 && angle > 70) {
						if (Registry.level.ray(pathStart,pathEnd,null,2)) {
							sightedPlayer = true;
							FlxG.log("spotted down");
						}
>>>>>>> cone_of_vision
					}
				}
			}
		}

		if (chaser && sightedPlayer) {

		}

<<<<<<< HEAD
=======

>>>>>>> cone_of_vision
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