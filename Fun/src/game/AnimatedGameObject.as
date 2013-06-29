package game
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class AnimatedGameObject extends Sprite
	{
		private var mc:MovieClip;
		public function AnimatedGameObject(mc:MovieClip)
		{
			super();
			this.mc = mc;
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}
		
		public function set mclip(value:MovieClip):void { mc = value; }
		public function get mclip():MovieClip { return mc; }
	}
}