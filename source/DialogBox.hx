package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxText;

class DialogBox extends FlxGroup {

	public var bg:FlxSprite;
	public var dialogText:FlxText;
	public var textArray:Array<String>;
	public var showing:Bool;
	public var currentText:Int;
	public var portrait:FlxSprite;

	override public function new():Void {
		super();
		currentText = 0;

		textArray = ["Test Test Test","Yep It Works!"];

		portrait = new FlxSprite(50,34,"assets/player_dialog.png");

		bg = new FlxSprite(48,32);
		bg.makeGraphic(544,144,0xffa7b741);
		add(bg);
		add(portrait);

		dialogText = new FlxText(208,48,368,textArray[currentText]);
        dialogText.color = 0xff000000;
        dialogText.size = 14;
		add(dialogText);
	}

	public function update_text():Void {
		if (FlxG.keys.justPressed("X")) {
			currentText++;
			if (currentText < textArray.length) {
				dialogText.text = textArray[currentText];
			}
			else {
				exists = false;
			}
		}
	}

	public function quickUpdate(graphic:String,txt:String):Void {
		portrait.loadGraphic(graphic);
		this.exists = true;
		textArray = [];
		textArray.push(txt);
		dialogText.text = txt;
	}

}