package screens
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class Jame extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";
		
		public function init():void
		{
			var viewport:Rectangle = Fun.viewport;
			var texture:Texture = ROOT.assets.getTexture("menubg");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			//background.smoothing = true;
			addChild(background);
			
			trace("Started:James");
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			var viewport:Rectangle = Fun.viewport;
			var texture:Texture = ROOT.assets.getTexture("menubg");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			//background.smoothing = true;
			addChild(background);
			
			// Back button to menu
			var backButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Back");
			backButton.fontSize = 24;
			backButton.x = 0;
			backButton.y = 0; 
			backButton.addEventListener(Event.TRIGGERED, backToMenu);
			addChild(backButton); 
		}

		public function Jame()
		{
			// Do something
			
			init();
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
				trace("Touched object at position: " + localPos);
			}
		}
		
		private function onRelease(event:TouchEvent):void
		{
			
		}
		
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}

	}
}