package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
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
    public static var ammoGauge:AmmoGauge;
    public static var enemies:FlxGroup;
    public static var computers:FlxGroup;
    public static var exit:Exit;
    public static var totalComputers:Int;
    public static var hud:HUD;

    public static var conversation_1:Array<Array<String>>  = [
		["assets/player_dialog.png","Oh my gosh it's a dead guard!"],
		["assets/dialog_gun.png","You find a gun on the dead guard"]
	];

    public static var cultist_exclamations:Array<Array<String>>  = [
		["assets/player_dialog.png","What are you doing here infidel?!?"],
		["assets/dialog_gun.png","Lord Cthulu shall feast on your soul tonight!"],
		["assets/player_dialog.png","So much randomness! It's chaos!"]
	];
}