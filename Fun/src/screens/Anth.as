package screens
{
	import game.Player;
	
	import gameCircle.Achievements;
	import gameCircle.GameCircleUtils;
	import gameCircle.Leaderboards;
	
	import purchasing.inAppPurchasing;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Anth extends Sprite
	{
		public static const GAME_OVER:String = "gameOver";

		public function Anth()
		{
			// Initialize
			GameCircleUtils.initializeGameCircle();
			inAppPurchasing.init();
			
			// Show Achievements Button
			var showAchievements:Button = new Button(ROOT.assets.getTexture("green-button"), "Show Achievements");
			showAchievements.fontSize = 24;
			showAchievements.x = 100;
			showAchievements.y = 350; 
			showAchievements.addEventListener(Event.TRIGGERED, Achievements.showOverlay);
			addChild(showAchievements);  
			
			// Submit achievement Button
			var submitAchievement:Button = new Button(ROOT.assets.getTexture("green-button"), "Get Achievement");
			submitAchievement.fontSize = 24;
			submitAchievement.x = 250;
			submitAchievement.y = 350; 
			submitAchievement.addEventListener(Event.TRIGGERED, submitAch);
			addChild(submitAchievement); 
			
			// Reset achievement Button
			var resetAchievement:Button = new Button(ROOT.assets.getTexture("green-button"), "Reset Achievements");
			resetAchievement.fontSize = 24;
			resetAchievement.x = 400;
			resetAchievement.y = 350; 
			resetAchievement.addEventListener(Event.TRIGGERED, Achievements.reset);
			addChild(resetAchievement); 
			
			// Show Leaderboards Button
			var showLeaderboards:Button = new Button(ROOT.assets.getTexture("green-button"), "Show Leaderboard");
			showLeaderboards.fontSize = 24;
			showLeaderboards.x = 100;
			showLeaderboards.y = 250; 
			showLeaderboards.addEventListener(Event.TRIGGERED, showBoard);
			addChild(showLeaderboards);  
			
			// Submit score to leaderboard Button
			var submitScore:Button = new Button(ROOT.assets.getTexture("green-button"), "Submit score to leaderboard");
			submitScore.fontSize = 24;
			submitScore.x = 250;
			submitScore.y = 250; 
			submitScore.addEventListener(Event.TRIGGERED, submitScoreToBoard);
			addChild(submitScore); 
			
			// Back button to menu
			var backButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Back");
			backButton.fontSize = 24;
			backButton.x = 0;
			backButton.y = 0; 
			backButton.addEventListener(Event.TRIGGERED, backToMenu);
			addChild(backButton);  
			
			// Buy IAP
			var iapButton:Button = new Button(ROOT.assets.getTexture("green-button"), "Buy Caffeine");
			iapButton.fontSize = 24;
			iapButton.x = 250;
			iapButton.y = 450; 
			iapButton.addEventListener(Event.TRIGGERED, buyCaffeine);
			addChild(iapButton);  
		}
		
		// back button to menu handler
		public function backToMenu():void {
			dispatchEventWith(GAME_OVER, true, 100);
		}
		
		public function submitAch():void {
			Achievements.submit("AGIHAID00");
		}
		
		public function showBoard():void {
			Leaderboards.showOverlay(Leaderboards.BOARD_01);
		}
		
		private var lastScore:int = 1000;
		public function submitScoreToBoard():void {
			lastScore = lastScore + 1;
			Leaderboards.submitScore(Leaderboards.BOARD_01, lastScore);
		}
		
		public function buyCaffeine():void {
			inAppPurchasing.purchaseCaffeine(new Player());
		}
		
	}
}