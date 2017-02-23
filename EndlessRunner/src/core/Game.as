package core 
{
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.core.Starling;
	import states.*;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Game extends Sprite 
	{
		private var _currentPlayState:Play = null; //saves the state of the game if it paused
		public static const PLAY_STATE:Number = 0;
		public static const PAUSE_STATE:Number = 1;
		public static const MENU_STATE:Number = 2;
		public static const GAME_OVER:Number = 3;
		public static const HIGH_SCORE:Number = 4;
		public static const INSTRUCTIONS:Number = 5; 
		
		private var _isPaused:Boolean = false;
		
		public static var assets:Assets = new Assets();
		
		private var _currentState:State = null;
		private var _space:Space = null;
		private var _debug:BitmapDebug = null;
		
		public function Game() {
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function changeState(newState:Number):void{
			switch (newState) {
				case PLAY_STATE:
					clearCurrentState();
					if (_currentPlayState == null){
						clearCurrentState();
						_currentState = new Play(this, _space);
					}else {
						_currentState = _currentPlayState;
						_currentPlayState = null;
					}
					break;
				case PAUSE_STATE:
					_currentPlayState = _currentState as Play;
					removeChild(_currentPlayState);
					_currentState = new PauseState(this, _space);
					break;
				case MENU_STATE:
					clearCurrentState();
					_currentState = new Menu(this, _space);
					break;
				case GAME_OVER:
					_currentPlayState = _currentState as Play;
					var playerScore:Number = _currentPlayState.score;
					clearCurrentState();
					_currentPlayState = null;
					_currentState = new GameOver(this, _space, playerScore);
					break;
				case HIGH_SCORE:
					clearCurrentState();
					_currentState = new HighScore(this, _space);
					break;
				case INSTRUCTIONS:
					clearCurrentState();
					_currentState = new Instructions(this, _space);
					break;
			}
			addChild(_currentState);
		}
		
		private function clearCurrentState():void {
			if (_currentState != null){
				_currentState.destroy();
				removeChild(_currentState as Sprite);
				_currentState = null;
			}
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_space = new Space(Config.GRAVITY);
			_debug = new BitmapDebug(stage.stageWidth, stage.stageHeight, stage.color, true);
			Starling.current.nativeOverlay.addChild(_debug.display);
			Key.init(stage);
			addEventListener(Event.ENTER_FRAME, update);
			changeState(MENU_STATE);
			SoundManager.play(SoundManager.BACKGROUND_MUSIC);
			SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 0.5);
		}
		
		private function update(e:EnterFrameEvent):void {	
			if (!isPaused){
				_space.step(e.passedTime);
				_debug.clear();
				_debug.draw(_space);
				_debug.flush();
			}
			_currentState.update();
			if (Key._keyUp == Key.PAUSE){
				if (isPaused){
					isPaused = false;
				}else {
					if(_currentState is Play){
						isPaused = true;
					}
				}
				Key._keyUp = 0;
			}
		}
		
		public function get isPaused():Boolean 
		{
			return _isPaused;
		}
		
		public function set isPaused(value:Boolean):void 
		{
			_isPaused = value;
		}
		
		
	}

}