package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxText;

class HUD extends FlxGroup {

	public var bg:FlxSprite;
	public var ammoGauge:AmmoGauge;
	public var health:FlxText;
	public var sanity:FlxText;

	override public function new():Void {

		super();

		health = new FlxText(48,5,128,"Health: X");
		sanity = new FlxText(192,5,368,"Sanity: X");
        health.color = 0xff000000;
        health.size = 14;
        sanity.color = 0xff000000;
        sanity.size = 14;

        ammoGauge = new AmmoGauge(5,5);
        Registry.ammoGauge = ammoGauge;

        if (!Registry.player.hasPistol) {
        	ammoGauge.exists = false;
    	}

        add(ammoGauge);
        add(health);
        add(sanity);

	}

	override public function update():Void {
		super.update();
		health.text = "Health: " + Registry.player.health;
		sanity.text = "Sanity: " + Registry.player.sanity;
	}

}