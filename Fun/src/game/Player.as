package game
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import screens.ROOT;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;

	public class Player extends AnimatedGameObject
	{
		// inherit mclip
		private static var life:int;
		private static var velocity:Vector3D;
		
		public function Player()
		{
			super();
			life = 100;
			initPlayerMovies();
			velocity = new Vector3D();
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
			kickLeftMovie.scaleX = -0.5;
			kickLeftMovie.scaleY = -0.5;
			kickLeftMovie.loop = true;
			
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
		
		private var gravity:Number = 9.8;
		public function updateVelocity(newVelocity:Vector3D):void{
			velocity = newVelocity;
		}
		
		public function getVelocity():Vector3D{
			return velocity;
		}
		
		public function updatePosition():void{
			velocity.y += gravity;
			
			var playerPosition:Point = new Point(x, y);
			
			var v:Vector3D = new Vector3D(velocity.x, velocity.y);
			trace("velocity: " + velocity);
			var speed:Number = velocity.length/10;
			v.normalize();
			v.scaleBy(speed);
			
			playerPosition = playerPosition.add(new Point(v.x, v.y));
			x = playerPosition.x;
			y = playerPosition.y;
			
			
			//			detectCollsions(intern1);
		}
	}
}
