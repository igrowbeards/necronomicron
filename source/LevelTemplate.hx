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

class LevelTemplate extends FlxState {

	public var player:Player;
	public var level:FlxTilemap;
	public var enemies:FlxGroup;
	public var enemyPath:FlxPath;
	public var pistol:FlxWeapon;
	public var remainingAmmo:FlxText;
	public var ammoPickup:Ammo;
	public var dialog:DialogBox;
	public var darkness:FlxSprite;
	public var light:Light;
	public var staticLight:StaticLight;
	public var deadGuard:DeadGuard;
	public var ammoGauge:AmmoGauge;
	public var computer:Computer;
	public var playerStartX:Int;
	public var playerStartY:Int;

	override public function create():Void {
		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();
		level = new FlxTilemap();
		//level.loadMap(FlxTilemap.arrayToCSV(createLevel(), 40), "assets/tiles.png", 16, 16, FlxTilemap.AUTO);
		add(level);
		Registry.level = level;

		player = new Player(playerStartX,playerStartY);
		add(player);
		Registry.player = player;

		light = new Light(playerStartX,playerStartY);

		computer = new Computer(35,21);
		add(computer);
		staticLight = new StaticLight(35,21);

		dialog = new DialogBox();
		dialog.exists = false;
		Registry.dialog = dialog;

        ammoGauge = new AmmoGauge(5,5);
        Registry.ammoGauge = ammoGauge;
        ammoGauge.exists = false;

		pistol = new FlxWeapon("pistol",player,"x","y");
		pistol.makePixelBullet(10,5,5,0xffa7b741);
		pistol.setFireRate(500);
		pistol.setBulletSpeed(250);
		pistol.setParent(player,"x","y",8,8,true);
		add(pistol.group);
		Registry.pistol = pistol;

        ammoPickup = new Ammo(12,4);
        add(ammoPickup);

        enemies = new FlxGroup();
        enemies.add(new Cultist(16,26,"vertical"));
        enemies.add(new Cultist(19,13,"horizontal"));
        add(enemies);

		deadGuard = new DeadGuard(7,8);
		add(deadGuard);

		darkness = new FlxSprite(0,0);
		darkness.makeGraphic(FlxG.width,FlxG.height,0xff000000);
		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
      	darkness.blend = nme.display.BlendMode.MULTIPLY;
      	Registry.darkness = darkness;

		add(light);
		add(staticLight);
		//add(darkness);
		add(dialog);
        add(ammoGauge);
        add(new FlxBackdrop("assets/scanlines.png", 0, 0, true, true));
        //add(new FlxBackdrop("assets/vignette.png", 0, 0, false, false));
 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		if (!dialog.exists) {
			super.update();
			FlxG.collide(player,level);
			FlxG.collide(player,deadGuard,getGun);
			FlxG.collide(enemies,level);
			FlxG.collide(pistol.group,level,bulletHitLevel);
			FlxG.collide(pistol.group, enemies,bulletHitEnemy);
			FlxG.collide(player,ammoPickup,getAmmo);

			if (player.x > FlxG.width) {
				fadeOutLevel();
			}

		}
		else {
			dialog.update_text();
		}

	}

	override public function draw():Void {
		darkness.fill(0xff000000);
		super.draw();
	}

	public function bulletHitEnemy(b:FlxObject,e:FlxObject) {
		b.exists = false;
		e.exists = false;
	}

	public function bulletHitLevel(b:FlxObject,l:FlxObject) {
		b.exists = false;
	}

	public function getAmmo(p:FlxObject,a:FlxObject) {
		a.kill();
		if (Registry.player.pistolAmmo <= 5) {
			Registry.player.pistolAmmo++;
			Registry.ammoGauge.changeAnim();
		}
	}

	public function fadeOutLevel():Void
	{
		FlxG.fade(0xff000000,1,changeLevel);
	}

	public function changeLevel():Void
	{
        //FlxG.switchState(new WinState());
		FlxG.resetState();
		Registry.player.resetController();
	}

	public function getGun(p:FlxObject,dg:FlxObject):Void {
		Registry.dialog.longUpdate(Registry.conversation_1);
		Registry.player.pistolAmmo = 6;
		Registry.player.hasPistol = true;
		ammoGauge.exists = true;
		dg.allowCollisions = FlxObject.NONE;
	}

	public function createLevel() {
		var levelArray:Array<Int> = [];
		var i:Int = 0;
		while (i < ((FlxG.width / 16) * (FlxG.height /16))) {
			if (FlxMath.rand(1,8) == 1) {
				levelArray.push(1);
			}
			else {
				levelArray.push(0);
			}
			i++;
		}
		return levelArray;
	}

}