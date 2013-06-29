package util
{
	import flash.media.Sound;

	public class Util
	{
		public static function getRandomHitGroundSound():String
		{
			var number:Number = Math.ceil(Math.random() * 4);
		
			return "hit_" + number;
		}

		public static function getRandomBackgroundSound():String
		{
			var number:Number = Math.ceil(Math.random() * 3);
		
			return "eric_skiff_" + number;
		}
	}
}