package game
{	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class StaticGameObject extends Sprite
	{
		
		private var img:Image;
		public function StaticGameObject(img:Image)
		{
			super();
			this.img = img;
			addChild(this.img);
			
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}
		
		public function set image(value:Image):void { img = value; }
		public function get image():Image { return img; }
	}
}