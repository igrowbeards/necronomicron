package;

import org.flixel.FlxSprite;

class DeadGuard extends FlxSprite {

	override public function new(X:Int,Y:Int):Void {

		super(X * 16, Y * 16);
		loadGraphic("assets/dead_guy.png");

	}

}