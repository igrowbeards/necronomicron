package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import nme.display.BlendMode;

class Light extends FlxSprite {

	public var darkness:FlxSprite;

	override public function new(X:Float,Y:Float):Void {
		super(X,Y);
		loadGraphic("assets/glow-light.png");
		//makeGraphic(5,5,0xffffffff);
		this.blend = nme.display.BlendMode.SCREEN;
		//darkness = Registry.darkness;
	}


	override public function update():Void {
		super.update();
		x = Registry.player.x;
		y = Registry.player.y;
	}

	override public function draw():Void {
		Registry.darkness.stamp(this,30,30);
	}


}

