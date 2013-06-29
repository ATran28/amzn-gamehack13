package screens
{
	import game.Player;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import game.StaticGameObject;


	public class Game extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, initIntern);
			addEventListener(Event.ENTER_FRAME, perFrame);
		}

		private function initIntern(event:Event):void {
			//var texture:Texture = ROOT.assets.getTexture("intern");
			//var intern:Image = new Image(texture);
			
			var intern:Player = new Player();
	
			// set the properties
			intern.x = 0;
			intern.y = 50;
			// intern scale is set in Player

			intern.name = "intern";
			addChild(intern);	
			
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
			var intern:DisplayObject = this.getChildByName("intern");
			if (intern.x + intern.width <= stage.stageWidth ) {
				intern.x += 1.5;
			} else {
				dispatchEventWith(GAME_OVER, true, 100);
			}
		}
	}
}