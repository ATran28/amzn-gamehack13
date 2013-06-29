package game
{	
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class StaticGameObject extends Sprite
	{
		private var _blocking:Boolean;
		
		private var activeImg:Image;
		
		public function StaticGameObject()
		{
			super();
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}
		
		public function setActiveImage(img:Image):void {
			if (activeImg) removeChild(activeImg);
			activeImg = img;
			addChild(activeImg);
		}
		
		public static function makeTile(x:int, y:int, image:Image):StaticGameObject{
			var result:StaticGameObject = new StaticGameObject();
			result.setActiveImage(image);
			result.x = x;
			result.y = y;
			return result;
		}
		
		public function set blocking(value:Boolean):void { _blocking = value; }
		public function get blocking():Boolean { return _blocking; }
	}
}