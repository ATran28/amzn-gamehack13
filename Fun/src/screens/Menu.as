package screens 
{
    import flash.geom.Rectangle;
    
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
        
        public function Menu()
        {
            init();
        }
        
        private function init():void
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
			
            var textField:TextField = new TextField(450, 250, "Game Scaffold", 
                "Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
            textField.x = (Fun.STAGE_WIDTH - textField.width) / 2;
            textField.y = 50;
			textField.name = "menuText";
            addChild(textField);
            
            var startButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Start");
            startButton.fontSize = 24;
            startButton.x = int((Fun.STAGE_WIDTH - startButton.width) / 3 );
            startButton.y = Fun.STAGE_HEIGHT * 0.25;
            startButton.addEventListener(Event.TRIGGERED, onStartButtonTriggered);
			addChild(startButton);

            var test:Button = new Button(ROOT.assets.getTexture("green-button"), "Ruoran");
            test.fontSize = 24;
            test.x = int((Fun.STAGE_WIDTH - test.width) / 3 * 2);
            test.y = Fun.STAGE_HEIGHT * 0.75;
            test.addEventListener(Event.TRIGGERED, onRuoranButtonTriggered);
            addChild(test);     
			
			
			// Buttons that switch between (Sprites) Screens
			var anthonyButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Anthony");
			anthonyButton.fontSize = 24;
			anthonyButton.x = int((Fun.STAGE_WIDTH - anthonyButton.width) / 5);
			anthonyButton.y = Fun.STAGE_HEIGHT * 0.5;
			anthonyButton.addEventListener(Event.TRIGGERED, onAnthonyButtonTriggered);
			addChild(anthonyButton);  

			var patrickButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Patrick");
			patrickButton.fontSize = 24;
			patrickButton.x = int((Fun.STAGE_WIDTH - patrickButton.width) / 5 * 2);
			patrickButton.y = Fun.STAGE_HEIGHT * 0.5;
			patrickButton.addEventListener(Event.TRIGGERED, onPatrickButtonTriggered);
			addChild(patrickButton);  

			var jamesButton:Button = new Button(ROOT.assets.getTexture("green-button"), "James");
			jamesButton.fontSize = 24;
			jamesButton.x = int((Fun.STAGE_WIDTH - jamesButton.width) / 5 * 3);
			jamesButton.y = Fun.STAGE_HEIGHT * 0.5;
			jamesButton.addEventListener(Event.TRIGGERED, onJamesButtonTriggered);
			addChild(jamesButton);  

			var owenButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Owen");
			owenButton.fontSize = 24;
			owenButton.x = int((Fun.STAGE_WIDTH - owenButton.width) / 5 * 4);
			owenButton.y = Fun.STAGE_HEIGHT * 0.5;
			owenButton.addEventListener(Event.TRIGGERED, onOwenButtonTriggered);
			addChild(owenButton);  

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
    }
}