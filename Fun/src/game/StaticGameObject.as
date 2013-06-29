package game
{	
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class StaticGameObject extends Sprite
	{
		private var imgMap:Dictionary;
		private var activeImg:Image;

		public function StaticGameObject()
		{
			super();
			imgMap = new Dictionary();
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}
		
		public function getActiveImage():Image {
			return activeImg;
		}
		
		public function addImage(name:String, value:Image):void {
			imgMap[name] = value;	
		}

		public function getImage(name:String):Image { 
			return imgMap[name]; 
		}
		
		public function removeImage(name:String):void {
			imgMap[name] = null;
		}
	}
}