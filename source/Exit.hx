package;

import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class Exit extends FlxSprite {

	override public function new(X:Int,Y:Int):Void {

		super(X * 16, Y * 16);
		loadGraphic("assets/gate.png");
		immovable = true;

	}

	public function openGate():Void {
		this.exists = false;
	}

}