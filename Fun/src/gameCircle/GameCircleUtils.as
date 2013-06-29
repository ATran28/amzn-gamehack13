package gameCircle {
	import com.amazon.nativeextensions.android.GameCircle;
	import com.amazon.nativeextensions.android.GameCircleFeature;
	import com.amazon.nativeextensions.android.events.GameCircleEvent;

	public class GameCircleUtils {
		
		private static var isEnabled:Boolean = false;
		
		// Initializes GameCircle for Achievements and Leaderboard features
		public static function initializeGameCircle():void {
			//if (GameCircle.isSupported()) {
				trace("GameCircle - Creating instance");
				GameCircle.create([GameCircleFeature.ACHIEVEMENTS,GameCircleFeature.LEADERBOARDS]);
				
				setEventListeners();
			/*} else {
				trace("GameCircle - GameCircle not supported, disabling GameCircle features");
				isEnabled = false;
				return;
			} */
		}
		
		private static function setEventListeners():void
		{
			// GameCircle service listeners
			GameCircle.gameCircle.addEventListener(GameCircleEvent.SERVICE_READY, onServiceReady);
			GameCircle.gameCircle.addEventListener(GameCircleEvent.SERVICE_NOT_READY, onServiceNotReady); 
			
			// Achievement listeners
			GameCircle.gameCircle.addEventListener(GameCircleEvent.ACHIEVEMENT_SUBMITTED, Achievements.onAchievementSubmitted); 
			GameCircle.gameCircle.addEventListener(GameCircleEvent.SUBMIT_ACHIEVEMENT_FAILED, Achievements.onAchievementFail);
			GameCircle.gameCircle.addEventListener(GameCircleEvent.ACHIEVEMENTS_RESET,Achievements.onAchievementsReset); 
			GameCircle.gameCircle.addEventListener(GameCircleEvent.ACHIEVEMENTS_RESET_FAILED,Achievements.onResetFailed);
			
			// LEaderboard listeners
			GameCircle.gameCircle.addEventListener(GameCircleEvent.SCORE_SUBMITTED,Leaderboards.onScoreSubmitted);
			GameCircle.gameCircle.addEventListener(GameCircleEvent.SUBMIT_SCORE_FAILED,Leaderboards.onScoreFailed);
		}
		
		protected static function onServiceReady(e:GameCircleEvent):void
		{
			trace("GameCircle - service ready - you can now call other GameCircle functions.");
			isEnabled = true;
		}
		
		protected static function onServiceNotReady(e:GameCircleEvent):void
		{
			trace("GameCircle - there was an error initializing GameCircle:"+e.errorMessage);
			// something went wrong - you can't use the GameCircle service right now.
			isEnabled = false;
		} 
	}
}

