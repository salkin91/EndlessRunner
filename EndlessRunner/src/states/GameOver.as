package states {
	import core.Game;
	import core.State;
	import core.Config;
	import core.Key;
	import core.SoundManager;
	import flash.net.SharedObject;
	import nape.space.Space;
	import starling.events.Event;
	import starling.core.Starling;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import ui.Label;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class GameOver extends State {
		private var _score:Number = 0;
		private var _so:SharedObject = SharedObject.getLocal("highScore");
		private var _highscore:Array = [];
		private var _newHighScoreIndex:Number = 0;
		private var _onHighScore:Boolean = false;
		private const HIGHSCORE_COUNT:Number = 10;
		private var _inputName:TextField = new TextField();
		
		public function GameOver(fsm:Game, space:Space, score:Number) {
			super(fsm, space);
			_score = score;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 0.5);
			var textGameOver:Label = new Label("Game Over", 1000, 100, 84, Config.WHITE);
			textGameOver.x = Config.WORLD_CENTER_X - textGameOver.width * 0.5;
			textGameOver.y = 100;
			addChild(textGameOver);
			
			var textScore:Label = new Label("Score: " + _score, 500, 50, 32, Config.WHITE);
			textScore.x = Config.WORLD_CENTER_X - textScore.width * 0.5;
			textScore.y = textGameOver.y + textGameOver.height + 200;
			addChild(textScore);
			var format:TextFormat = new TextFormat();
			format.size = 32;
			_inputName.defaultTextFormat = format;
			_inputName.x = Config.WORLD_CENTER_X - textScore.width * 0.5;
			_inputName.y = textScore.y + textScore.height;
			_inputName.width = textScore.width;
			_inputName.height = 50;
			_inputName.type = TextFieldType.INPUT;
			_inputName.background = true;
			_inputName.backgroundColor = Config.GREY;
			_inputName.textColor = Config.WHITE;
			_inputName.border = true;
			
			var textInstruction:Label = new Label("Press ESC to continue", 1000, 300, 32, Config.WHITE);
			textInstruction.x = Config.WORLD_CENTER_X - textInstruction.width * 0.5;
			textInstruction.y = _inputName.y + _inputName.height;
			addChild(textInstruction);
			getSharedObject();
			checkIfOnHighScore();
			
			if (_onHighScore){
				Starling.current.nativeOverlay.addChild(_inputName);
			}
		}
		private function getSharedObject():void{
			if (_so.data.hasOwnProperty("highscore")){
				_highscore = _so.data.highscore;
			}else{
				initHighScoreArray();
			}
		}
		
		private function checkIfOnHighScore():void{
				var lastIndx:Number = _highscore.length - 1;
				var temp:Object;
				//if the _score is bigger than the last one on the highscore
				if (_highscore[lastIndx].value < _score){
					_highscore[lastIndx].value = _score;
					_newHighScoreIndex = lastIndx; //saves the index for  the name later
					_onHighScore = true;
				}else{
					return;
				}
				for (var i:Number = _highscore.length - 1; i >= 1; i--){	
					//If the current value is bigger then the next one swap them
					if (_highscore[i].value > _highscore[i - 1].value){
						temp = _highscore[i];
						_highscore[i] = _highscore[i - 1];
						_highscore[i - 1] = temp;
						_newHighScoreIndex = i-1;
					} else {
						break;
					}
				}
		}
		private function initHighScoreArray():void{
			for (var i:Number = 0; i < HIGHSCORE_COUNT; i++){
				_highscore[i] = {name:"", value:0};
			}
		}
		override public function destroy():void{
			_fsm = null;
			_inputName = null;
			_score = 0;
			_onHighScore = false;
			_so = null;
			_newHighScoreIndex = 0;
		}
		
		override public function update():void{
			if (Key.isDown(Key.EXIT)){
				if(_onHighScore){
					_highscore[_newHighScoreIndex].name = _inputName.text;
					_so.data.highscore = _highscore;
					_so.flush();
					Starling.current.nativeOverlay.removeChild(_inputName);
				}
				_fsm.changeState(Game.MENU_STATE);
			}
		}
	}

}