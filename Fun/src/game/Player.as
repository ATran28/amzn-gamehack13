package game
{
	import screens.ROOT;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class Player extends AnimatedGameObject
	{
		// inherit mclip
		private static var life:int;

		public function Player()
		{
			super();
//			addMovie("default", movie);
			life = 100;
		}
		
		public static function set hp(value:int):void { life = value; }
		public static function get hp():int { return life; }
	}
}