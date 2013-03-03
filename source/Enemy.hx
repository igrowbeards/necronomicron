package;

import org.flixel.FlxSprite;
import org.flixel.FlxPath;

class Enemy extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(8,8,0xff00ff00);
	}

}