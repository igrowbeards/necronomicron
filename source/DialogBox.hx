package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxText;

class DialogBox extends FlxGroup {

	public var bg:FlxSprite;
	public var dialogText:FlxText;
	public var dialogArray:Array<Array<String>>;
	public var showing:Bool;
	public var currentText:Int;
	public var portrait:FlxSprite;

	override public function new():Void {
		super();
		currentText = 0;

		dialogArray = [
			["assets/player_dialog.png","Multi-dimensional Array Test"],
		];

		portrait = new FlxSprite(50,34,"assets/player_dialog.png");

		bg = new FlxSprite(48,32);
		bg.makeGraphic(544,144,0xffa7b741);
		add(bg);
		add(portrait);

		dialogText = new FlxText(208,48,368,dialogArray[0][1]);
        dialogText.color = 0xff000000;
        dialogText.size = 14;
		add(dialogText);
	}

	public function update_text():Void {
		if (FlxG.keys.justPressed("X")) {
			currentText++;
			if (currentText < dialogArray.length) {
				portrait.loadGraphic(dialogArray[currentText][0]);
				dialogText.text = dialogArray[currentText][1];
			}
			else {
				exists = false;
			}
		}
	}

	public function longUpdate(conversation:Array<Array<String>>):Void {
		currentText = 0;
		dialogArray = conversation;
		portrait.loadGraphic(dialogArray[currentText][0]);
		dialogText.text = dialogArray[currentText][1];
		this.exists = true;
	}


	public function quickUpdate(graphic:String,txt:String):Void {
		currentText = 0;
		portrait.loadGraphic(graphic);
		this.exists = true;
		dialogArray = [];
		dialogArray.push([graphic,txt]);
		dialogText.text = txt;
	}

}