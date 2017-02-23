package states 
{
	import core.Game;
	import core.State;
	import core.Key;
	import core.SoundManager;
	import nape.space.Space;
	import ui.Label;
	import core.Config;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class PauseState extends State 
	{
		
		public function PauseState(fsm:Game, space:Space) 
		{
			super(fsm, space);
			var label:Label = new Label("Paused!", 400, 200, 86, Config.WHITE);
			var label2:Label = new Label("Press P to resume!", 400, 200, 32, Config.WHITE);
			label.x = Config.WORLD_WIDTH * 0.5 - label.width * 0.5;
			label.y = Config.WORLD_HEIGHT * 0.5 - label.height * 0.5;
			label2.x = Config.WORLD_WIDTH * 0.5 - label2.width * 0.5;
			label2.y = label.y + label.height;
			addChild(label);
			addChild(label2);
			SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 0.5);
		}
		override public function update():void {		
			if (!_fsm.isPaused){
				_fsm.changeState(Game.PLAY_STATE);
			}
		}
	}

}