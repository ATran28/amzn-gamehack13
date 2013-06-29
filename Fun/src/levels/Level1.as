package levels
{
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.geom.Point;

	public class Level1 extends Level
	{
		private var textures:Dictionary;
		private var score:int;
		
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
			textures = new Dictionary();
			textures["grass"] = ROOT.assets.getTexture("grass32");
			textures["rock"] = ROOT.assets.getTexture("rock32");
			textures["trunk"] = ROOT.assets.getTexture("trunk32");
			textures["leaves"] = ROOT.assets.getTexture("leaves32");
			
			_tiles = new Vector.<StaticGameObject>();
			var tile:StaticGameObject;
			
			// Line bottom of screen with grass tile 
			for (var i:int = 0; i != 25; ++i) {
				tile = StaticGameObject.makeTile(
					i*32, 
					miny-32,
					new Image(textures["grass"]));
				tile.name = "grass"+i;
				tile.blocking = true;
				//tile.friction = 5;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Make line of rock tile
			for (i = 0; i != 10; ++i) {
				tile = StaticGameObject.makeTile(
					i*32, 
					miny-256, 
					new Image(textures["rock"]));
				tile.name = "rock"+i;
				tile.blocking = true;
				
				addChild(tile);
				_tiles.push(tile);
			}
			
			// Make a tree
			var twidth:int = 3;
			var theight:int = 3;
			// For each trunk piece
			for (i = 0; i != theight; ++i) {
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
			
			// Exit elevator
			_exitElevator = AnimatedGameObject.makeElevator(64, miny-384, true);
			
			addChild(exitElevator);
			_exitElevator.animate();
			// Entrance elevator
			//
			
			score = 0;
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