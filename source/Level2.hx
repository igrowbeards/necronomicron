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
import addons.FlxCaveGenerator;

class Level2 extends LevelTemplate {

	override public function create():Void {
		playerStartX = 36;
		playerStartY = 9;
		super.create();
		var cave:FlxCaveGenerator = new FlxCaveGenerator(40, 30);
		var caveMatrix:Array<Array<Int>> = cave.generateCaveLevel();
		var dataStr:String = FlxCaveGenerator.convertMatrixToStr( caveMatrix );
		level.loadMap( dataStr, "assets/tiles.png", 16, 16, FlxTilemap.AUTO);
		//level.loadMap(Assets.getText("assets/mapCSV_level_map.csv"), "assets/tiles.png", 16, 16, FlxTilemap.AUTO);
		addCultists();
		addEnemies();

		// Create cave of size 200x100 tiles

		// Generate the level and returns a matrix
		// 0 = empty, 1 = wall tile

		// Converts the matrix into a string that is readable by FlxTileMap

		// Loads tilemap of tilesize 16x16
		//level.loadMap( dataStr, FlxTilemap.ImgAuto, 16, 16 );

 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
	}
}

