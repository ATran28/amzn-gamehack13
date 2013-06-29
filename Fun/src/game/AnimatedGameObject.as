package game
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import screens.ROOT;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class AnimatedGameObject extends Sprite
	{
		private var movieMap:Dictionary;
		private var activeMovie:MovieClip;

		public function AnimatedGameObject()
		{
			super();
			movieMap = new Dictionary();
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			
			visible = true;
		}

		public function setActiveMovieNow(name:String):void {
			if (activeMovie.name == name) {
				return;
			}
			if (activeMovie != null) {
				// remove the old active from juggler
				Starling.juggler.remove(activeMovie);
				// and also from stage
				removeChild(activeMovie);
			}
			if (!movieMap.hasOwnProperty(name)) {
				trace("no such movie: " + name);	
			}
			// set the handle
			activeMovie = movieMap[name]; 
			activeMovie.name = name; 

			// add to juggler NOW!
			Starling.juggler.add(activeMovie);
			
			// start 
			addChild(activeMovie);
			var sound:Sound = ROOT.assets.getSound(name);
			if (sound != null) {
				sound.play();
			}
		}

		public function setActiveMovie(name:String):void {
			if (activeMovie != null) {
				// remove the old active from juggler
				Starling.juggler.remove(activeMovie);
				// and also from stage
				removeChild(activeMovie);
			}
			if (!movieMap.hasOwnProperty(name)) {
				trace("no such movie: " + name);	
			}
			// set the handle
			activeMovie = movieMap[name]; 
			// move to center for sphere collision detection
//			activeMovie.x = - activeMovie.width / 2;
//			activeMovie.x = - activeMovie.width / 2;
//			activeMovie.pivotX = activeMovie.width / 2;
//			activeMovie.pivotY = activeMovie.height / 2;
			// add to juggler
			
			// start 
			addChild(activeMovie);
		}
		
		public function animate():void {
			Starling.juggler.add(activeMovie);
		}
		
		public function getActiveMovie():MovieClip {
			return activeMovie;
		}

		public function getMovie(name:String):MovieClip { 
			return movieMap[name]; 
		}

		public function addMovie(name:String, movie:MovieClip):void { 
			movieMap[name] = movie;
		}
		
		public function removeMovie(name:String):void {
			movieMap[name] = null;
		}
		
		public static function makeElevator(x:int, y:int, closed:Boolean):AnimatedGameObject {
			var result:AnimatedGameObject = new AnimatedGameObject();
			result.x = x;
			result.y = y;
			result.addMovie("closed", new MovieClip(ROOT.atlas.getTextures("elevator_open"), 7));
			result.addMovie("open", new MovieClip(ROOT.atlas.getTextures("elevator_close"), 7));
			result.movieMap["closed"].loop = false;
			result.movieMap["open"].loop = false;
			if (closed) {
				result.setActiveMovie("closed");
			} else {
				result.setActiveMovie("open");
			}
			
			return result;
		}
		
	}
}
