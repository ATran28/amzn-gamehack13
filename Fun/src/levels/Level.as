package levels
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import starling.display.Sprite;

	public class Level extends Sprite
	{
		protected var _tiles:Vector.<StaticGameObject>;
		protected var _exitElevator:AnimatedGameObject;
		protected var _startingPosition:Point;
		protected var _startTime:int;
		public function get tiles():Vector.<StaticGameObject> { return _tiles; }
		public function get exitElevator():AnimatedGameObject { return _exitElevator; }
		public function get startPosition():Point { return _startingPosition; }
		
		public function Level()
		{
			_startTime = getTimer();
		}
		
		public function run():void {
			
		}
		
		public function isFinished():Boolean {
			return false;
		}
		
		public function exit():int
		{
			return -1;
		}
		
		public function getLevelClock():int {
			var currentTime:int = getTimer();
			return currentTime - _startTime;
		}
	}
}