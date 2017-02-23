package states {
	import core.Game;
	import core.State;
	import core.SoundManager;
	import starling.events.Event;
	import nape.space.Space;
	import core.Game;
	import core.State;
	import core.Config;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.TouchEvent;
	import ui.CustomButton;
	import ui.Label;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Menu extends State {
		private var _heading:Label = new Label("Endless Runner", 1000, 200, 68, Config.WHITE);
		private var _startBtn:CustomButton = new CustomButton("Start");
		private var _highscoreBtn:CustomButton = new CustomButton("Highscore");
		private var _instructionsBtn:CustomButton = new CustomButton("Instructions");
		
		public function Menu(fsm:Game, space:Space) {
			super(fsm, space);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_heading.x = Config.WORLD_CENTER_X - _heading.width * 0.5;
			addChild(_heading);

			_startBtn.x = Config.WORLD_CENTER_X - _startBtn.width * 0.5;
			_startBtn.y = _heading.y + _heading.height + Config.BUTTON_GAP;
			_startBtn.addEventListener(TouchEvent.TOUCH, onStartClick);
			addChild(_startBtn);
			
			_instructionsBtn.x = Config.WORLD_CENTER_X - _instructionsBtn.width * 0.5;
			_instructionsBtn.y = _startBtn.y + _startBtn.height + Config.BUTTON_GAP;
			_instructionsBtn.addEventListener(TouchEvent.TOUCH, onInstructionClick);
			addChild(_instructionsBtn);
			
			_highscoreBtn.x = Config.WORLD_CENTER_X - _highscoreBtn.width * 0.5;
			_highscoreBtn.y = _instructionsBtn.y + _instructionsBtn.height + Config.BUTTON_GAP;
			_highscoreBtn.addEventListener(TouchEvent.TOUCH, onHighScoreClick);
			addChild(_highscoreBtn);
			
			SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 0.5);
		}
		
		private function onHighScoreClick(e:TouchEvent):void {
			var touch:Touch = e.getTouch(_highscoreBtn);
			if (touch){
				if(touch.phase == TouchPhase.BEGAN){
					_fsm.changeState(Game.HIGH_SCORE);
				}
			}
		}
		
		private function onInstructionClick(e:TouchEvent):void {
			var touch:Touch = e.getTouch(_instructionsBtn);
			if (touch){
				if(touch.phase == TouchPhase.BEGAN){
					_fsm.changeState(Game.INSTRUCTIONS);
				}
			}
		}
		
		private function onStartClick(e:TouchEvent):void {
			var touch:Touch = e.getTouch(_startBtn);
			if (touch){
				if(touch.phase == TouchPhase.BEGAN){
					_fsm.changeState(Game.PLAY_STATE);
				}
			}
		}
		override public function destroy():void{
			_heading = null;
			_startBtn.removeEventListener(TouchEvent.TOUCH, onStartClick);
			removeChild(_startBtn);
			_startBtn = null;
			_instructionsBtn.removeEventListener(TouchEvent.TOUCH, onInstructionClick);
			removeChild(_instructionsBtn);
			_instructionsBtn = null;
			_highscoreBtn.removeEventListener(TouchEvent.TOUCH, onHighScoreClick);
			removeChild(_highscoreBtn);
			_highscoreBtn = null;
		
		}
		
		override public function update():void{
			
		}
	}

}