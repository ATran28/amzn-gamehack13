package screens 
{
    import flash.geom.Rectangle;
    
    import gameCircle.Achievements;
    import gameCircle.GameCircleUtils;
    import gameCircle.Leaderboards;
    
    import purchasing.inAppPurchasing;
    
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class Menu extends Sprite
    {
        public static const START_GAME:String = "startGame";
        public static const ANTH:String = "startAnth";
        public static const JAME:String = "startJame";
        public static const OWEN:String = "startOwen";
        public static const PATR:String = "startPatr";
        public static const RUOR:String = "startRuor";
        public static const ToggleMusic:String = "ToggleMusic";
		
		public var musicOn:Image;
		public var musicOff:Image;
        
        public function Menu()
        {
            init();
        }
        
        private function init():void
        {
			// Initialize 
			GameCircleUtils.initializeGameCircle();
			inAppPurchasing.init();

			var viewport:Rectangle = Fun.viewport;
			var texture:Texture = ROOT.assets.getTexture("menubg");
			var background:Image = new Image( texture );
			background.x = viewport.x;
			background.y = viewport.y;
			background.width  = viewport.width;
			background.height = viewport.height;
			//background.smoothing = true;
			addChild(background);
			
            var textField:TextField = new TextField(450, 250, "Game Scaffold", 
                "Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
            textField.x = (Fun.STAGE_WIDTH - textField.width) / 2;
            textField.y = 50;
			textField.name = "menuText";
            addChild(textField);
            
			var patrickButton:Button = new Button(ROOT.assets.getTexture("orange-button"), "Patrick Start");
			patrickButton.fontSize = 24;
			patrickButton.x = int((Fun.STAGE_WIDTH - patrickButton.width) / 3);
			patrickButton.y = Fun.STAGE_HEIGHT * 0.25;
			patrickButton.addEventListener(Event.TRIGGERED, onPatrickButtonTriggered);
			addChild(patrickButton);  

//            var startButton:Button = new Button(ROOT.assets.getTexture("button"), "Start");
//            startButton.fontSize = 34;
//            startButton.x = int((Fun.STAGE_WIDTH - startButton.width) / 3 );
//            startButton.y = Fun.STAGE_HEIGHT * 0.35;
//            startButton.addEventListener(Event.TRIGGERED, onStartButtonTriggered);
//			addChild(startButton);

			
			// Buttons that switch between (Sprites) Screens

			// Show Achievements Button
			var showAchievements:Button = new Button(ROOT.assets.getTexture("orange-button"), "Show Achievements");
			showAchievements.fontSize = 24;
			showAchievements.x = int((Fun.STAGE_WIDTH - showAchievements.width) / 3);
			showAchievements.y = Fun.STAGE_HEIGHT * 0.35;
			showAchievements.addEventListener(Event.TRIGGERED, Achievements.showOverlay);
			addChild(showAchievements);  
			
			// Show Leaderboards Button
			var showLeaderboards:Button = new Button(ROOT.assets.getTexture("orange-button"), "Show Leaderboard");
			showLeaderboards.fontSize = 24;
			showLeaderboards.x = int((Fun.STAGE_WIDTH - showLeaderboards.width) / 3);
			showLeaderboards.y = Fun.STAGE_HEIGHT * 0.45;
			showLeaderboards.addEventListener(Event.TRIGGERED, showBoard);
			addChild(showLeaderboards);  

			
//			var anthonyButton:Button = new Button(ROOT.assets.getTexture("orange-button"), "Anthony");
//			anthonyButton.fontSize = 24;
//			anthonyButton.addEventListener(Event.TRIGGERED, onAnthonyButtonTriggered);
//			addChild(anthonyButton);  


//			var jamesButton:Button = new Button(ROOT.assets.getTexture("green-button"), "James");
//			jamesButton.fontSize = 24;
//			jamesButton.x = int((Fun.STAGE_WIDTH - jamesButton.width) / 5 * 3);
//			jamesButton.y = Fun.STAGE_HEIGHT * 0.5;
//			jamesButton.addEventListener(Event.TRIGGERED, onJamesButtonTriggered);
//			addChild(jamesButton);  

			var musicButton:Button = new Button(ROOT.assets.getTexture("orange-button"), "Music");
			musicButton.fontSize = 24;
			musicButton.x = int((Fun.STAGE_WIDTH - musicButton.width) / 3);
			musicButton.y = Fun.STAGE_HEIGHT * 0.55;
			musicButton.addEventListener(Event.TRIGGERED, onMusicButtonTriggered);
			addChild(musicButton);  

			musicOn = new Image(ROOT.assets.getTexture("turn_on"));
			musicOn.x = 300;
			musicOn.y = 900; 

			
			musicOff = new Image(ROOT.assets.getTexture("turn_off"));
			musicOff.x = 300;
			musicOff.y = 900;
			addChild(musicOff);

        }
        
        private function onAnthonyButtonTriggered():void
        {
			// The last parameter is just a name 
            dispatchEventWith(ANTH, true, "fun");
        }

        private function onPatrickButtonTriggered():void
        {
			// The last parameter is just a name 
            dispatchEventWith(PATR, true, "fun");
        }

        private function onJamesButtonTriggered():void
        {
			// The last parameter is just a name 
            dispatchEventWith(JAME, true, "fun");
        }

        private function onOwenButtonTriggered():void
        {
			// The last parameter is just a name 
            dispatchEventWith(OWEN, true, "fun");
        }

        private function onMusicButtonTriggered():void
        {
			if (ROOT.music) {
				ROOT.music=false;
				removeChild(musicOn);
				addChild(musicOff);
			} else {
				ROOT.music=true;
				removeChild(musicOff);
				addChild(musicOn);
			}
        }

        private function onRuoranButtonTriggered():void
        {
			// The last parameter is just a name 
            dispatchEventWith(RUOR, true, "fun");
        }

        private function onStartButtonTriggered():void
        {
			// The last parameter is just a name 
            dispatchEventWith(START_GAME, true, "fun");
        }

        private function onTestButtonTriggered():void
        {
			// The last parameter is just a name 
			(this.getChildByName("menuText") as TextField).text = "Hello";
        }

		public function showBoard():void {
			Leaderboards.showOverlay(Leaderboards.BOARD_01);
		}
    }
}