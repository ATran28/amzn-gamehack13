package gameCircle {
	import com.amazon.nativeextensions.android.GameCircle;
	import com.amazon.nativeextensions.android.GameCirclePopupLocation;
	import com.amazon.nativeextensions.android.events.GameCircleEvent;
	
	public class Achievements {
	
		// Constants
	    public static const ACHIEVEMENT_00:String = "AGIHAID00";
		public static const ACHIEVEMENT_01:String = "AGIHAID01";
		public static const ACHIEVEMENT_02:String = "AGIHAID02";
		public static const ACHIEVEMENT_03:String = "AGIHAID03";
		public static const ACHIEVEMENT_04:String = "AGIHAID04";
		public static const ACHIEVEMENT_05:String = "AGIHAID05";
		public static const ACHIEVEMENT_06:String = "AGIHAID06";
		  
		public static const BOTTOM_CENTER:String = GameCirclePopupLocation.BOTTOM_CENTER;
		public static const BOTTOM_LEFT:String = GameCirclePopupLocation.BOTTOM_LEFT;
		public static const BOTTOM_RIGHT:String = GameCirclePopupLocation.BOTTOM_RIGHT;
		public static const TOP_CENTER:String = GameCirclePopupLocation.TOP_CENTER;
		public static const TOP_LEFT:String = GameCirclePopupLocation.TOP_LEFT;
		public static const TOP_RIGHT:String = GameCirclePopupLocation.TOP_RIGHT;

		// Set pop-up location
		public static function setPopupLocation(location:String):void {
			GameCircle.gameCircle.setPopupLocation(location); 
		}
		
		// show Acheivement overlay
		public static function showOverlay():void {
		    GameCircle.gameCircle.showAchievements();
		}
		
		// Submits a completed acheivement
		public static function submit(achievementId):void {
			GameCircle.gameCircle.submitAchievement(achievementId, 100.0);
		}
		
		public static function onAchievementSubmitted(e:GameCircleEvent):void {
			trace("GameCircle - Achievements - achievement "+e.achievementId+" was submitted!"); 
		} 
		
		public static function onAchievementFail(e:GameCircleEvent):void {
			trace("GameCircle - Achievements - achievement post failed:"+e.errorMessage); 
		}
		
		public static function reset():void {
			GameCircle.gameCircle.resetAchievements();
		}
		
		public static function onAchievementsReset(e:GameCircleEvent):void
		{ 
			trace("GameCircle - Achievements - achievements reset!"); 
		} 
		
		public static function onResetFailed(e:GameCircleEvent):void
		{ 
			trace("GameCircle - Achievements - achievement reset failed:"+e.errorMessage); 
		} 
		
		public static function checkForAchievements(levelsCompleted:int):void
		{
			switch (levelsCompleted) {
				case 20:
				    submit(ACHIEVEMENT_06);
					break;
				case 12:
					submit(ACHIEVEMENT_05);
					break;
				case 7:
					submit(ACHIEVEMENT_04);
					break;
				case 3:
					submit(ACHIEVEMENT_03);
					break;
				case 1:
					submit(ACHIEVEMENT_02);
					break;
				default:
					
			}
			
		}
	}
}