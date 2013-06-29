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
			
			_notableTiles = new Vector.<StaticGameObject>();
			
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
			
			_startingPosition = new Point(50, 100);
			
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
			
			_levelStatus["tilesToFind"] = notableTiles.length;
			
			//Handle Elevator
			_exitElevator = parser.elevator;
			
			addChild(exitElevator);
//			
			
		}
		
		override public function run():void {
			
		}
		
		override public function isFinished():Boolean {
			if ( levelStatus["tilesToFind"] == 0 ) {
				exitElevator.animate();
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