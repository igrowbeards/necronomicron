package;

import nme.Lib;
import org.flixel.FlxGame;

class ProjectClass extends FlxGame
{
	override public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 640;
		var ratioY:Float = stageHeight / 480;
		var ratio:Float = Math.min(ratioX, ratioY);
		super(Math.floor(stageWidth / ratio), Math.floor(stageHeight / ratio), Level1, ratio, 30, 30);
		//forceDebugger = true;
	}
}
