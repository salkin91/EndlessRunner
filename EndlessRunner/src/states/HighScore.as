package states {
	import core.Game;
	import core.State;
	import core.Config;
	import ui.CustomButton;
	import flash.net.SharedObject;
	import nape.space.Space;
	import ui.Label;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class HighScore extends State {
		private var _heading:Label = new Label("HighScore!",1000, 100, 80,Config.WHITE);
		private var _so:SharedObject = SharedObject.getLocal("highScore");
		private var _highscoreArray:Array = [];
		private var _backBtn:CustomButton = new CustomButton("Back");
		
		public function HighScore(fsm:Game, space:Space) {
			super(fsm, space);
			_heading.x = Config.WORLD_CENTER_X - _heading.width * 0.5;
			_heading.y = 100;
			addChild(_heading);
			getSharedObject();
			buildString();
			var highscoreLabel:Label = new Label(highscoreList, 1000, 400, 32, Config.WHITE);
			addChild(highscoreLabel);
			highscoreLabel.x = _heading.x;
			highscoreLabel.y = _heading.y + _heading.height;
			_backBtn.x = Config.WORLD_CENTER_X - _backBtn.width * 0.5;
			_backBtn.y = highscoreLabel.y + highscoreLabel.height;
			_backBtn.addEventListener(TouchEvent.TOUCH, onBackClick);
			addChild(_backBtn);
			
		}
		
		private function onBackClick(e:TouchEvent):void {
			var touch:Touch = e.getTouch(_backBtn);
			if (touch){
				if(touch.phase == TouchPhase.BEGAN){
					_fsm.changeState(Game.MENU_STATE);
				}
			}
		}
		
		private function buildString():String{
			var highscoreList:String = "";
			for (var i:Number = 0; i < _highscoreArray.length - 1; i++){
				highscoreList += (i+1) + ". " + _highscoreArray[i].name + " : " + _highscoreArray[i].value + "\n";
			}
			return highscoreList;
		}
		private function getSharedObject():void{
			//check if the sharedObject has highscore
			if (_so.data.hasOwnProperty("highscore")){
				_highscoreArray = _so.data.highscore;
			}else{
				initHighScoreArray();
			}
		}
		private function initHighScoreArray():void{
			for (var i:Number = 0; i < 10; i++){
				_highscoreArray[i] = {name:"", value:0};
			}
		}
		override public function destroy():void {
			removeChild(_heading);
			_heading = null;
			_so = null;
			_highscoreArray = [];
		}
		private function get highscoreList():String {
			return buildString();
		}
		
	}

}