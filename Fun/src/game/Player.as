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
		private const gravity:Number = 9.8;
		private var _caffeineLevel:Number = 0.0;
		private var _caffeineDecay:Number = -0.01;
		
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
			var atlas:TextureAtlas = ROOT.atlas;
			
			// Add Kick Left
			var kickLeftMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_cape_"), 10);
			kickLeftMovie.scaleX = 0.5;
			kickLeftMovie.scaleY = 0.5;
			kickLeftMovie.loop = true;
			this.addMovie("kick_left", kickLeftMovie);
			
			// Add Kick Right movie
			var kickRightMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_cape"), 10);
			kickRightMovie.scaleX = -0.5;
			kickRightMovie.scaleY = 0.5;
			kickRightMovie.loop = true;
			this.addMovie("kick_right", kickRightMovie);
			
			// Add standing movie
			var standing:MovieClip = new MovieClip(atlas.getTextures("standing_"), 10);
			standing.scaleX = 0.5;
			standing.scaleY = 0.5;
			standing.loop = false;
			this.addMovie("standing", standing);

			// Add crouch movie
			var crouch:MovieClip = new MovieClip(atlas.getTextures("crouch_"), 10);
			crouch.scaleX = 0.5;
			crouch.scaleY = 0.5;
			crouch.loop = false;
			this.addMovie("crouch", crouch);

			// Add up_cape movie
			var up:MovieClip = new MovieClip(atlas.getTextures("up_cape_"), 10);
			up.scaleX = 0.5;
			up.scaleY = 0.5;
			up.loop = false;
			this.addMovie("up", up);
			
			
			// Set one movie as active
			this.setActiveMovie("standing");	
		}
		
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
			var speed:Number = velocity.length/10;
			v.normalize();
			v.scaleBy(speed);
			
			playerPosition = playerPosition.add(new Point(v.x, v.y));
			x = playerPosition.x;
			y = playerPosition.y;
			
			caffeineLevel = Math.max(0.0, caffeineLevel + caffeineDecay);
		
			trace("caffeineLevel: " + caffeineLevel);
		}
			//			detectCollsions(intern1);
		public function kickLeft():void {
			this.setActiveMovie("kick_left");
		}

		public function kickRight():void {
			this.setActiveMovie("kick_right");
		}

		public function stand():void {
			this.setActiveMovie("standing");
		}

		public function crouch():void {
			this.setActiveMovie("crouch");
		}

		public function jumpUp():void {
			this.setActiveMovie("up");
		}
		
		public function set caffeineLevel(value:Number):void { _caffeineLevel = value; }
		public function get caffeineLevel():Number { return _caffeineLevel; }
		public function set caffeineDecay(value:Number):void { _caffeineDecay = value; }
		public function get caffeineDecay():Number { return _caffeineDecay; }
	}
}
