package states 
{
	import core.Game;
	import core.State;
	import core.Config;
	import core.SoundManager;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import ui.Label;
	import ui.CustomButton;
	import nape.space.Space;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Instructions extends State {
		
		private var _backBtn:CustomButton = new CustomButton("BACK");
		
		public function Instructions(fsm:Game, space:Space) {
			super(fsm, space);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var textHeading:Label = new Label("Instructions", 1000, 100, 84, Config.WHITE);
			textHeading.x = Config.WORLD_CENTER_X - textHeading.width * 0.5;
			addChild(textHeading);
			
			var textInstruction:Label = new Label(buildInstructionString(), 700, 400, 32, Config.WHITE);
			textInstruction.x = Config.WORLD_CENTER_X - textInstruction.width * 0.5;
			textInstruction.y = textHeading.y + textHeading.height;
			addChild(textInstruction);
			
			_backBtn.x = Config.WORLD_CENTER_X - _backBtn.width * 0.5;
			_backBtn.y = textInstruction.y + textInstruction.height;
			addChild(_backBtn);
			_backBtn.addEventListener(TouchEvent.TOUCH, onBackClick);
			SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 0.5);
		}
		
		private function onBackClick(e:TouchEvent):void {
			var touch:Touch = e.getTouch(_backBtn);
			if (touch){
				if(touch.phase == TouchPhase.BEGAN){
					_fsm.changeState(Game.MENU_STATE);
				}
			}
		}
		
		private function buildInstructionString():String {
			var str:String = "";
			str += "Run as far as possible before the time gets to 0 and avoid every possible obstacle that is in your way."
			    + "If you run into something or fall off the platform you die, and if the time runs out the game is finished."
				+ "\n1. Press P to paus the game."
				+ "\n2. Press left mouse button to jump, if you hold it down you jump higher."
				+ "\n3. Press ESC to leave the game.";
			return str;
		}
		
		override public function destroy():void {
			_backBtn.removeEventListener(TouchEvent.TOUCH, onBackClick);
			removeChild(_backBtn);
			_backBtn = null;
		}

		
	}

}