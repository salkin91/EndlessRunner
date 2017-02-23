package gameObjects {
	import core.Entity;
	import core.Config;
	import core.Key;
	import starling.display.Sprite;
	import nape.shape.Circle;
	import nape.space.Space;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.textures.Texture;
	import flash.display.BitmapData;
	import core.SoundManager;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Runner extends Entity {
		private var _hasJumped:Boolean = false;
		private var _walkImg1:Image = new Image(Texture.fromBitmapData(Assets.playerWalk1BmapData));
		private var _walkImg2:Image = new Image(Texture.fromBitmapData(Assets.playerWalk2BmapData));
		private var _jumpImg:Image = new Image(Texture.fromBitmapData(Assets.playerJumpBmapData));
		private var _currentImg:Image = null;
		private var _numToSwitchImg:Number = 0;
		private var _radius:Number = 0;
		private var _jumpTime:Number = Config.JUMP_TIME;
		private var _hasJumpSoundPlayed:Boolean = false;
		private var _increaseSpeed:Number = 0;
		public function Runner(space:Space, position:Vec2) {
			super(space, position);
			_currentImg = _walkImg1;
			draw();
		}
		private function draw():void {
			_radius = (_currentImg.width + _currentImg.height) * 0.25;
			_body.shapes.add(new Circle(_radius));
			addChild(_currentImg);
		}
		//This function is made so that it is possible to jump higher if the mouse btn is hold down
		public function jump():void {
			if(!_hasJumped){
				var impulse:Vec2 = Vec2.get(0, -90);
				_body.applyImpulse(impulse);
				impulse.dispose();
				_jumpTime--;
				if(_jumpTime <= 0){
					_hasJumped = true;
					_jumpTime = Config.JUMP_TIME;
				}
				if (!_hasJumpSoundPlayed){
					SoundManager.play(SoundManager.JUMP_SOUND);
					_hasJumpSoundPlayed = true;
				}
			}
		}
		override public function update():void {
			x = _body.position.x - _radius;
			y = _body.position.y - _radius;
			//Switching between images
			if (!_hasJumped){
				removeChild(_currentImg);
				if (_numToSwitchImg > Config.RUNNER_IMG_SWITCH){
					if (_currentImg == _walkImg1){
						_currentImg = _walkImg2;
					}else{
						_currentImg = _walkImg1;
					}
					_numToSwitchImg = 0;
				}else{
					_numToSwitchImg++;
				}
				addChild(_currentImg);
			}
			else {
				removeChild(_currentImg);
				_currentImg = _jumpImg;
				addChild(_currentImg);
			}
		}
		
		override public function destroy():void {
			_hasJumped = false;
			_walkImg1 = null;
			_walkImg2 = null;
			_jumpImg = null;
			removeChild(_currentImg);
			_currentImg = null;
			_jumpTime = 0;
			_numToSwitchImg = 0;
			_body.space = null;
		}
		
		public function hasLanded():void {
			_hasJumped = false;
			_hasJumpSoundPlayed = false;
			_body.velocity.x = Config.RUNNER_SPEED + _increaseSpeed;
			_increaseSpeed += Config.RUNNER_SPEED_GAIN;
			_jumpTime = Config.JUMP_TIME;
			removeChild(_currentImg);
			_currentImg = _walkImg1;
			addChild(_currentImg);
		}
		
		public function get hasJumped():Boolean {
			return _hasJumped;
		}
		
		public function set hasJumped(value:Boolean):void {
			_hasJumped = value;
		}
	}

}