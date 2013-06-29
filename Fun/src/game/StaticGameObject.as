package game
{	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class StaticGameObject extends Sprite
	{
		public var imgmap:Object;
		private var img:Image;
		public function StaticGameObject()
		{
			super();
			imgmap = new Object();
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}
		
		public function set image(value:Image):void {
			if (img) removeChild(img);
			img = value; 
			addChild(img);
		}
		public function get image():Image { return img; }
	}
}