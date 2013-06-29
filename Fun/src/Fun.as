package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	
	import net.hires.debug.Stats;
	
	import screens.ROOT;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	[SWF(frameRate="60", backgroundColor="#ab1b1b")]
	public class Fun extends Sprite
	{
		public static const STAGE_WIDTH:int  = 800;
		public static const STAGE_HEIGHT:int  = 1280;
		
		
		
		[Embed(source="/resources/background.png")]
		private static const Background:Class;
		
		
		
		private var _starling:Starling;
		
		//public static var viewport:Rectangle;
		
		public function Fun()
		{
			// preparation
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			Fun.viewport = new Rectangle(0, 0, screenWidth, screenHeight)
			
			// asset manager
			var assets:AssetManager = new AssetManager();
			var appDir:File = File.applicationDirectory;
			
			assets.enqueue(appDir.resolvePath("resources"));
			
			// This doesn't work for me
			//assets.enqueue(EmbeddedAssets);
			
			// startup image 
			var background:Bitmap =  new Background();
			
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			background.smoothing = true;
			addChild(background);
			
			addChild(new Stats());
			
			// starling init
			_starling = new Starling(ROOT, stage, viewport);
			_starling.stage.stageWidth  = STAGE_WIDTH;
			_starling.stage.stageHeight = STAGE_HEIGHT;
			
			_starling.start();
			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function onRootCreated(event:Object, app:ROOT):void
				{
					_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
					var bgtex:Texture = Texture.fromBitmap(background, false, false);
					var bgimg:Image = new Image(bgtex);
					
					app.start(bgimg, assets);
					_starling.start();
					removeChild(background);
				});
		}
		private static var vp:Rectangle;
		public static function set viewport(v:Rectangle):void { vp = v; }
		public static function get viewport():Rectangle { return vp; }
	}
}