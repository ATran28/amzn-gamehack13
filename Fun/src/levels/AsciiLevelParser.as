package levels
{
	import game.AnimatedGameObject;
	import game.StaticGameObject;
	
	import misc.DisplayHelper;

	public class AsciiLevelParser
	{
		private var _statics:Vector.<StaticGameObject>;
		public function get statics():Vector.<StaticGameObject> { return _statics; }
		private var _elevator:AnimatedGameObject;
		public function get elevator():AnimatedGameObject { return _elevator; }
		
		public function AsciiLevelParser(){
			_statics = new Vector.<StaticGameObject>();
		}
		public function parse(ascii:String):Boolean{
			
			var validated:Boolean = validate(ascii);
			if(!validated){
				return false;
			}
			
			const height:int = 39;
			const width:int = 27;
			var firstE:Boolean = true;
			
			for(var h:int = 0; h < height; h++){ 
				for(var w:int = 0; w < width; w++){
					
					var c:String = ascii.charAt(h*width + w);
					
					var actualX:int = w - 1;
					var actualY:int = height - h - 1;
					trace("c: " + c + ", x: " + actualX + ", y: " + actualY);
					
					var obj:StaticGameObject;
					if(c == "X"){
						//ignore
					} else if(c == "R"){
						obj = DisplayHelper.makeStaticBlock(actualX, actualY, "rock");
						statics.push(obj);		
					} else if(c == "G"){
						obj = DisplayHelper.makeStaticBlock(actualX, actualY, "grass");
						statics.push(obj);					
					} else if(c == "T"){
						obj = DisplayHelper.makeStaticBlock(actualX, actualY, "trunk");
						statics.push(obj);
					} else if(c == "L"){
						obj = DisplayHelper.makeStaticBlock(actualX, actualY, "leaves");
						statics.push(obj);
					} else if(c == "M"){
						obj = DisplayHelper.makeStaticBlock(actualX, actualY, "metal1");
						statics.push(obj);
					} else if(c == "B"){
						obj = DisplayHelper.makeStaticBlock(actualX, actualY, "metal2");
						statics.push(obj);		
					} else if(c == "E"){
						if(firstE){
							firstE = false;
							_elevator = DisplayHelper.makeAnimatedElevator(actualX, actualY, true);
						}
					} else if(c == " "){
						//ignore
					} else{
						trace("INVALID CHARACTER: " + c + " @(" + actualX + "," + actualY + ")");
						return false;
					}
				}
			}
			
			return true;
			
		}
		private function validate(ascii:String):Boolean{
			if(ascii.length != 39 * 27){
				return false;
			}
			
			return true;
		}
	}
}