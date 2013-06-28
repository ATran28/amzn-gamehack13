package screens
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class ROOT extends Sprite
	{
		private var mActiveScene:Sprite;
	
		private static var sAssets:AssetManager;
		
		// manual load particle
		public static var fire:ParticleDesignerPS;

		
		
		[Embed(source="/resources/fire.pex", mimeType="application/octet-stream")]
		private static const FireConfig:Class;

		[Embed(source="/resources/fire.png")]
		private static const FireParticle:Class;
		// end of manual load 
		
		public function ROOT()
		{
			addEventListener(Menu.START_GAME, onStartGame);
			addEventListener(Game.GAME_OVER,  onGameOver);
			
			// enter Sub Screens
			addEventListener(Menu.ANTH,  onAnth);
			addEventListener(Menu.OWEN,  onOwen);
			addEventListener(Menu.PATR,  onPatr);
			addEventListener(Menu.JAME,  onJame);
		}
		
		public function start(assets:AssetManager):void
		{
			// the asset manager is saved as a static variable; this allows us to easily access
			// all the assets from everywhere by simply calling "Root.assets"
			sAssets = assets;
			
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			var viewport:Rectangle = Fun.viewport;
			
			var progressBar:ProgressBar = new ProgressBar(175, 20);
			progressBar.x = (viewport.width  - progressBar.width)  / 2;
			progressBar.y = (viewport.height - progressBar.height) / 2;
			progressBar.y = viewport.height * 0.85;
			addChild(progressBar);
			
			// manual load particle
			var load:Boolean = false;

			assets.loadQueue(function onProgress(ratio:Number):void
			{
				trace("Haha" + ratio);
				progressBar.ratio = ratio;
				
				// manual load particle
				if (!load) {
					var fireConfig:XML = XML(new FireConfig());
					var fireTexture:Texture = Texture.fromBitmap(new FireParticle());
					fire = new ParticleDesignerPS(fireConfig, fireTexture);
					load = true;
				}
				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
						progressBar.removeFromParent(true);
						showScene(Menu);
					}, 0.15);
			});
		}
	
		
		
		private function showScene(screen:Class):void
		{
			if (mActiveScene) mActiveScene.removeFromParent(true);
			mActiveScene = new screen();
			addChild(mActiveScene);
		}
			
		private function onGameOver(event:Event, score:int):void
		{
			trace("Game Over! Score: " + score);
			showScene(Menu);
		}			
		
		private function onStartGame(event:Event, gameMode:String):void
		{
			trace("Game starts! Mode: " + gameMode);
			showScene(Game);
		}

		public static function get assets():AssetManager { return sAssets; }

		// Screens
		private function onAnth(event:Event, gameMode:String):void
		{
			trace("Game starts! Mode: " + gameMode);
			showScene(Anth);
		}

		private function onOwen(event:Event, gameMode:String):void
		{
			trace("Game starts! Mode: " + gameMode);
			showScene(Owen);
		}
		private function onPatr(event:Event, gameMode:String):void
		{
			trace("Game starts! Mode: " + gameMode);
			showScene(Patr);
		}
		private function onJame(event:Event, gameMode:String):void
		{
			trace("Game starts! Mode: " + gameMode);
			showScene(Jame);
		}

	}
}