package gameObjects 
{
	import core.Entity;
	import core.Utils;
	import core.Config;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.shape.Circle;
	import starling.display.Image;
	import starling.textures.Texture;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Robot extends Entity 
	{
		private var _robotImg:Image = new Image(Texture.fromBitmapData(Assets.robotBmapData));
		private var _platformLeftCorner:Number = 0;
		private var _platformRightCorner:Number = 0;
		private var _radius:Number = 0;
		public function Robot(space:Space, position:Vec2, platformLeftCorner:Number, platformRightCorner:Number) 
		{
			super(space, position);
			_body.allowMovement = true;
			_platformLeftCorner = platformLeftCorner;
			_platformRightCorner = platformRightCorner;
			draw();
		}
		//Checks the bounds of a platform
		private function checkRestrictions():void {
			if (_platformLeftCorner + 50 >= _body.position.x){
				_body.velocity.x *= -1;
			}
			if (_platformRightCorner - 50 <= _body.position.x + this.width) {
				_body.velocity.x *= -1;
			}
		}
		
		private function draw():void {
			_radius = (_robotImg.width + _robotImg.height) * 0.25;
			_body.shapes.add(new Circle(_radius));
			_body.velocity.x = Utils.random(-600, 600);
			addChild(_robotImg);
		}
		
		override public function update():void {
			x = _body.position.x - _radius;
			y = _body.position.y - _radius;
			checkRestrictions();
		}
		
	}

}