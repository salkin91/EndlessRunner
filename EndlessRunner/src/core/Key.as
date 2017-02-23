package core {
	import starling.display.Stage;
	import starling.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import starling.events.KeyboardEvent;
	import starling.events.Event;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Key{
		private static var _initialized:Boolean = false;
		private static var _keys:Object = {};
		private static var _dispather:EventDispatcher;
		
		/*
		 *	Keys that are supported 
		 */
		public static const PAUSE:uint = Keyboard.P;
		public static const EXIT:uint = Keyboard.ESCAPE;
		
		public static var _keyUp:uint = 0;
		
		
		public function Key() {}
		
		public static function init(stage:Stage):void {
			
			//Can only be initialized once
			if (!_initialized){
				_dispather = new EventDispatcher();
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
				_initialized = true;
			}
		}
		
		public static function isDown(keyCode:uint):Boolean{
			return (keyCode in _keys);
		}
		
		public static function onKeyDown(e:KeyboardEvent): void{
			_keys[e.keyCode] = true;
			_dispather.dispatchEvent(e);
			
		}
		public static function onKeyUp(e:KeyboardEvent):void{
			_keyUp = e.keyCode;
			delete _keys[e.keyCode];
		}
		public static function onDeactivate(e:Event):void{
			_keys = {};
		}		
	}

}