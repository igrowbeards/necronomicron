package;

import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class Computer extends FlxSprite {

	override public function new(X:Int,Y:Int):Void {

		super(X * 16, Y * 16);
		loadGraphic("assets/computer.png");
		this.moves = false;

		loadGraphic("assets/computer.png",true,true,16,16,true);

		addAnimation("idle", [0,1], 5, true);

		play("idle");
	}

}