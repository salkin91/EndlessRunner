package core {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import core.Entity;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Utils 
	{
		
		public function Utils() {}
		
		public static function random(min:Number, max:Number):Number{
			return Math.random() * (max - min + 1) + min;
		}
	}
}