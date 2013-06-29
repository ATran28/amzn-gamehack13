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
			initPlayerMovies();
		}
		
		public static function set hp(value:int):void { life = value; }
		public static function get hp():int { return life; }
		
		// Initiate Our Intern 	
		// Load multiple movies.
		// Set only one as active
		private function initPlayerMovies():void {
			// Add movie	
			var atlas:TextureAtlas = ROOT.assets.getTextureAtlas("intern");
			var kickLeftMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_"), 10);
			
			// TODO unify scale
			kickLeftMovie.scaleX = 0.5;
			kickLeftMovie.scaleY = 0.5;
			kickLeftMovie.loop = true;
			
			this.addMovie("kick_left", kickLeftMovie);
			
			// Add another movie
			var kickRightMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_"), 10);
			kickRightMovie.scaleX = -0.5;
			kickRightMovie.scaleY = 0.5;
			kickRightMovie.loop = true;
			
			this.addMovie("kick_right", kickRightMovie);
			
			// Add another movie
			var standing:MovieClip = new MovieClip(atlas.getTextures("standing"), 10);
			standing.scaleX = 0.5;
			standing.scaleY = 0.5;
			standing.loop = false;

			this.addMovie("standing", standing);

			// Set one movie as active
			this.setActiveMovie("standing");	
		}
		
		public function kickLeft():void {
			this.setActiveMovie("kick_left");
		}

		public function kickRight():void {
			this.setActiveMovie("kick_right");
		}

		public function stand():void {
			this.setActiveMovie("standing");
		}
	}
}
