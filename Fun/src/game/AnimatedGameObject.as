package game
{
	import flash.utils.Dictionary;
	
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
	}
}
