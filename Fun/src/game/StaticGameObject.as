package game
{	
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class StaticGameObject extends Sprite
	{
		private var _blocking:Boolean;
		
		private var activeImg:Image;
		private var _friction:Number;
		private var _type:String;
		private var _removeable:Boolean;

		public function StaticGameObject()
		{
			super();
			pivotX = Math.ceil(width/2);
			pivotY = Math.ceil(height/2);
			_friction = 0.87;
			
			visible = true;
		}
		
		public function setActiveImage(img:Image):void {
			if (activeImg) removeChild(activeImg);
			activeImg = img;
			addChild(activeImg);
		}
		
		public function set blocking(value:Boolean):void { _blocking = value; }
		public function get blocking():Boolean { return _blocking; }
		public function set friction(value:Number):void { _friction = value; }
		public function get friction():Number { return _friction; }
		public function set type(value:String):void { _type = value; }
		public function get type():String { return _type; }
		public function set removable(value:Boolean):void { _removeable = value; }
		public function get removable():Boolean { return _removeable; }
	}
}