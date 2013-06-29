package screens
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	import game.Player;
	import game.StaticGameObject;
	
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
		private var ground:Vector.<StaticGameObject> = new Vector.<StaticGameObject>(); 
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
			
			var groundTile:StaticGameObject;
			for(var w:Number = 0; w < viewport.width; w += tex.width){
				groundTile = StaticGameObject.makeTile(w, 800, new Image(tex));
				groundTile.name = "ground" + w;
				
				addChild(groundTile);
				ground.push(groundTile);
			}
			
			player = new Player();
			//var intern1:Image = new Image(internTexture);
			
			// set the properties
			player.x = 0;
			player.y = 50;
			player.name = "intern1";
			player.caffeineLevel = 50;
			addChild(player);	
			
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
			
			player.updatePosition();
			detectCollsions2(player);
		}

		private var touchStart:Point;
		private var touchEnd:Point;
		private var player:Player;
//		private var intern1:Player
//		private var intern1:Image;
//		private var velocity:Vector3D;
		private function isPressed(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			
			if(touch){
				if (touch.phase == TouchPhase.BEGAN)
				{
					trace("began");			
					touchStart = event.getTouch(this).getLocation(this);
//					addEventListener(Event.ENTER_FRAME, updatePosition);
				} else if (touch.phase == TouchPhase.ENDED) {
					trace("ended");
					touchEnd = event.getTouch(this).getLocation(this);
					var newVelocity:Vector3D = new Vector3D(touchEnd.x - touchStart.x, touchEnd.y - touchStart.y);
					player.updateVelocity(newVelocity);
					//updatePosition(event);
				}
			}
		}		
		
		
/****************************************************************************
 * Patricks Section 
 * 
 ****************************************************************************/
//		private var touchPosition2:Point;
//		private function isPressed2(event:TouchEvent):void {
//			var touch:Touch = event.getTouch(this);
//
//			if(touch){
//				if (touch.phase == TouchPhase.BEGAN)
//				{
//					touchPosition2 = event.getTouch(this).getLocation(this);
//					updatePosition2(event);
//					addEventListener(Event.ENTER_FRAME, updatePosition2);
//				} else if(touch.phase == TouchPhase.MOVED) { 
//					touchPosition2 = event.getTouch(this).getLocation(this);
//				} else if (touch.phase == TouchPhase.ENDED) {
//					removeEventListener(Event.ENTER_FRAME, updatePosition2);
//				}
//			}
//		}
//		private function updatePosition2(event:Event):void {
//			
//			//if(!hasCollided) {	
//			const speed:Number = 5;
//			
//			// Move intern 1 along vector from intern to touch event
//			var localPos:Point = touchPosition2;//event.getTouch(this).getLocation(this);
//			//trace("Touched object at position: " + localPos);
//			
//			var intern1:DisplayObject = this.getChildByName("intern1");
//			var internPos:Point = new Point(intern1.x, intern1.y);
//			//trace("Initial Intern Position: " + internPos);
//			
//			var v:Vector3D = new Vector3D(localPos.x - internPos.x, localPos.y - internPos.y);
//			v.normalize();
//			v.scaleBy(speed);
//			//trace("Vector: " + v.x + ", " + v.y);
//			//trace("New Point: " + new Point(v.x, v.y));
//			internPos = internPos.add(new Point(v.x, v.y));
//			//trace("InternPos: " + internPos);
//			intern1.x = internPos.x;
//			intern1.y = internPos.y;
//			
//			detectCollsions2(intern1);
//			//}
//			
//		}
		
		private var hasCollided:Boolean = false;
		private function detectCollsions2(player:Player):Boolean {
			/*if(CollisionDetection.detectCollisionRect(player, stretchedGround)){
				trace("Stretched collision");
				return true;
			}*/
			var viewport:Rectangle = Fun.viewport;
			if(player.x > viewport.width - player.width){
				player.x = viewport.width - player.width;
				player.updateVelocity(new Vector3D(0, player.getVelocity().y));
		
			} else if(player.x < 0){
				player.x = 0;
			}
			if(player.y > viewport.height - player.height){
				player.y = viewport.height - player.height;
				player.updateVelocity(new Vector3D(player.getVelocity().x, 0));
				
			} else if(player.y < 0){
				player.y = 0;
			}
			
			for each(var block:StaticGameObject in ground){
				if(CollisionDetection.detectCollisionRect(player, block)){
					trace("Ground collision");
					hasCollided = true;
					player.updateVelocity(new Vector3D(player.getVelocity().x, 0));
					response(player, block);
					
					
					player.y = block.y - player.height;
					return true;
				}	
			}
			return false;
		}
		private function response(player:Player, obj:StaticGameObject):void{
			
			var v:Vector3D = player.getVelocity();
			v.x *= obj.friction;
			v.y = -player.caffeineLevel;
			
			player.updateVelocity(v);
			
			
		}
	}
}


//updatePlayer
//   update velocity
//   update position