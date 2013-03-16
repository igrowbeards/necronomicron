package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import nme.display.BlendMode;

class Light extends FlxSprite {

	public var drawX:Int;
	public var drawY:Int;

	override public function new(X:Float,Y:Float):Void {
		super(X,Y);
		loadGraphic("assets/glow-light.png");
		this.blend = nme.display.BlendMode.SCREEN;
	}


	override public function update():Void {
		super.update();
		drawX = Std.int(Registry.player.x - ((width / 2) - 8));
		drawY = Std.int(Registry.player.y - ((width / 2) -8));
	}

	override public function draw():Void {
		Registry.darkness.stamp(this,drawX,drawY);
	}

}

