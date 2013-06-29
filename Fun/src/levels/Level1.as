package levels
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import misc.DisplayHelper;
	
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Level1 extends Level
	{
		
		public function Level1()
		{
			super();
			var viewport:Rectangle = Fun.viewport;
			var miny:int = viewport.height - 113;
			var minx:int = viewport.width;
			
			_startingPosition = new Point(0, miny-32-110);
			
			// Set background
			var texture:Texture = ROOT.assets.getTexture("bg1");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			addChild(background);
			
			// Load textures used for this level
			
			
			_tiles = new Vector.<StaticGameObject>();
			var tile:StaticGameObject;
			
			var cury:int = 0
			// Line bottom of screen with grass tile 
			for (var i:int = 0; i != 25; ++i) {
				
				
				tile = DisplayHelper.makeStaticBlock(i, cury, "grass");
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Make line of rock tile
			cury = 7;
			for (i = 0; i != 12; ++i) {
				
				tile = DisplayHelper.makeStaticBlock(i, cury, "rock");
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Make a tree
			var twidth:int = 3;
			var theight:int = 3;
			
			var starty:int = 1;
			var curx:int = 22;
			// For each trunk piece
			for (i = starty; i < starty+theight; ++i) {
				tile = DisplayHelper.makeStaticBlock(curx, i, "trunk");
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			cury = 4;
			var startx:int = 21;
			// For each leaf block
			for (i = startx; i != startx+twidth; ++i) {
				
				tile = DisplayHelper.makeStaticBlock(i, cury, "leaves");
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Exit elevator
			_exitElevator = AnimatedGameObject.makeElevator(64, miny-384, true);
			
			addChild(exitElevator);
			_exitElevator.animate();
			// Entrance elevator
			//
		}
		
		override public function run():void {
			
		}
		
		override public function isFinished():Boolean {
			return true;
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