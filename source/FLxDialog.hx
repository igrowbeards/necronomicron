package;


import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxText;
import org.flixel.FlxSprite;


class FlxDialog extends FlxGroup{

	/**
	 * Use this to tell if dialog is showing on the screen or not.
	 */
	public var showing:Bool;

	/**
	 * The text field used to display the text
	 */
	private var field:FlxText;

	/**
	 * Stores all of the text to be displayed. Each "page" is a string in the array
	 */
	private var dialogArray:Array<String>;

	/**
	 * Background rect for the text
	 */
	private var bg:FlxSprite;

	private var width:Int;
	private var height:Int;
	private var backgroundColor:Int;

	var pageIndex:Int;
	var charIndex:Int;
	var displaying:Bool;
	var displaySpeed:Int;
	var elapsed:Float;
	var endPage:Bool;

	override public function new(X:Int=0, Y:Int=0, Width:Int=310, Height:Int=72, displaySpd:Int=1, background:Bool=true, bgColor:Int=0x77000000)
	{
		super();
		width 	= Width;
		height	= Height;
		backgroundColor = bgColor;

		bg = new FlxSprite().makeGraphic(width, height, bgColor);
		bg.scrollFactor.x = bg.scrollFactor.y = 0;

		if(background){
			add(bg);
		}

		field = new FlxText(0, 0, width, "");
		field.scrollFactor.x = field.scrollFactor.y = 0;
		add(field);

		elapsed = 0;

		displaySpeed = displaySpd;
		bg.alpha = 0;
	}

	/**
	 * Call this to set the format of the text
	 */
	public function setFormat(font:String=null, Size:Int=8, Color:Int=0xffffff, Alignment:String=null, ShadowColor:Int=0):Void
	{
		field.setFormat(font, Size, Color, Alignment, ShadowColor);
	}

	/**
	 * Call this from your code to display some dialog
	 */
	public function showDialog(pages:Array<String>):Void
	{
		pageIndex = 0;
		charIndex = 0;
		field.text = pages[0].charAt(0);
		dialogArray = pages;
		displaying = true;
		bg.alpha = 1;
		showing = true;
	}

	/**
	 * The meat of the class. Used to display text over time as well
	 * as control which page is 'active'
	 */
	override public function update():Void
	{
		if(displaying)
		{
			elapsed += FlxG.elapsed;

			if(elapsed > displaySpeed)
			{
				elapsed = 0;
				charIndex++;
				if(charIndex > dialogArray[pageIndex].length)
				{
					//if(endPageCallback!=null) endPageCallback();
					endPage = true;
					displaying = false;
				}

				field.text = dialogArray[pageIndex].substr(0, charIndex);
			}
		}

		if(FlxG.keys.justPressed("X"))
		{
			if(displaying)
			{
				displaying = false;
				endPage = true;
				field.text = dialogArray[pageIndex];
				elapsed = 0;
				charIndex = 0;
			}
			else if(endPage)
			{
				if(pageIndex == dialogArray.length - 1)
				{
					//we're at the end of the pages
					pageIndex = 0;
					field.text = "";
					bg.alpha = 0;
					//if(finishCallback!=null) finishCallback();
					showing = false;
				}
				else
				{
					pageIndex++;
					displaying = true;
				}
			}
		}

		super.update();
	}

	}
