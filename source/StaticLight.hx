package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import nme.display.BlendMode;

class StaticLight extends FlxSprite {

	public var drawX:Int;
	public var drawY:Int;

	override public function new(X:Float,Y:Float):Void {
		super((X * 16) - 63,(Y * 16) - 63);
		var xpos:Int = Std.int(x);
		var ypos:Int = Std.int(y);
		loadGraphic("assets/small_light.png");
		this.blend = nme.display.BlendMode.SCREEN;
	}

	override public function update():Void {
		super.update();
		drawX = Std.int(this.x);
		drawY = Std.int(this.y);
	}

	override public function draw():Void {
		Registry.darkness.stamp(this,drawX,drawY);
	}

}

