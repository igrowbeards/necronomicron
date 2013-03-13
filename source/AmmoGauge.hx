package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;
import org.flixel.plugin.photonstorm.FlxWeapon;

class AmmoGauge extends FlxSprite
{

	private var anim:String;

	override public function new(X:Int,Y:Int) {

		super(X,Y);

		loadGraphic("assets/ammo_gauge.png",true,false,28,28);

		addAnimation("0", [6]);
		addAnimation("1", [5]);
		addAnimation("2", [4]);
		addAnimation("3", [3]);
		addAnimation("4", [2]);
		addAnimation("5", [1]);
		addAnimation("6", [0]);

		play("6");

	}

	override public function update():Void {
		anim = Std.string(Registry.player.pistolAmmo);
		if (anim != Std.string(this._curAnim)) {
			play(anim);
		}
	}

}