package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
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

class MenuState extends FlxState {

	public var player:Player;
	public var level:FlxTilemap;
	public var enemies:FlxGroup;
	public var enemy:Enemy;
	public var enemyPath:FlxPath;
	public var pistol:FlxWeapon;
	public var remainingAmmo:FlxText;
	public var ammoPickup:Ammo;
	public var dialog:DialogBox;

	override public function create():Void {
		FlxG.bgColor = 0xffa8ba4a;
		FlxG.mouse.hide();

		player = new Player(3,3);
		add(player);
		Registry.player = player;

		enemy = new Enemy(35,28);
		add(enemy);

		level = new FlxTilemap();
		level.loadMap(FlxTilemap.arrayToCSV(createLevel(), 40), "assets/tiles.png", 16, 16, FlxTilemap.AUTO);
		add(level);

		dialog = new DialogBox();
		dialog.exists = false;

        remainingAmmo = new FlxText(10,10,200,"6");
        remainingAmmo.color = 0xff213625;
        remainingAmmo.size = 32;
        remainingAmmo.shadow = 0xff000000;

		pistol = new FlxWeapon("pistol",player,"x","y");
		//pistol.makeImageBullet(50,makeGraphic(5,5,0xff224330),5);
		pistol.makePixelBullet(50,5,5,0xff224330);
		//pistol.setBulletDirection(FlxWeapon.BULLET_UP,200);
		pistol.setFireRate(1000);
		pistol.setBulletSpeed(250);
		pistol.setParent(player,"x","y",8,8,true);
		add(pistol.group);
        add(remainingAmmo);
        ammoPickup = new Ammo(10,10);
        add(ammoPickup);
		add(dialog);
        add(new FlxBackdrop("assets/scanlines.png", 0, 0, true, true));
        add(new FlxBackdrop("assets/vignette.png", 0, 0, false, false));


 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		if (!dialog.exists) {
			super.update();
			FlxG.collide(player,level);
			FlxG.collide(enemy,level);
			FlxG.collide(pistol.group,level,bulletHitLevel);
			FlxG.collide(pistol.group, enemy,bulletHitEnemy);
			FlxG.collide(player,ammoPickup,getAmmo);

			var pathStart:FlxPoint = new FlxPoint(enemy.x + enemy.width / 2, enemy.y + enemy.height / 2);
			var pathEnd:FlxPoint = new FlxPoint(player.x + player.width / 2, player.y + player.height / 2);
			enemyPath = level.findPath(pathStart,pathEnd);

			if (enemy.pathSpeed == 0) {
				enemy.velocity.x = 0;
				enemy.velocity.y = 0;
			}

			if (level.ray(pathStart,pathEnd)) {
				if (enemyPath != null) {
					enemy.followPath(enemyPath,enemy.runSpeed);
				}
			}
			else {
				enemy.stopFollowingPath(true);
			}

			if (FlxG.keys.justPressed("Z") && Registry.player.pistolAmmo > 0) {
				if (pistol.fire()) {
					decrease_ammo();
				}
			}

			remainingAmmo.text = Std.string(Registry.player.pistolAmmo);

		}
		else {
			dialog.update_text();
		}

	}

	public function decrease_ammo():Void {
		Registry.player.pistolAmmo--;
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
		Registry.player.pistolAmmo++;
		dialog.exists = true;
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