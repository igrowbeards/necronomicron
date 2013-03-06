package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxTilemap;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Registry
{
    public static var player:Player;
    public static var level:FlxTilemap;
    public static var pistol:FlxWeapon;
    public static var darkness:FlxSprite;
    public static var dialog:DialogBox;

    public static var conversation_1:Array<Array<String>>  = [
		["assets/player_dialog.png","Oh my gosh it's a dead guard!"],
		["assets/dialog_gun.png","You find a gun on the dead guard"]
	];
}