package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Utilized
	 */
	public class Tile extends Sprite
	{
		private var _text:TextField;
		
		public function Tile() 
		{
			graphics.lineStyle(1, 0);
			graphics.beginFill(0xff0000);
			graphics.drawRect(0, 0, 60, 60);
			graphics.endFill();
			
			_text = new TextField();
			_text.mouseEnabled = false;
			_text.autoSize = TextFieldAutoSize.CENTER;
			_text.defaultTextFormat = new TextFormat(null, 50);
			_text.text = "";
			_text.x = 30 - _text.width / 2;
			_text.y = 30 - _text.height / 2;
			addChild(_text);
		}
		
		public function get text():String { return _text.text; }
		
		public function set text(value:String):void 
		{
			_text.text = value;
			_text.y = 30 - _text.height / 2;
		}
		
	}

}