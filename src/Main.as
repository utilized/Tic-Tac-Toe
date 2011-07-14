package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Utilized
	 */
	public class Main extends Sprite 
	{
		private var tilesLeft:int = 9;
		private var isGameOver:Boolean = false;
		private var gameOverText:TextField;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addTiles();
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (!isGameOver) 
			{
				if (e.target is Tile) 
				{
					var tile:Tile = e.target as Tile;
					if (tile.text == "") 
					{
						tile.text = "X";
						tilesLeft--;
						
						//check for win
						if (checkForWin(tile.name))
						{
							gameEnd("Player Wins");
						}
						else
						{
							if (tilesLeft > 0)
							{
								//"AI" here
								var tileName:String;
								do
								{
									tileName = Math.floor(Math.random() * 3) + "_" + Math.floor(Math.random() * 3);
									tile = getChildByName(tileName) as Tile;
								}while (tile.text != "");
								
								tile.text = "O";
								tilesLeft--;
								
								//check for win
								if (checkForWin(tile.name))
								{
									gameEnd("AI Wins");
								}
							}
							else
							{
								gameEnd("Tie");
							}
						}
					}
				}
			}
			else
			{
				resetAll();
			}
		}
		
		private function resetAll():void 
		{
			tilesLeft = 9;
			isGameOver = false;
			
			for (var i:int = 0; i < 3; i++) //y
			{
				for (var j:int = 0; j < 3; j++) //x
				{
					var tile:Tile = getChildByName(j + "_" + i) as Tile;
					tile.text = "";
				}
			}
			
			removeChild(gameOverText);
		}
		
		private function gameEnd(arg1:String):void 
		{
			isGameOver = true;
			
			gameOverText = new TextField();
			gameOverText.border = true;
			gameOverText.background = true;
			gameOverText.backgroundColor = 0xff0000;
			gameOverText.alpha = 0.9;
			gameOverText.mouseEnabled = false;
			gameOverText.autoSize = TextFieldAutoSize.CENTER;
			gameOverText.defaultTextFormat = new TextFormat(null, 12, null, null, null, null, null, null, "center");
			gameOverText.text = "Game Over\n" + arg1 + "\n(Click anywhere to play again)";
			gameOverText.x = this.width / 2 - gameOverText.width / 2;
			gameOverText.y = this.height / 2 - gameOverText.height / 2;
			addChild(gameOverText);
		}
		
		private function checkForWin(name:String):Boolean
		{
			var coords:Array = name.split("_");
			
			if (checkHor(coords[0], coords[1]) == 3 || checkVer(coords[0], coords[1]) == 3 || 
				checkDiL(coords[0], coords[1]) == 3 || checkDiR(coords[0], coords[1]) == 3) 
			{
				return true;
			}
			return false;
		}
		
		private function checkHor(col:uint, row:uint):uint
		{
			var tile:Tile = getChildByName(col + "_" + row) as Tile;
			var val:String = tile.text;
			var cnt:uint=1;
			var tmp:int = col;
			
			while (checkItem(val, --tmp, row) && tmp >= 0) 
			{
				cnt++;
			}
			
			tmp = col;
			
			while (checkItem(val, ++tmp, row) && tmp < 3) 
			{
				cnt++;
			}
			
			return cnt;
		}
		
		private function checkVer(col:uint, row:uint):uint
		{
			var tile:Tile = getChildByName(col + "_" + row) as Tile;
			var val:String = tile.text;
			var cnt:uint=1;
			var tmp:int = row;
			
			while (checkItem(val, col, --tmp) && tmp >= 0) 
			{
				cnt++;
			}
			
			tmp = row;
			
			while (checkItem(val, col, ++tmp) && tmp < 3) 
			{
				cnt++;
			}
			
			return cnt;
		}
		
		private function checkDiL(col:uint, row:uint):uint
		{
			var tile:Tile = getChildByName(col + "_" + row) as Tile;
			var val:String = tile.text;
			var cnt:uint=1;
			var tmpr:int = row;
			var tmpc:int = col;
			
			while (checkItem(val, --tmpc, --tmpr) && tmpc >= 0 && tmpr >= 0) 
			{
				cnt++;
			}
			
			tmpc = col;
			tmpr = row;
			
			while (checkItem(val, ++tmpc, ++tmpr) && tmpc < 3 && tmpr < 3) 
			{
				cnt++;
			}
			
			return cnt;
		}
		
		private function checkDiR(col:uint, row:uint):uint
		{
			var tile:Tile = getChildByName(col + "_" + row) as Tile;
			var val:String = tile.text;
			var cnt:uint=1;
			var tmpr:int = row;
			var tmpc:int = col;
			
			while (checkItem(val, ++tmpc, --tmpr) && tmpc < 3 && tmpr >= 0) 
			{
				cnt++;
			}
			
			tmpc = col;
			tmpr = row;
			
			while (checkItem(val, --tmpc, ++tmpr) && tmpc >= 0 && tmpr < 3) 
			{
				cnt++;
			}
			
			return cnt;
		}
		
		private function checkItem(val:String, col:uint, row:uint):Boolean
		{
			if (row >= 0 && row < 3 && col >= 0 && col < 3) 
			{
				var tile:Tile = getChildByName(col + "_" + row) as Tile;
				
				return tile.text == val;
			}
			return false;
		}
		
		private function addTiles():void 
		{
			for (var i:int = 0; i < 3; i++) //y
			{
				for (var j:int = 0; j < 3; j++) //x
				{
					var tile:Tile = new Tile();
					tile.name = j + "_" + i; //col_row
					tile.x = j * tile.width;
					tile.y = i * tile.height;
					addChild(tile);
				}
			}
		}
	}
	
}