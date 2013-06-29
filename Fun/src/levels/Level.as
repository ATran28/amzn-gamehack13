package levels
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import starling.display.Sprite;

	public class Level extends Sprite
	{
		protected var _levelStatus:Dictionary;
		protected var _tiles:Vector.<StaticGameObject>;
		protected var _notableTiles:Vector.<StaticGameObject>;
		protected var _exitElevator:AnimatedGameObject;
		protected var _startingPosition:Point;
		protected var _startTime:int;
		protected var _score:int;
		public function get tiles():Vector.<StaticGameObject> { return _tiles; }
		public function get notableTiles():Vector.<StaticGameObject> { return _notableTiles; }
		public function get exitElevator():AnimatedGameObject { return _exitElevator; }
		public function get startPosition():Point { return _startingPosition; }
		public function get score():int { return _score; }
		public function get levelStatus():Dictionary { return _levelStatus; }
		
		public function Level()
		{
			_startTime = getTimer();
			_score = 0;
			_levelStatus = new Dictionary();
			
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