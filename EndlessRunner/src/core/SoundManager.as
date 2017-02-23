package core {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class SoundManager {
		public static const BACKGROUND_MUSIC:Number = 0;
		public static const JUMP_SOUND:Number = 1;
		public static const CLOCK_PICKUP_SOUND:Number = 2;
		public static const BEEP_SOUND:Number = 3;
		
		private static var _backgroundMusic:SimpleSound = new SimpleSound();
		private static var _jumpSound:SimpleSound = new SimpleSound();
		private static var _clockSound:SimpleSound = new SimpleSound();
		private static var _beepSound:SimpleSound = new SimpleSound();

		public static function load():void{
				_backgroundMusic = new SimpleSound(Assets.BACKGROUND_MUSIC, true);
				_backgroundMusic.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_jumpSound = new SimpleSound(Assets.JUMP_SOUND);
				_jumpSound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_clockSound = new SimpleSound(Assets.PICKUP_CLOCK_SOUND);
				_clockSound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_beepSound = new SimpleSound(Assets.END_BEEP);
				_beepSound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		public static function play(sound:Number):void{
			switch(sound){
				case 0:
					if(!_backgroundMusic.isPlaying){
						_backgroundMusic.play();
					}
					break;
				case 1:
					_jumpSound.play();
					break;
				case 2:
					_clockSound.play();
					break;
				case 3:
					_beepSound.play();
					break;
			}
		}
		public static function pause(sound:Number):void{
			switch(sound){
				case 0:
					if(_backgroundMusic.isPlaying){
						_backgroundMusic.pause();
					}
					break;
				case 1:
					break;
			}
		}
		public static function resume(sound:Number):void{
			switch(sound){
				case 0:
					if(!_backgroundMusic.isPlaying){
						_backgroundMusic.resume();
					}
					break;
				case 1:
					break;
			}
		}
		public static function stop(sound:Number):void{
			switch(sound){
				case 0:
					if(_backgroundMusic.isPlaying){
						_backgroundMusic.stop();
					}
					break;
				case 1:
					break;
			}
		}
		public static function setVolume(sound:Number, volume:Number):void{
			switch(sound){
				case 0:
					_backgroundMusic.setVolume(volume);
					break;
				case 1:
					break;
			}
		}
		
		private static function ioErrorHandler(e:IOErrorEvent):void{
			
		}
	}

}