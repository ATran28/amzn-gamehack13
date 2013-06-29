package game
{
	import starling.events.Event;

	public class Collectible extends StaticGameObject
	{
		
		public function Collectible()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}		
		
		
		
	}
}