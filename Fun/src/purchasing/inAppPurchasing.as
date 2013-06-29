package purchasing {
	import com.amazon.nativeextensions.android.AmazonItemData;
	import com.amazon.nativeextensions.android.AmazonPurchase;
	import com.amazon.nativeextensions.android.AmazonPurchaseReceipt;
	import com.amazon.nativeextensions.android.events.AmazonPurchaseEvent;
	
	import game.Player;
	
	import gameCircle.Achievements;
	
	public class inAppPurchasing {

		private static const CAFFEINE:String = "AGIHIAPC01";
		private static const CAFFEINE_LEVEL:Number = 5.0;
		
		private static var curPlayer:Player;
		
		// Initialize AmazonPurchase
		public static function init():void {
			if (!AmazonPurchase.isSupported()) {
				trace("Purchasing - Platform is not Android based, purchasing disabled");
				return;
			}
			
			AmazonPurchase.create();
			trace("Purchasing - Amazon Purchasing initialized");
			
			setupListeners();
		}
		
		// Setup listeners
		private static function setupListeners():void {
			// item data listeners
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.ITEM_DATA_LOADED,onDataLoaded);
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.ITEM_DATA_FAILED,onDataFailed);
			
			// item purchase listeners
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.PURCHASE_ALREADY_ENTITLED,onAlreadyEntitled);
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.PURCHASE_FAILED,onPurchaseFailed);
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.PURCHASE_SKU_INVALID,onInvalidSku);
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.PURCHASE_SUCCEEDED,onPurchaseSuccess);
			
			// purchase update listeners
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.PURCHASES_UPDATE_FAILED,onUpdateFailed);
			AmazonPurchase.amazonPurchase.addEventListener(AmazonPurchaseEvent.PURCHASES_UPDATED,onPurchasesUpdate);
		}
		
		protected static function onDataLoaded(event:AmazonPurchaseEvent):void {
			var validStr:String="";
			for each(var item:AmazonItemData in event.itemDatas) {
				validStr+=item.sku+",";
			}
			trace("Purchasing - Loaded "+event.itemDatas.length+"items,invalid=["+event.unavailableSkus.join(",")+"],valid=["+validStr+"]");
		}
		
		protected static function onDataFailed(event:AmazonPurchaseEvent):void {
			trace("Purchasing - Error loading item data.");
		}
		
		protected static function onAlreadyEntitled(event:AmazonPurchaseEvent):void {
			trace("Purchasing - already entitled to item "+event.itemSku);
		}
		
		protected static function onPurchaseFailed(event:AmazonPurchaseEvent):void {
			trace("Purchasing - failed to purchase "+event.itemSku);
		}
		
		protected static function onInvalidSku(event:AmazonPurchaseEvent):void {
			trace("Purchasing - sku was invalid- "+event.itemSku);
		}
		
		protected static function onPurchaseSuccess(event:AmazonPurchaseEvent):void {
			trace("Successful purchase of '"+event.itemSku+"'");
			
			switch(event.itemSku)
			{
				case CAFFEINE:
					// Do something to the player
					trace("PLAYER GETS CAFFEINE");
					curPlayer.caffeineLevel = CAFFEINE_LEVEL;
					Achievements.submit(Achievements.ACHIEVEMENT_01);
					break;
				case "IAP ITEM 2":
					// nothing
					break;
				default:
					// we don't do anything for unknown items.
			}
			
			// update the message on screen
			
			// display receipts
			var receiptStr:String="rct=[";
			for each(var receipt:AmazonPurchaseReceipt in event.receipts)
			{
				receiptStr+="{"+receipt.toString()+"},";
			}
			
			trace(receiptStr);
		}
		
		protected static function onUpdateFailed(event:AmazonPurchaseEvent):void {
			trace("Purchasing - failed to update.");
		}
		
		/** this event can happen at any time after initialization.
		 *  it's a good practice to update your statuses here, 
		 *	in case a purchase has been canceled or refunded etc.
		 * */
		protected static function onPurchasesUpdate(event:AmazonPurchaseEvent):void {
			for each(var receipt:AmazonPurchaseReceipt in event.receipts) {	
				if (receipt.sku==CAFFEINE) {
					// We have a receipt for Caffeine here, this might mean to set caffeine level
					trace("update caffeine status?");
				}
			}
		}
		
		public static function purchaseCaffeine(player:Player):void {
			trace("Purchasing - purchasing Caffeine for player");
			curPlayer = player;
			AmazonPurchase.amazonPurchase.purchaseItem(CAFFEINE);
		}
		
		public static function restoreTransactions():void {
			trace("Purchasing - Restoring transactions...");
			AmazonPurchase.amazonPurchase.restoreTransactions();
			trace("Purchasing - transactions restored.");
		}
	}
}