package game
{
	import screens.ROOT;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;

	public class Player extends AnimatedGameObject
	{
		// inherit mclip
		private static var life:int;

		public function Player()
		{
			super();
			life = 100;
			initPlayer();
		}
		
		public static function set hp(value:int):void { life = value; }
		public static function get hp():int { return life; }
		
		// Initiate Our Intern 	
		// Load multiple movies.
		// Set only one as active
		private function initPlayer() {
			// Add movie	
			var atlas:TextureAtlas = ROOT.assets.getTextureAtlas("kick_left");
			var kickLeftMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_"), 10);
			
			// TODO unify scale
			kickLeftMovie.scaleX = 0.5;
			kickLeftMovie.scaleY = 0.5;
			kickLeftMovie.loop = true;
			
			this.addMovie("kick_left", kickLeftMovie);
			
			
			// Add another movie
			
			
			// Set one movie as active
			this.setActiveMovie("kick_left");	
		}
	}
}
