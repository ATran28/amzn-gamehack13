package levels
{
	import flash.desktop.NativeApplication;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.StaticGameObject;
	
	import misc.DisplayHelper;
	
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class GeneratedLevel extends Level
	{
		private var parser:AsciiLevelParser; 
		public function GeneratedLevel(ascii:String)
		{
			super();
			
			didCompleteLevel = false;
			parser = new AsciiLevelParser();
			var success:Boolean = parser.parse(ascii);
			if(!success){
				trace("--------------------------Parse failed...check ascii-------------------------");
				trace("--------------------------Parse failed...check ascii-------------------------");
				trace("--------------------------Parse failed...check ascii-------------------------");
				trace("--------------------------Parse failed...check ascii-------------------------");
				trace("--------------------------Parse failed...check ascii-------------------------");
				NativeApplication.nativeApplication.exit();
			}
			
			var viewport:Rectangle = Fun.viewport;
			var miny:int = viewport.height - 113;
			var minx:int = viewport.width;
			
			_startingPosition = parser.playerPoint;
			
			// Set background
			var texture:Texture = ROOT.assets.getTexture("bg1");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			addChild(background);
			
			_tiles = parser.statics;
			for each(var tile:StaticGameObject in _tiles){
				addChild(tile);	
			}
			_notableTiles = parser.notable;
			for each(var ntile:StaticGameObject in _notableTiles) {
				addChild(ntile);
			}
			
			_levelStatus["tilesToFind"] = notableTiles.length;
			
			//Handle Elevator
			_exitElevator = parser.elevator;
			
			addChild(exitElevator);
//			
			
		}
		
		override public function run():void {
			
		}
		var didCompleteLevel:Boolean;
		override public function isFinished():Boolean {
			if ( levelStatus["tilesToFind"] <= 0) {
				if (!didCompleteLevel) {
					didCompleteLevel = true;
					exitElevator.animate();
				}
				return true;
			}
			return false;
		}
		
		
		override public function exit():int
		{
			for (var tile:StaticGameObject in tiles) {
				removeChild(tile);
			}
			return score;
		}
	}
}