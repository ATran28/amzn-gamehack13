package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import screens.ROOT;
	
	[SWF(frameRate="60", backgroundColor="#ab1b1b")]
	public class Fun extends Sprite
	{
		public static const STAGE_WIDTH:int  = 800;
		public static const STAGE_HEIGHT:int  = 1280;
		
		[Embed(source="/resources/background.jpg")]
		private static const Background:Class;
		
		
		
		private var _starling:Starling;
		
		public function Fun()
		{
			// preparation
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			
			// asset manager
			var assets:AssetManager = new AssetManager();
			var appDir:File = File.applicationDirectory;
			
			assets.enqueue(appDir.resolvePath("image"));
			
			// This doesn't work for me
			//assets.enqueue(EmbeddedAssets);
			
			// startup image 
			var background:Bitmap =  new Background();
			
			background.x = viewPort.x;
			background.y = viewPort.y;
			background.width  = viewPort.width;
			background.height = viewPort.height;
			background.smoothing = true;
			addChild(background);
			
			// starling init
			_starling = new Starling(ROOT, stage, viewPort);
			_starling.stage.stageWidth  = STAGE_WIDTH;
			_starling.stage.stageHeight = STAGE_HEIGHT;
			
			_starling.start();
			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function onRootCreated(event:Object, app:ROOT):void
				{
					_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
					removeChild(background);
					
					var bgTexture:Texture = Texture.fromBitmap(background, false, false);
					
					app.start(bgTexture, assets);
					_starling.start();
				});
		}
	}
}