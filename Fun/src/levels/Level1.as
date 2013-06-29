package levels
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Level1 extends Sprite
	{
		private var tiles:Vector.<StaticGameObject>;
		private var textures:Dictionary;
		private var score:int;
		
		public function Level1()
		{
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
			//background.smoothing = true;
			addChild(background);
			
			// Load textures used for this level
			textures = new Dictionary();
			textures["grass"] = ROOT.assets.getTexture("grass32");
			textures["rock"] = ROOT.assets.getTexture("rock32");
			textures["trunk"] = new Image(ROOT.assets.getTexture("trunk32"));
			textures["leaves"] = new Image(ROOT.assets.getTexture("leaves32"));
			
			tiles = new Vector.<StaticGameObject>();
			var tile:StaticGameObject;
			
			// Line bottom of screen with grass tile 
			for (var i:int = 0; i != 25; ++i) {
				tile = StaticGameObject.makeTile(
					i*32, 
					miny-32,
					new Image(textures["grass"]));
				addChild(tile);
				tiles.push(tile);
			}
			
			// Make line of rock tile
			for (i = 0; i != 10; ++i) {
				tile = StaticGameObject.makeTile(
					i*32, 
					miny-96, 
					new Image(textures["rock"]));
				addChild(tile);
				tiles.push(tile);
			}
			score = 0;
		}
		
		public function run():void {
			
		}
		
		public function exit():int
		{
			return score;
		}
	}
}