package screens
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Ruor extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Ruor()
		{
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