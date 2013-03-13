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
	public var cultists:FlxGroup;
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
	public var hud:HUD;
	public var computers:FlxGroup;
	public var playerStartX:Int;
	public var playerStartY:Int;
	public var exit:Exit;

	override public function create():Void {
		FlxG.bgColor = 0xff000000;
		FlxG.camera.antialiasing = false;
		FlxG.mouse.hide();
		level = new FlxTilemap();
		//level.loadMap(FlxTilemap.arrayToCSV(createLevel(), 40), "assets/tiles.png", 16, 16, FlxTilemap.AUTO);
		add(level);
		Registry.level = level;


		if (Registry.player != null) {
			player = new Player(playerStartX,playerStartY);
			player.sanity = Registry.player.sanity;
			player.health = Registry.player.health;
			player.hasPistol = Registry.player.hasPistol;
			player.pistolAmmo = Registry.player.pistolAmmo;
			Registry.player = player;
		} else {
			player = new Player(playerStartX,playerStartY);
			Registry.player = player;
		}
		add(player);

		light = new Light(playerStartX,playerStartY);

		staticLight = new StaticLight(35,21);

		computers = new FlxGroup();
		Registry.computers = computers;
		add(computers);
		dialog = new DialogBox();
		dialog.exists = false;
		Registry.dialog = dialog;

		pistol = new FlxWeapon("pistol",player,"x","y");
		pistol.makePixelBullet(10,5,5,0xffa7b741);
		pistol.setFireRate(500);
		pistol.setBulletSpeed(250);
		pistol.setParent(player,"x","y",8,8,true);
		add(pistol.group);
		Registry.pistol = pistol;

        ammoPickup = new Ammo(12,4);
        add(ammoPickup);

        cultists = new FlxGroup();

        hud = new HUD();
        Registry.hud = hud;

        enemies = new FlxGroup();
        add(enemies);
        Registry.enemies = enemies;

        if (FlxG.level == 0) {
			deadGuard = new DeadGuard(7,8);
			add(deadGuard);
        }


		darkness = new FlxSprite(0,0);
		darkness.makeGraphic(FlxG.width,FlxG.height,0xff000000);
		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
      	darkness.blend = nme.display.BlendMode.MULTIPLY;
      	Registry.darkness = darkness;

		add(light);
		add(staticLight);
		//add(darkness);
		add(dialog);
        //add(ammoGauge);
        add(hud);
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
			FlxG.collide(player,exit);
			FlxG.collide(player,deadGuard,getGun);
			FlxG.collide(enemies,level);
			FlxG.collide(player,enemies,injurePlayer);
			FlxG.collide(pistol.group,level,bulletHitLevel);
			FlxG.collide(pistol.group, enemies,bulletHitEnemy);
			FlxG.collide(player,ammoPickup,getAmmo);
			FlxG.collide(player,computers,hackComputer);

			if (player.x > FlxG.width) {
				fadeOutLevel();
			}

		}
		else {
			dialog.update_text();
		}

		if (Registry.totalComputers == 0) {
			Registry.exit.openGate();
		}

		if (Registry.player.sanity == 0) {
			Registry.player.sanity = -1;
			loseSanity();
		}

		FlxG.log(FlxG.level);

	}

	override public function draw():Void {
		darkness.fill(0xff000000);
		super.draw();
	}

	public function bulletHitEnemy(b:FlxObject,e:FlxObject) {
		b.exists = false;
		e.exists = false;
		Registry.player.sanity--;
	}

	public function injurePlayer(p:FlxObject,cultist:FlxObject) {
		var c:Cultist = cast(cultist,Cultist);
		c.attack(Registry.player);
	}

	public function bulletHitLevel(b:FlxObject,l:FlxObject) {
		b.exists = false;
	}

	public function hackComputer(pRef:FlxObject,cRef:FlxObject) {
		var c:Computer = cast(cRef,Computer);
		c.hack();
	}

	public function getAmmo(p:FlxObject,a:FlxObject) {
		a.kill();
		if (Registry.player.pistolAmmo <= 5) {
			Registry.player.pistolAmmo++;
		}
	}

	public function fadeOutLevel():Void
	{
		FlxG.fade(0xff000000,1,changeLevel);
	}

	public function changeLevel():Void
	{
        FlxG.switchState(new Level1());
		//FlxG.resetState();
		Registry.player.resetController();
		FlxG.level ++;
	}

	public function getGun(p:FlxObject,dg:FlxObject):Void {
		Registry.dialog.longUpdate(Registry.conversation_1);
		Registry.player.pistolAmmo = 6;
		Registry.player.hasPistol = true;
		Registry.hud.ammoGauge.exists = true;
		dg.allowCollisions = FlxObject.NONE;
	}

	public function addCultists() {

		for (ty in 0...level.heightInTiles) {
			for (tx in 0...level.widthInTiles) {
				if (level.getTile(tx,ty) == 0) {
					if (cultists.countLiving() < (FlxG.level + 1) * 2 && FlxMath.rand(1,100) == 1) {
						cultists.add(new Cultist(tx,ty,"horizontal"));
					}
				}
			}
		}
	}

	public function addEnemies() {
		enemies.add(cultists);
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

	public function placeExit(X:Int,Y:Int) {
		exit = new Exit(X,Y);
		Registry.exit = exit;
		add(exit);
	}

	public function addComputers() {
		computers.add(new Computer(35,21));
		computers.add(new Computer(1,28));
		computers.add(new Computer(12,1));
		Registry.totalComputers = 3;
	}

	public function loseSanity() {
		Registry.cod = "madness";
		FlxG.fade(0xff000000,1,gameOver);
	}

	public function gameOver():Void {
		FlxG.switchState(new EndGame());
	}

}