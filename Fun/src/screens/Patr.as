package screens
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	import physics.CollisionDetection;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Patr extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";
		
		public function Patr()
		{
			addEventListener(Event.ADDED_TO_STAGE, initGame);
			addEventListener(Event.ENTER_FRAME, perFrame);
			addEventListener(TouchEvent.TOUCH, isPressed);
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}
		
		private var stretchedGround:Image;
		private var ground:Vector.<Image> = new Vector.<Image>(); 
		private function initGame(event:Event):void {
			var viewport:Rectangle = Fun.viewport;
			var texture:Texture = ROOT.assets.getTexture("menubg");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			//background.smoothing = true;
			addChild(background);
			
			var groundAtlas:TextureAtlas = ROOT.assets.getTextureAtlas("FunGameSprites");
			
			var tex:Texture = groundAtlas.getTexture("grass32");
			stretchedGround = new Image(tex);
			stretchedGround.x = 0;
			stretchedGround.y = 400;
			stretchedGround.width = viewport.width;
			addChild(stretchedGround);
			stretchedGround.name = "stretchedGround";
			
			var groundImg:Image;
			for(var w:Number = 0; w < viewport.width; w += tex.width){
				groundImg = new Image(tex);
				groundImg.x = w;
				groundImg.y = 800;
				groundImg.name = "ground" + w;
				addChild(groundImg);
				ground.push(groundImg);
			}
			
			var internTexture:Texture = ROOT.assets.getTexture("intern");
			var intern1:Image = new Image(internTexture);
			
			// set the properties
			intern1.x = 0;
			intern1.y = 50;
			intern1.width = 46;
			intern1.height = 69;
			intern1.name = "intern1";
			addChild(intern1);	
			
			addChild(ROOT.fire);
			
			Starling.juggler.add(ROOT.fire);
			
			// change position where particles are emitted
			ROOT.fire.x = 50;
			ROOT.fire.y = 50;
			ROOT.fire.emitterX = 20;
			ROOT.fire.emitterY = 40;
			
			// emit particles for two seconds, then stop
			ROOT.fire.start(2.0);
		}
		
		private function perFrame(event:Event):void {
//			var intern:DisplayObject = this.getChildByName("intern1");
//			if (intern.x + intern.width <= stage.stageWidth ) {
//				intern.x += 0.5;
//			} else {
//				dispatchEventWith(GAME_OVER, true, 100);
//			}
		}
		
		private var touchPosition:Point;
		private function isPressed(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			
			if(touch){
				if (touch.phase == TouchPhase.BEGAN)
				{
					touchPosition = event.getTouch(this).getLocation(this);
					addEventListener(Event.ENTER_FRAME, updatePosition);
				} else if(touch.phase == TouchPhase.MOVED) { 
					touchPosition = event.getTouch(this).getLocation(this);
				} else if (touch.phase == TouchPhase.ENDED) {
					removeEventListener(Event.ENTER_FRAME, updatePosition);
				}
			}
		}
		private function updatePosition(event:Event):void {
			
			
			const speed:Number = 5;
			
			// Move intern 1 along vector from intern to touch event
			var localPos:Point = touchPosition;//event.getTouch(this).getLocation(this);
			//trace("Touched object at position: " + localPos);
			
			var intern1:DisplayObject = this.getChildByName("intern1");
			var internPos:Point = new Point(intern1.x, intern1.y);
			//trace("Initial Intern Position: " + internPos);
			
			var v:Vector3D = new Vector3D(localPos.x - internPos.x, localPos.y - internPos.y);
			v.normalize();
			v.scaleBy(speed);
			//trace("Vector: " + v.x + ", " + v.y);
			//trace("New Point: " + new Point(v.x, v.y));
			internPos = internPos.add(new Point(v.x, v.y));
			//trace("InternPos: " + internPos);
			intern1.x = internPos.x;
			intern1.y = internPos.y;
			
			detectCollsions(intern1);
			
		}
		
		private function detectCollsions(player:DisplayObject):Boolean {
			if(CollisionDetection.detectCollisionRect(player, stretchedGround)){
				trace("Stretched collision");
				return true;
			}
			for each(var block:Image in ground){
				if(CollisionDetection.detectCollision(player, block)){
					trace("Ground collision");
					return true;
				}	
			}
			return false;
		}
	}
}