package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import nme.display.BlendMode;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxBasic;
import org.flixel.FlxText;
import org.flixel.FlxU;
import org.flixel.FlxTilemap;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.FlxGroup;
import org.flixel.plugin.photonstorm.FlxWeapon;
import org.flixel.plugin.photonstorm.FlxMath;
import addons.FlxBackdrop;

class Level1 extends LevelTemplate {

	override public function create():Void {
		playerStartX = 6;
		playerStartY = 26;
		super.create();
		level.loadMap(Assets.getText("assets/mapCSV_level_map.csv"), "assets/tiles.png", 16, 16, FlxTilemap.AUTO);
 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
	}
}
