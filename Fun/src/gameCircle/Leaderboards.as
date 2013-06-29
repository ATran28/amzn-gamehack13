package gameCircle {
	import com.amazon.nativeextensions.android.GameCircle;
	import com.amazon.nativeextensions.android.events.GameCircleEvent;
	
	public class Leaderboards {
		
		public static const BOARD_01:String = "AGIHMPCL";
		
		// show Leaderboard overlay
		public static function showOverlay(leaderboardId):void {
			GameCircle.gameCircle.showLeaderboard(leaderboardId);
		}
		
		// Submits a completed acheivement
		public static function submitScore(leaderboardId, score):void {
			GameCircle.gameCircle.submitScore(leaderboardId, score);
		}
		
		public static function onScoreSubmitted(e:GameCircleEvent):void
		{ 
			trace("GameCircle - Leaderboards - score of "+e.score+" was submitted!"); 
		} 
		
		public static function onScoreFailed(e:GameCircleEvent):void
		{ 
			trace("GameCircle - Leaderboards - score post failed:"+e.errorMessage); 
		}
		
	}
}