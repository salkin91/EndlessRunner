package core {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Time extends Sprite {
		private var _timeLeft:Number = Config.START_TIME;
		private var _myTimer:Timer = null;
		private var _isCounting:Boolean = false;
		public static const UPDATE_TIME:String = "updateTime";
		public static const NO_TIME_LEFT:String = "noTimeLeft";
		
		public function Time() {
			_myTimer = new Timer(1000);
		}
		
		public function start():void {
			_isCounting = true;
			_myTimer.start();
			_myTimer.addEventListener(TimerEvent.TIMER, onCountDown);
		}
		
		public function stop():void {
			_isCounting = false;
			_myTimer.stop();
			_myTimer.removeEventListener(TimerEvent.TIMER, onCountDown);
		}
		
		private function onCountDown(e:TimerEvent):void {
			if (_timeLeft >= 1){
				_timeLeft--;
				if (_timeLeft < 10){
					SoundManager.play(SoundManager.BEEP_SOUND);
				}
				dispatchEvent(new Event(UPDATE_TIME));
				if (_timeLeft == 0){
					stop();
					dispatchEvent(new Event(NO_TIME_LEFT));
				}
			}
		}
		
		public function get currentTime():String {
			return formatTime();
		}
		
		public function get isCounting():Boolean {
			return _isCounting;
		}
		
		public function addTime(time:Number):void {
			_timeLeft += time;
		}
		
		private function formatTime():String {
			var minutes:String = Math.floor(_timeLeft / 60).toString();
			var seconds:String = String(_timeLeft % 60);
			var timeStr:String = minutes + ":" + (parseInt(seconds) >= 10 ? "": "0") + seconds;
			return timeStr;
		}
		
		public function destroy():void {
			_timeLeft = 0;
			if (hasEventListener(TimerEvent.TIMER, onCountDown)){
				_myTimer.removeEventListener(TimerEvent.TIMER, onCountDown);
			}
			_myTimer = null;
		}
	}

}