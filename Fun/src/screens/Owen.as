package screens
{
	import flash.geom.Rectangle;
	
	import levels.Level1;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Owen extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";
		
		
		public function Owen()
		{
			// Do something
			
			
			
			var level1:Level1 = new Level1();
			addChild(level1);
			
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}

	}
}