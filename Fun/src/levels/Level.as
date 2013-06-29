package levels
{
	import game.StaticGameObject;
	
	import starling.display.Sprite;

	public class Level extends Sprite
	{
		protected var _tiles:Vector.<StaticGameObject>;
		public function get tiles():Vector.<StaticGameObject> { return _tiles; }
		
		public function Level()
		{
			
		}
		
		public function run():void {
			
		}
		
		public function exit():int
		{
			return -1;
		}
	}
}