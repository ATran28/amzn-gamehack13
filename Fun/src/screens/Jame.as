package screens
{
	import starling.display.Sprite;
	
	public class Jame extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Jame()
		{
			// Do something
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}

	}
}