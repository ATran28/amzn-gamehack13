package screens
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Anth extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Anth()
		{
			// Do something
			
			
			
			// Back button to menu
			var backButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Back");
			backButton.fontSize = 24;
			backButton.x = 0;
			backButton.y = 0; 
			backButton.addEventListener(Event.TRIGGERED, backToMenu);
			addChild(backButton);  
		}
		
		// back button to menu handler
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}
		
	}
}