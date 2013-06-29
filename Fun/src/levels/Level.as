package levels
{
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import screens.ROOT;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import util.Util;

	public class Level extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";
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
		
		// background music 
		public var music:Sound;
		
		public function Level()
		{
			_startTime = getTimer();
			_score = 0;
			_levelStatus = new Dictionary();

			
//			var musicOn:Image = new Image(ROOT.assets.getTexture("turn_on"));
//			musicOn.x = 300;
//			musicOn.y = 0; 
//			
//			var musicOff:Image = new Image(ROOT.assets.getTexture("turn_off"));
//			musicOff.x = 300;
//			musicOff.y = 0;

			trace("music: " + ROOT.music);
			if (ROOT.music) {
				music = ROOT.assets.getSound(Util.getRandomBackgroundSound());
				if (music != null) {
					music.play();
//					addChild(musicOff);
				}
			} else {
//				addChild(musicOff);
			}

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
