package screens
{
	import starling.display.Sprite;
	
	public class Patr extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Patr()
		{
			// Do something
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}

	}
}