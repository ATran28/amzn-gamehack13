package misc
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.DisplayObject;
	import starling.display.Image;

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
	}
}