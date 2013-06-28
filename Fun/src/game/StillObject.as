package game
{
	import starling.events.Event;
	import starling.textures.Texture;

	public class StillObject extends GameObject
	{
		private var texture:Texture;
		public function StillObject(x:int, y:int, w:int, h:int)
		{
			super(x, y, w, h);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}		
		
	}
}