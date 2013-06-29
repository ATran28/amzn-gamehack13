package game
{
	import screens.ROOT;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class GameObject extends Image
	{
		
		public function GameObject(tex:Texture)
		{
			
			super(tex);
			//pivotX = Math.ceil(width/2);
			//pivotY = Math.ceil(height/2);
			
			visible = true;
		}
	}
}