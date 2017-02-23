package core {
	import starling.display.DisplayObject;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Camera {
		private var _viewPort:Rectangle = new Rectangle(0, 0, Config.WORLD_WIDTH, Config.WORLD_HEIGHT);
		private var _offsetX:Number;
		private var _offsetY:Number;
		private var _target:Entity;
		private var _gameWorld:DisplayObject;
		private var _gui:DisplayObject;
		
		public function Camera(target:Entity, gameWorld:DisplayObject, gui:DisplayObject) {
			_offsetX = _viewPort.width * 0.15;
			_offsetY = _viewPort.height * 0.5;
			_target = target;
			_gameWorld = gameWorld;
			_gui = gui;
		}
		
		public function update():void {
			_viewPort.x = _target.x - _offsetX;
			_viewPort.y = _target.y - _offsetY;
			
			_gui.x = _viewPort.x;
			_gui.y = _viewPort.y;
			
			_gameWorld.x = -_viewPort.x;
			_gameWorld.y = -_viewPort.y;
		}
		
	}

}