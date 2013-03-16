package;

import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.FlxG;

class Computer extends FlxSprite {

	public var hackDelay:Float = 5;
	public var hacked:Bool = false;

	override public function new(X:Int,Y:Int):Void {

		super(X * 16, Y * 16);
		loadGraphic("assets/computer.png");
		immovable = true;
		hackDelay = 1;

		loadGraphic("assets/computer.png",true,true,16,16,true);

		addAnimation("idle", [0,1], 5, true);
		addAnimation("blown", [2], 0, false);
		addAnimation("hacked", [3,4], 5, true);

		play("idle");
	}

	public function hack():Void {
		this.allowCollisions = FlxObject.NONE;
		if (hacked == false) {
			play("hacked");
			hacked = true;
			FlxG.log("hack");
		}
	}

	public function blowUp():Void {
	}

	override public function update():Void {

		if (hacked && hackDelay > 0) {
			hackDelay -= FlxG.elapsed;
		}
		else if (hacked && hackDelay > -1) {
			hackDelay = -1;
			play("blown");
			Registry.totalComputers--;
			FlxG.log("hackzrd");
		}

	}

}