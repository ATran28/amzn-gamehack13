package game
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class AnimatedGameObject extends Sprite
	{
		public var mcmap:Object;
		private var mc:MovieClip;
		public function AnimatedGameObject()
		{
			super();
			
			mcmap = new Object();
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}
		
		public function set mclip(value:MovieClip):void { mc = value; }
		public function get mclip():MovieClip { return mc; }
	}
}