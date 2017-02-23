package gameObjects {
	import core.Entity;
	import core.Utils;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.shape.Polygon;
	import nape.phys.BodyType;
	import starling.textures.Texture;
	import starling.display.Image;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Ground extends Entity {
		public var _groundWidth:Number = Utils.random(600, 1200);
		public var _groundHeight:Number = 50;
		private var _groundVectorRectangle:Vector.<Vec2>;
		private var _groundTexture:Texture = null;
		private var _image:Image = null;
		
		public function Ground(space:Space, position:Vec2) {
			super(space, position);
			_body.type = BodyType.STATIC;
			draw();
		}
		
		private function draw():void {
			//Generate a rectangle made of Vec2
			_groundVectorRectangle = new Vector.<Vec2>();
			_groundVectorRectangle.push(new Vec2(0, _groundHeight));
			_groundVectorRectangle.push(new Vec2(0, 0));
			_groundVectorRectangle.push(new Vec2(_groundWidth, 0));
			_groundVectorRectangle.push(new Vec2(_groundWidth, _groundHeight));
			
			_groundTexture = Texture.fromBitmapData(new BitmapData(_groundWidth, _groundHeight, false, 0xffaa33));
			
			var polygon:Polygon = new Polygon(_groundVectorRectangle);
			_body.shapes.add(polygon);
			_image = new Image(_groundTexture);
			addChild(_image); 
		}
		
		override public function destroy():void {
			_groundHeight = 0;
			_groundWidth = 0;
			_groundVectorRectangle = new Vector.<Vec2>;
			_groundTexture = null;
			_body.space = null;
			removeChild(_image);
		}
		
	}

}