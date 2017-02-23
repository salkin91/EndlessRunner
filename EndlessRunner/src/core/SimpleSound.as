package core{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class SimpleSound extends Sound {
		private var _channel:SoundChannel = new SoundChannel;
		private var _trans:SoundTransform = new SoundTransform;
		private var _position:Number = 0;
		private var _loop:Boolean = false;
		private static var _isPlaying:Boolean = false;
		public function SimpleSound(stream:URLRequest=null, loop:Boolean=false) {
			super(stream);
			_loop = loop;
		}
		public function stop():void{
			_isPlaying = false;
			try{
				_channel.stop();
				if(_loop){
					_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				}
			}
			catch (e:Error){
				
			}
		}
		override public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel{
			_isPlaying = true;
			try {
				_channel = super.play(startTime, loops, sndTransform);
				_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
			}
			catch (e:Error){
				
			}
			return _channel;
		}
		
		private function onSoundComplete(e:Event):void {
			_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			if(_loop){
				this.play();
			}
		}
		
		public function pause():void{
			_position = _channel.position;
			try{
				this.stop();
			}
			catch (e:Error){
				
			}
		}
		public function resume(times:Number=0):void{
			this.play(_position, times, _trans);
		}
		public function setVolume(num:Number):void{
			_trans.volume = num;
			makeChanges();
		}
		public function setPan(num:Number):void{
			_trans.pan = num;
			makeChanges();
		}
		public function makeChanges():void{
			_channel.soundTransform = _trans;
		}
		public function set channel(value:SoundChannel):void {
			_channel = value;
		}
		
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		public function set isPlaying(value:Boolean):void {
			_isPlaying = value;
		}
		
		public function get channel():SoundChannel {
			return _channel;
		}
		
	}

}