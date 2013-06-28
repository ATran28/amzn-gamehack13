package game
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class GameObject extends Sprite
	{
		var texture:Texture;
		var xpos:int;
		var ypos:int;
		var height:int;
		var width:int;
		var zindex:int;
		var visble:Boolean;
		
		public function GameObject(x:int, y:int, w:int, h:int)
		{
			super();
			xpos = x;
			ypos = y;
			width = w;
			height = h;
			zindex = 0;
			texture = null;
			
		}
		
		public function setTexture(t:Texture) {
			texture = t;
		}
	}
}