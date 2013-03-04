package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxText;

class DialogBox extends FlxGroup {

	public var bg:FlxSprite;
	public var text:FlxText;
	public var textArray:Array<String>;
	public var showing:Bool;
	public var currentText:Int;

	override public function new():Void {
		super();
		currentText = 0;

		textArray = ["Test Test Test","Yep It Works!"];

		bg = new FlxSprite(40,40);
		bg.makeGraphic(560,100,0xff224330);
		add(bg);

		text = new FlxText(60,60,560,textArray[currentText]);
        text.color = 0xffa8ba4a;
        text.size = 32;
		add(text);
	}

	public function update_text():Void {
		if (FlxG.keys.justReleased("X")) {
			currentText++;
			if (currentText < textArray.length) {
				text.text = textArray[currentText];
			}
			else {
				exists = false;
			}
		}
	}

}