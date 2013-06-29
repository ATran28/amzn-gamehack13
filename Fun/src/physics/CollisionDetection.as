package physics
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	
	/**
	 * Assumes all DisplayObject objects are CENTERED.
	 */
	public class CollisionDetection
	{
		public function CollisionDetection()
		{
			super();
			
		}
		
		/**
		 * Performs hierarchical collision detection in order of complexity: Spherical, Rectangular, Point
		 * 
		 * @param obj1 First DisplayObject that is being tested. This should be the moving/more precise object. [Eg. Player, Weapon]
		 * @param obj2 Second DisplayObject that is being tested. This should be the static/less precise object. [Eg. Ground, Platform, Monster(if against Player/weapon)]
		 * @param obj1TestPoints List of points within obj1 which will be tested against obj2's bounds. [Default=null]
		 * 
		 * @return Whether or not a collsion was detected.
		 */
		public static function detectCollision(obj1:DisplayObject, obj2:DisplayObject, obj1TestPoints:Vector.<Point> = null):Boolean
		{
			if(!detectCollisionSphere(obj1, obj2)){
				return false;
			}
			
			if(!detectCollisionRect(obj1, obj2)){
				return false;
			} else {
				if(obj1TestPoints == null) {	//No points, so rectangular collision most precise
					return true;
				}
			}
			
			if(obj1TestPoints != null) {
				for each(var point:Point in obj1TestPoints) {
					if(detectCollisionPoint(obj1, obj2, point)) {
						return true;
					}
				}	
			}
			return false;
		}
		
		public static function detectCollisionSphere(obj1:DisplayObject, obj2:DisplayObject):Boolean
		{
			var p1:Point = new Point(obj1.x, obj1.y);
			var p2:Point = new Point(obj2.x, obj2.y);
			
			//Calculate distance between objects and their radius'
			var dist:Number = Point.distance(p1, p2);
			var r1:Number = obj1.width / 2;
			var r2:Number = obj2.width / 2;
			
			if(dist < r1 + r2) {
				trace("Sphere Collision detected between: " + obj1.name + ", " + obj2.name);
				return true;
			}
			
			return false;
		}
		
		/**
		 * Detect whether two DisplayObjects rectangular bounds have collide.
		 * 
		 * @param obj1 First object
		 * @param obj2 Second object
		 * @param convert If true, this tells the method to transform obj2 into obj1's coordinate space. [Default = false]
		 * 
		 * @return Whether or not a rectangular collision was detected.
		 * 
		 */
		public static function detectCollisionRect(obj1:DisplayObject, obj2:DisplayObject, convert:Boolean = false):Boolean {
			var rect1:Rectangle = obj1.bounds;
			var rect2:Rectangle;
			if(convert) {	//Convert to obj1's coordinate space
				rect2 = obj2.getBounds(obj1);
			} else {
				rect2 = obj2.bounds;	
			}
			
			if(rect1.intersects(rect2)) {
				trace("Rectangular Collsion detected between: " + obj1.name + ", " + obj2.name);
				return true;
			}
			
			return false;
		}
		
		/**
		 * Detects collsion between a point and an object.
		 * 
		 * NOTE: Does point need to be within obj2's coordinate system??????
		 * 
		 * @param obj1 DisplayObject that contains the point. NOTE: This isn't used for the collision detection.
		 * @param obj2 DisplayObject that point collision is being detected against.
		 * @param point Point within obj1 which is tested against obj2's bounds.
		 * 
		 * @return Whether or not a point collision was detected.
		 */
		public static function detectCollisionPoint(obj1:DisplayObject, obj2:DisplayObject, point:Point):Boolean {
			var rect1:Rectangle = obj2.bounds;
			
			if(rect1.containsPoint(point)) {
				//trace("Point Collsion detected between: " + obj1.name + ", " + obj2.name + ". Specifically @ " + point);
				return true;
			}
			
			return false;
		}
	}
}

