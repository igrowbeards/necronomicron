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
		//makeGraphic(50,50,0x00ffffff);
		this.blend = nme.display.BlendMode.SHADER;
		//darkness = Registry.darkness;
	}


	override public function update():Void {
		super.update();
		drawX = Std.int(Registry.player.x -124);
		drawY = Std.int(Registry.player.y -124);
	}

	override public function draw():Void {
		Registry.darkness.stamp(this,drawX,drawY);
	}

}

