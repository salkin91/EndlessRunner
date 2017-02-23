package core {
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.space.Space;
	import nape.shape.*;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Entity extends Sprite {
		
		public var _isAlive:Boolean = true;
		protected var _body:Body = null;
		protected var _img:Image = null;
		protected var _space:Space = null;
		
		public function set body(b:Body):void {_body = b; }
		public function get body():Body {return _body; }
		public function set space(s:Space):void {_space = s; if (body){_body.space = _space; }}
		public function set allowMovement(b:Boolean):void {_body.allowMovement = b; }
		public function get allowMovement():Boolean {return _body.allowMovement; }
		public function set velocity(v:Vec2):void {_body.velocity = v; }
		public function get velocity():Vec2 {return _body.velocity; }
		public function set angularVel(n:Number):void {_body.angularVel = n; }
		public function get angularVel():Number {return _body.angularVel; }
		public function set position(v:Vec2):void {_body.position = v; x = _body.position.x; y = _body.position.y }
		protected var _color:uint = core.Config.RED;
		
		
		public function Entity(space:Space, position:Vec2) {
			super();
			_space = space;
			_body = new Body(BodyType.DYNAMIC, position);
			x = _body.position.x;
			y = _body.position.y;
			_body.allowMovement = true;
		}
		
		public function update():void {
		
		}
		
		public function destroy():void{
			
		}
		
	}

}