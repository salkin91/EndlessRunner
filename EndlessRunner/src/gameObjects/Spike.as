package gameObjects {
	import core.Entity;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.phys.BodyType;
	import starling.display.Image;
	import starling.textures.Texture;
	import nape.shape.Polygon;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Spike extends Entity {
		
		public function Spike(space:Space, position:Vec2) {
			super(space, position);
			_body.type = BodyType.STATIC;
			draw();
		}
		private function draw():void {
			var img:Image = new Image(Texture.fromBitmapData(Assets.spikesBmapData));
			_body.shapes.add(new Polygon(Polygon.rect(0, 0, img.width, img.height, true)));
			addChild(img);
		}
		
	}

}