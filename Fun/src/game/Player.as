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
		private const speedScale:Number = 30;
		
		private var _caffeineLevel:Number = 0.0;
		private var _caffeineDecay:Number = -0.0001;
		
		public var inTheAir:Boolean;
		
		public function Player()
		{
			super();
			life = 100;
			initPlayerMovies();
			velocity = new Vector3D();
			
			// This help to detect first hit grount play sound
			inTheAir = false;
		}
		
		public static function set hp(value:int):void { life = value; }
		public static function get hp():int { return life; }
		
		// Initiate Our Intern 	
		// Load multiple movies.
		// Set only one as active
		private function initPlayerMovies():void {
			// Add movie	
			var atlas:TextureAtlas = ROOT.assets.getTextureAtlas("intern");

			// Add Kick Left
			var kickLeftMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_cape_"), 10);
			kickLeftMovie.scaleX = 0.5;
			kickLeftMovie.scaleY = 0.5;
			kickLeftMovie.loop = true;
			this.addMovie("kick_left", kickLeftMovie);
			
			// Add Kick Right movie
			var kickRightMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_cape_"), 10);
			kickRightMovie.x += kickRightMovie.width / 2;
			kickRightMovie.scaleX = -0.5;
			kickRightMovie.scaleY = 0.5;
			kickRightMovie.loop = true;
			this.addMovie("kick_right", kickRightMovie);
			
			// Add standing movie
			var standing:MovieClip = new MovieClip(atlas.getTextures("standing_"), 10);
			standing.scaleX = 0.5;
			standing.scaleY = 0.5;
			standing.loop = true;
			this.addMovie("standing", standing);

			// Add crouch movie
			var crouch:MovieClip = new MovieClip(atlas.getTextures("crouch_"), 10);
			crouch.scaleX = 0.5;
			crouch.scaleY = 0.5;
			crouch.loop = true;
			this.addMovie("crouch", crouch);

			// Add up_cape movie
			var up:MovieClip = new MovieClip(atlas.getTextures("up_cape_"), 10);
			up.scaleX = 0.5;
			up.scaleY = 0.5;
			up.loop = true;
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
			var speed:Number = velocity.length/speedScale;
			v.normalize();
			v.scaleBy(speed);
			
			playerPosition = playerPosition.add(new Point(v.x, v.y));
			x = playerPosition.x;
			y = playerPosition.y;
			
			caffeineLevel = Math.max(0.0, caffeineLevel + caffeineDecay);
		
			trace("caffeineLevel: " + caffeineLevel);
			
			if(velocity.y > 0){	//Down
				if(velocity.x > 0){	//Right
					kickRight();
				} else{	//Left
					kickLeft();
				}
			} else{	//Up
				jumpUp();
				this.inTheAir = true;
			}
		}
			//			detectCollsions(intern1);
		public function kickLeft():void {
			this.setActiveMovieNow("kick_left");
		}

		public function kickRight():void {
			this.setActiveMovieNow("kick_right");
		}

		public function stand():void {
			this.setActiveMovieNow("standing");
		}

		public function crouch():void {
			this.setActiveMovieNow("crouch");
		}

		public function jumpUp():void {
			this.setActiveMovieNow("up");
		}
		
		public function set caffeineLevel(value:Number):void { _caffeineLevel = value; }
		public function get caffeineLevel():Number { return _caffeineLevel; }
		public function set caffeineDecay(value:Number):void { _caffeineDecay = value; }
		public function get caffeineDecay():Number { return _caffeineDecay; }
	}
}
