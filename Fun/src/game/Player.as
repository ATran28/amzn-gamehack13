package game
{
	import screens.ROOT;
	public class Player extends GameObject
	{
		
		public function Player()
		{
			super(ROOT.assets.getTexture("intern"));
			life = 100;
		}
		
		private static var life:int;
		public static function set hp(value:int):void { life = value; }
		public static function get hp():int { return life; }
	}
}