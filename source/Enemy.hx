package;

import org.flixel.FlxSprite;
import org.flixel.FlxPath;

class Enemy extends FlxSprite {

	public var wanderSpeed:Int;
	public var runSpeed:Int;

	override public function new(X:Int,Y:Int) {
		super(X * 16,Y * 16);
		makeGraphic(8,8,0xff00ff00);
	}

}