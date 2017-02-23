package core  {
	import nape.space.Space;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class State extends Sprite {
		public var _fsm:Game = null;
		public var _space:Space = null;
		public function State(fsm:Game, space:Space) {
			super();
			_fsm = fsm;
			_space = space;
			
		}
		public function update():void {
			
		}
		public function destroy():void {
			
		}
		
	}

}