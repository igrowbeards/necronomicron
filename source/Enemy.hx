package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxPath;
import org.flixel.FlxPoint;

class Enemy extends FlxSprite {

	public var wanderSpeed:Int;
	public var runSpeed:Int = 30;
	public var enemyPath:FlxPath;
	public var pathStart:FlxPoint;
	public var pathEnd:FlxPoint;
	public var chaser:Bool = false;
	public var sightedPlayer:Bool = false;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);
		makeGraphic(8,8,0xff00ff00);

	}

	override public function update():Void {

		super.update();

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

	}

}