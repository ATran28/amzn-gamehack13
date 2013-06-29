package screens
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import game.Player;
	import game.StaticGameObject;
	
	import levels.AsciiLevels;
	import levels.GeneratedLevel;
	import levels.Level;
	import levels.Level1;
	import levels.Level2;
	import levels.LevelQueue;
	import levels.TestLevel;
	
	import physics.CollisionDetection;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import util.Util;
	
	public class Patr extends Sprite
	{
		private var GAMEOVER:Boolean = false;
		public static const GAME_OVER:String = "gameOver";
		
		private var levelQueue:LevelQueue;
		private var currentLevel:Level;
		
		public function Patr()
		{
			addEventListener(Event.ADDED_TO_STAGE, initGame);
			addEventListener(Event.ENTER_FRAME, perFrame);
			addEventListener(TouchEvent.TOUCH, isPressed);
			levelQueue = new LevelQueue();
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}
		
		private function initGame(event:Event):void {
			
			initState();
		}
		
		private function initState():void {
			player = new Player();
			currentLevel = levelQueue.getNextLevel(player);
			addChild(currentLevel);
			
			// set the properties
			player.x = currentLevel.startPosition.x;
			player.y = currentLevel.startPosition.y;
			
			player.name = "intern1";
			player.caffeineLevel = 0;
			addChild(player);
			touchEnabled = true;
		}
		
		private var flag:Boolean = false;
		private function perFrame(event:Event):void {
			if(GAMEOVER){
				dispatchEventWith(GAME_OVER, true, 100);
			}
			
			// Check for 'notable' tiles
			for (var tile:StaticGameObject in currentLevel.notableTiles) {
				if (CollisionDetection.detectCollisionRect(player, tile)) {
					if (tile.removable) {
						 tile.visible = false;
					}
					currentLevel.levelStatus["tilesToFind"] -= 1;
				}
			}
			
			if (currentLevel.isFinished() && CollisionDetection.detectCollisionRect(player, currentLevel.exitElevator) 
					&& flag == false) {
				player.x = currentLevel.exitElevator.x + currentLevel.exitElevator.width/4;
				player.y = currentLevel.exitElevator.y + (currentLevel.exitElevator.height - player.height);
				player.updateVelocity(new Vector3D());
				currentLevel.exitElevator.setActiveMovie("open");
				currentLevel.exitElevator.animate();
				touchEnabled = false;
				flag = true;				
			} else if (currentLevel.isFinished() && flag == true) {
				if (currentLevel.exitElevator.getActiveMovie().isComplete) {
					flag = false;
					removeChild(currentLevel);
					removeChild(player);
					initState();
				}
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
		
//		private var intern1:Player
//		private var intern1:Image;
//		private var velocity:Vector3D;
		private var touchEnabled:Boolean = true;
		
		private function isPressed(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			
			if(touch && touchEnabled){
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

			//Check collisions with viewport 
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
			
			//Check tile collisions
			for each(var block:StaticGameObject in currentLevel.tiles){
				if(CollisionDetection.detectCollisionRect(player, block) && block.blocking){
					trace("Ground collision");	
					if (player.inTheAir) {
						player.inTheAir = false;
						ROOT.assets.playSound(Util.getRandomHitGroundSound());
					}
					response(player, block);	//Updates velocity/forces, then responds
					
					return true;
				}	
			}
			return false;
		}

		private function response(player:Player, obj:StaticGameObject):void{
			
			if(player.y < obj.y){
				player.updateVelocity(new Vector3D(player.getVelocity().x, 0));
				
				var v:Vector3D = player.getVelocity();
				v.x *= obj.friction;
				v.y = -player.caffeineLevel;
				
				player.updateVelocity(v);
				
				player.y = obj.y - player.height - player.caffeineLevel;
				
				if(touchDown){
					player.crouch();
				} else {
					player.stand();	
				}
			} else {
				player.updateVelocity(new Vector3D(player.getVelocity().x, -player.getVelocity().y));
			}
		}
	}
}
