package screens
{
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	public class Ruor extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Ruor()
		{
			// Do something
			var atlas:TextureAtlas = ROOT.assets.getTextureAtlas("kick_left");

			var kickLeftMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_"), 10);
			kickLeftMovie.loop = false; // default: true
			addChild(kickLeftMovie);
			
			// control playback
			kickLeftMovie.play();
			kickLeftMovie.pause();
			kickLeftMovie.stop();
			kickLeftMovie.x = 300;
			kickLeftMovie.y = 300;
			kickLeftMovie.loop = true;
			kickLeftMovie.play();
			
			Starling.juggler.add(kickLeftMovie);
			
			addChild(kickLeftMovie);
			
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