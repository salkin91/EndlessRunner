package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import core.Game;
	import core.SoundManager;
	
	[SWF(frameRate="60", width="1500", height="720", backgroundColor="0x000000")]
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Main extends Sprite 
	{
		private var _star:Starling = null;
		public function Main() 
		{
			_star = new Starling(Game, stage);
			//_star.showStats = true;
			_star.start();
			SoundManager.load();
			addEventListener(Event.DEACTIVATE, onDeactivate, false, 0 , true);
		}
		
		private function onDeactivate(e:Event):void {
			removeEventListener(Event.DEACTIVATE, onDeactivate);
			_star.stop();
			SoundManager.pause(SoundManager.BACKGROUND_MUSIC);
			addEventListener(Event.ACTIVATE, onActivate, false, 0, true);
		}
		
		private function onActivate(e:Event):void {
			removeEventListener(Event.ACTIVATE, onActivate);
			_star.start();
			SoundManager.resume(SoundManager.BACKGROUND_MUSIC);
			addEventListener(Event.DEACTIVATE, onDeactivate, false, 0 , true);
		}
	}
	
}