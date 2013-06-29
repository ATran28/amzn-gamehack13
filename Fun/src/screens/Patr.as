package screens
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	import game.Player;
	import game.StaticGameObject;
	
	import levels.Level;
	import levels.Level1;
	import levels.TestLevel;
	
	import physics.CollisionDetection;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Patr extends Sprite
	{
		private var GAMEOVER:Boolean = false;
		public static const GAME_OVER:String = "gameOver";
		private var level1:Level;
		public function Patr()
		{
			addEventListener(Event.ADDED_TO_STAGE, initGame);
			addEventListener(Event.ENTER_FRAME, perFrame);
			addEventListener(TouchEvent.TOUCH, isPressed);
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}
		
		private function initGame(event:Event):void {
			
			var viewport:Rectangle = Fun.viewport;
			level1 = new TestLevel();
			addChild(level1);
			
			player = new Player();
			
			// set the properties
			player.x = 0;
			player.y = 50;
			player.name = "intern1";
			player.caffeineLevel = 0;
			addChild(player);
			
		}
		
		private function perFrame(event:Event):void {
			if(GAMEOVER){
				dispatchEventWith(GAME_OVER, true, 100);
			}
			
			player.updatePosition();
			
			// Detect collisions must come after player update since overrides any
			// animation changes made in there.
			detectCollsions2(player);	
		}

		private var touchDown:Boolean = false;
		private var touchStart:Point;
		private var touchEnd:Point;
		private var player:Player;
		private function isPressed(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			
			if(touch){
				if (touch.phase == TouchPhase.BEGAN)
				{		
					touchDown = true;
					touchStart = event.getTouch(this).getLocation(this);
					player.crouch();
				} else if (touch.phase == TouchPhase.ENDED) {
					touchDown = false;
					touchEnd = event.getTouch(this).getLocation(this);
					player.stand();
					var newVelocity:Vector3D = new Vector3D(touchEnd.x - touchStart.x, touchEnd.y - touchStart.y);
					player.updateVelocity(newVelocity);
				}
			}
		}		
		
				
		private static const bounceFactor:Number = 0.1;
		private function detectCollsions2(player:Player):Boolean {

			var viewport:Rectangle = Fun.viewport;
			if(player.x > viewport.width - player.width){
				player.x = viewport.width - player.width;
				player.updateVelocity(new Vector3D(-player.getVelocity().x * bounceFactor, player.getVelocity().y));
				
			} else if(player.x < 0){
				player.x = 0;
				player.updateVelocity(new Vector3D(-player.getVelocity().x * bounceFactor, player.getVelocity().y));
			}
			
			if(player.y > viewport.height - player.height){
				player.y = viewport.height - player.height;
				player.updateVelocity(new Vector3D(player.getVelocity().x, -player.getVelocity().y * bounceFactor));
				
			} else if(player.y < 0){
				player.y = 0;
				player.updateVelocity(new Vector3D(player.getVelocity().x, -player.getVelocity().y * bounceFactor));
			}
			
			for each(var block:StaticGameObject in level1.tiles){
				if(CollisionDetection.detectCollisionRect(player, block) && block.blocking){
					trace("Ground collision");
					player.updateVelocity(new Vector3D(player.getVelocity().x, 0));
					response(player, block);
					
					
					player.y = block.y - player.height - player.caffeineLevel;
					
					if(touchDown){
						player.crouch();
					} else {
						player.stand();	
					}
					
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
