package game
{
	import screens.ROOT;
	import starling.display.Image;

	public class Player extends StaticGameObject
	{
		
		public function Player()
		{
			super();
			imgmap["default"] = new Image(ROOT.assets.getTexture("intern"));
			image = imgmap["default"];
			life = 100;
		}
		
		private static var life:int;
		public static function set hp(value:int):void { life = value; }
		public static function get hp():int { return life; }
	}
}