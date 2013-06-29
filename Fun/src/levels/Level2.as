package levels
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Level2 extends Level
	{
		private var textures:Dictionary;
		public function Level2()
		{
			super();
			var viewport:Rectangle = Fun.viewport;
			var miny:int = viewport.height - 113;
			var minx:int = viewport.width;
			
			_startingPosition = new Point(0, miny-32-110);
			
			// Set background
			var texture:Texture = ROOT.assets.getTexture("bg1-2");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			addChild(background);
			
			
			
			_tiles = new Vector.<StaticGameObject>();
			var tile:StaticGameObject;
			
			// Line bottom of screen with grass tile 
			for (var i:int = 0; i != 25; ++i) {
//				tile = StaticGameObject.makeTile(
//					i*32, 
//					miny-32,
//					new Image(textures["grass"]));
//				tile.name = "grass"+i;
//				tile.blocking = true;
				//tile.friction = 5;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			var startxpos:int;
			var startypos:int;
			var length:int;
			
			//start
			//for (i = 0; i < 
			
		}
		
		override public function run():void {
			
		}
		
		override public function exit():int
		{
			return -1;
		}
	}
}