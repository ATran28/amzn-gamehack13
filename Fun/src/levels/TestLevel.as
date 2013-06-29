package levels
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class TestLevel extends Level
	{
		private var textures:Dictionary;
		private var score:int;
		
		public function TestLevel()
		{
			super();
			var backgroundMusic:Sound = ROOT.assets.getSound("eric_skiff_1");
			
			ROOT.assets.playSound("eric_skiff_1");
			_startingPosition = new Point(0, 50);
			
			var viewport:Rectangle = Fun.viewport;
			var miny:int = viewport.height - 113;
			var minx:int = viewport.width;
			// Set background
			var texture:Texture = ROOT.assets.getTexture("bg1");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			addChild(background);
			
			
			// Load textures used for this level
			textures = new Dictionary();
			textures["grass"] = ROOT.assets.getTexture("grass32");
			textures["rock"] = ROOT.assets.getTexture("rock32");
			textures["trunk"] = ROOT.assets.getTexture("trunk32");
			textures["leaves"] = ROOT.assets.getTexture("leaves32");
			
			_tiles = new Vector.<StaticGameObject>();
			var tile:StaticGameObject;
			
			// Line bottom of screen with grass tile 
			for (var w:int = 0; w < viewport.width; w += textures["grass"].width) {
				tile = StaticGameObject.makeTile(
					w, 
					miny-256,
					new Image(textures["grass"]));
				tile.name = "grass" + w;
				tile.blocking = true;
				//tile.friction = 5;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Make a line of rock
			for (w = 0; w <= 10; ++w) {
				tile = StaticGameObject.makeTile(
					w*textures["rock"].width, 
					miny-500, 
					new Image(textures["rock"]));
				tile.name = "rock"+w;
				tile.blocking = true;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Make a tree
			var twidth:int = 3;
			var theight:int = 5;
			// For each trunk piece
			for (var i:int = 0; i != theight; ++i) {
				tile = StaticGameObject.makeTile(
					(minx-96), 
					(miny-64)-(i*32), 
					new Image(textures["trunk"]));
				tile.blocking = false;
				tile.name = "trunk"+i;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// For each leaf block
			for (i = 0; i != twidth; ++i) {
				tile = StaticGameObject.makeTile(
					(minx-128)+(i*32), 
					(miny-64)-(theight*32), 
					new Image(textures["leaves"]));
				tile.blocking = true;
				tile.name = "leaves"+i;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			score = 0;
		}
		
		override public function run():void {
			
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