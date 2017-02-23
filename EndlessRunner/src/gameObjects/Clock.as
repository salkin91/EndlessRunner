package gameObjects 
{
	import core.Entity;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.phys.BodyType;
	import starling.display.Image;
	import starling.textures.Texture;
	import nape.shape.Circle;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Clock extends Entity 
	{
		public function Clock(space:Space, position:Vec2) 
		{
			super(space, position);
			_body.type = BodyType.KINEMATIC;
			_body.userData.object = this;
			draw();
		}
		private function draw():void {
			var img:Image = new Image(Texture.fromBitmapData(Assets.clockBmapData));
			var radius:Number = (img.width + img.height) * 0.25;
			_body.shapes.add(new Circle(radius));
			addChild(img);
		}
		
	}

}