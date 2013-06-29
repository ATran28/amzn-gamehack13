package misc
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class DisplayHelper
	{
		
		
		
		private static const vertOffset:int = 113;
		private static var viewport:Rectangle;
		private static var textures:Dictionary;
		
		
		
		public static function init():void {
			viewport = Fun.viewport;
			textures = new Dictionary();
			textures["grass"] = ROOT.assets.getTexture("grass32");
			textures["rock"] = ROOT.assets.getTexture("rock32");
			textures["trunk"] = ROOT.assets.getTexture("trunk32");
			textures["leaves"] = ROOT.assets.getTexture("leaves32");
			textures["metal1"] = ROOT.assets.getTexture("metal1-32");
			textures["metal2"] = ROOT.assets.getTexture("metal2-32");
			
		}
		
		public static function makeStaticBlock(x:int, y:int, type:String):StaticGameObject {
			var result:StaticGameObject = new StaticGameObject();
			result.x = (x*32);
			result.y = (viewport.height - vertOffset) - ((y+1) * 32);
			result.name = type + "." + x + "." + y;
			result.setActiveImage(new Image(textures[type]));
			
			if (type == "trunk") {
				result.blocking = false;
			}
			else {
				result.blocking = true;
			}
			
			return result;
		}
		
		public static function makeAnimatedElevator(x:int, y:int, closed:Boolean):AnimatedGameObject {
			var result:AnimatedGameObject = new AnimatedGameObject();
			result.x = (x*32);
			result.y = (viewport.height - vertOffset) - ((y+1) * 32);
			
			result.addMovie2("closed", new MovieClip(ROOT.atlas.getTextures("elevator_open"), 7), false);
			result.addMovie2("open", new MovieClip(ROOT.atlas.getTextures("elevator_close"), 7), false);
			
			if (closed) {
				result.setActiveMovie("closed");
			} else {
				result.setActiveMovie("open");
			}
			
			return result;
		}
	}
}