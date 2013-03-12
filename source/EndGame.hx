package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.plugin.photonstorm.FlxDisplay;
import addons.FlxBackdrop;

class EndGame extends FlxState {

	private var endGameText:FlxText;
	private var startOver:FlxText;
	private var deathBy:FlxText;

	override public function create():Void {
		//super();
		FlxG.bgColor = 0xff000000;
		FlxG.camera.antialiasing = false;
		Registry.player.resetController();
		FlxG.level == 0;

		endGameText = new FlxText(10,40,FlxG.width-20,"GAME OVER");
        endGameText.color = 0xffa7b741;
        endGameText.size = 28;
        endGameText.alignment = "center";
		add(endGameText);

		startOver = new FlxText(10,220,FlxG.width-20,"Press SPACE to play again");
        startOver.color = 0xffa7b741;
        startOver.size = 14;
        startOver.alignment = "center";
		add(startOver);

		deathBy = new FlxText(10,140,FlxG.width-20,"---");
        deathBy.color = 0xffa7b741;
        deathBy.size = 14;
        deathBy.alignment = "center";


       	if (Registry.cod == "madness") {
       		deathBy.text = "The horrors you have seen have cost you your mind";
       	}
       	else if (Registry.cod == "death") {
       		deathBy.text = "You didn't survive your trip through the server room.\nConsider yourself lucky that you weren't alive to see what came next.";
       	}
       	else {
       		deathBy.text = "Better Luck Next Time";
       	}

		add(deathBy);


        add(new FlxBackdrop("assets/scanlines.png", 0, 0, true, true));
 	}

 	override public function update():Void {
 		if (FlxG.keys.justPressed("SPACE")) {
			FlxG.fade(0xff000000,1,changeLevel);
 		}
 	}

	override public function destroy():Void {
		super.destroy();
	}

	private function changeLevel():Void {
    	FlxG.switchState(new Level1());
	}

    private function onStartClick( ):Void {
        FlxG.switchState(new Level1());
    }

}
