package screens
{
	import starling.display.Sprite;
	
	public class Owen extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Owen()
		{
			// Do something
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}

	}
}