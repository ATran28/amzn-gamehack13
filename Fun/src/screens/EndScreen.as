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
			// Do something
			var atlas:TextureAtlas = ROOT.assets.getTextureAtlas("kick_left");

			var kickLeftMovie:MovieClip = new MovieClip(atlas.getTextures("kick_left_"), 10);
			kickLeftMovie.loop = false; // default: true
			addChild(kickLeftMovie);
			
			var jump:Sound = ROOT.assets.getSound("jumpSound");

			kickLeftMovie.x = 300;
			kickLeftMovie.y = 300;
			kickLeftMovie.loop = true;
			kickLeftMovie.setFrameSound(0, jump);
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
			
			ROOT.assets.playSound("rain-03");
			
			
			
		}
		
		// back button to menu handler
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}
		
	}
}