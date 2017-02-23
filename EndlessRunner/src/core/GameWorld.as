package core {
	import gameObjects.Robot;
	import starling.events.Event;
	import gameObjects.Runner;
	import nape.space.Space;
	import nape.geom.Vec2;
	import starling.display.Sprite;
	import states.Play;
	import gameObjects.Ground;
	import gameObjects.Clock;
	import gameObjects.Spike;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreListener;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.PreFlag;
	import ui.Label;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class GameWorld extends Sprite {
		public static const PLAYER_DIED_EVENT:String = "playerDied";
		public static const ADD_TIME_TO_TIMER:String = "addTimeToTimer";
		
		private var _playState:Play;
		private var _space:Space;
		private var _runner:Runner;
		private var _entities:Vector.<Entity> = new Vector.<Entity>;
		
		private var _interactionListener1:InteractionListener;
		private var _clockPreListener:PreListener;
		private var _spikeInterationListener:InteractionListener;
		private var _robotInteractionListener:InteractionListener;
		private var _groundCollisionType:CbType=new CbType();
		private var _runnerCollisionType:CbType = new CbType();
		private var _clockCollisionType:CbType = new CbType();
		private var _spikeCollisionType:CbType = new CbType();
		private var _robotCollisionType:CbType = new CbType();
		
		private var _runnerOnClock:Boolean = false;
		private var _lastClockHit:Clock = null;
		
		public function GameWorld(playState:Play, space:Space, runner:Runner) {
			super();
			_playState = playState;
			_space = space;
			_runner = runner;
			init();
		}
		
		private function init():void {
			_interactionListener1 = new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_groundCollisionType,_runnerCollisionType,runnerOnGround);
			_space.listeners.add(_interactionListener1);
			
			_clockPreListener = new PreListener(InteractionType.COLLISION,_clockCollisionType,_runnerCollisionType,runnerOnClock, 0, true);
			_space.listeners.add(_clockPreListener);
			
			_spikeInterationListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,_spikeCollisionType,_runnerCollisionType,runnerOnSpike);
			_space.listeners.add(_spikeInterationListener);
			
			_robotInteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, _robotCollisionType, _runnerCollisionType, runnerOnRobot);
			_space.listeners.add(_robotInteractionListener);
			_runner.body.cbTypes.add(_runnerCollisionType);
			
			setUpStart();
		}
		
		private function runnerOnRobot(cb:InteractionCallback):void {
			dispatchEvent(new Event(PLAYER_DIED_EVENT));
		}
		
		private function runnerOnSpike(cb:InteractionCallback):void {
			dispatchEvent(new Event(PLAYER_DIED_EVENT));
		}
		
		private function runnerOnClock(cb:PreCallback):PreFlag {
			var clock:Clock = cb.int1.userData.object;
			clock._isAlive = false;
			_lastClockHit = clock;
			_runnerOnClock = true;
			dispatchEvent(new Event(ADD_TIME_TO_TIMER));
			return PreFlag.IGNORE;
		}
			
		private function runnerOnGround(collision:InteractionCallback):void {
			_runner.hasLanded();
		}
		private function createTimeGFX():void {
			var time:Label = new Label("+ " + Config.CLOCK_TIME_BONUS, 50, 50, 14, Config.WHITE);
			time.x = _lastClockHit.x;
			time.y = _lastClockHit.y;
			addChild(time);
			_runnerOnClock = false;
		}
		
		private function setUpStart():void {
			var firstGround:Ground = new Ground(_space, Vec2.weak(0, Config.WORLD_HEIGHT - Utils.random(Config.GROUND_POSITION_Y_MIN, Config.GROUND_POSITION_Y_MAX)));
			addToVector(firstGround);
			for (var i:Number = 1; i < 4; i++){
				var randomGapSize:Number = Utils.random(Config.GAP_SIZE_MIN, Config.GAP_SIZE_MAX);
				var randomYPosition:Number = Utils.random(Config.GROUND_POSITION_Y_MIN, Config.GROUND_POSITION_Y_MAX);
				var ground:Ground = new Ground(_space, 
												Vec2.weak(_entities[_entities.length - 1].x + _entities[_entities.length - 1].width + randomGapSize, 
												Config.WORLD_HEIGHT - randomYPosition));
				addToVector(ground);
			}
		}
		
		private function checkIfOutOfScope(entities:Vector.<Entity>):void {
			for each (var entity:Entity in entities){
				if (_runner != null && _runner.body.position.x - (entity.body.position.x + entity.width) > 1000){
					entity._isAlive = false;
					if(entity is Ground) {
						createNewGround();
					}
				}
			}
		}
		
		private function createNewGround():void {
			var lastGround:Ground;
			//Get last inserted ground in vector
			for (var i:Number = _entities.length -1; i >= 0; i--){
				if (_entities[i] is Ground){
					lastGround = _entities[i] as Ground;
					break;
				}
			}
			var randomGapSize:Number = Utils.random(Config.GAP_SIZE_MIN, Config.GAP_SIZE_MAX);
			var newGround:Ground = new Ground(_space, Vec2.weak(lastGround.x + lastGround.width + randomGapSize, Config.WORLD_HEIGHT - Utils.random(300, 500)));
			addToVector(newGround);
			createNewClock(newGround);
			if (!createNewSpike(newGround)){
				createNewRobot(newGround);
			}
		}
		
		private function createNewRobot(ground:Ground):void {
			var rand:Number = Utils.random(0, Config.ClOCK_SPAWN_CHANCE);
			if (rand < 3){
				var robot:Robot = new Robot(_space, Vec2.weak(0, 0), ground.x, ground.x + ground.width);
				var positionX:Number = Utils.random(ground.x, ground.x + ground.width - robot.width);
				robot.body.position.y = ground.y - robot.height;
				robot.body.position.x = positionX;
				robot.y = robot.body.position.y;
				robot.x = positionX;
				addToVector(robot);
			}
		}
		
		private function createNewSpike(ground:Ground):Boolean {
			var rand:Number = Utils.random(0, Config.ClOCK_SPAWN_CHANCE);
			if (rand < 3){
				var spike:Spike = new Spike(_space, Vec2.weak(0, 0));
				var positionX:Number = Utils.random(ground.x, ground.x + ground.width - spike.width);
				spike.body.position.y = ground.y - spike.height;
				spike.body.position.x = positionX;
				spike.y = spike.body.position.y;
				spike.x = positionX;
				addToVector(spike);
				rand = Utils.random(0, Config.ClOCK_SPAWN_CHANCE);
				if (rand < 5){
					var spike2:Spike = new Spike(_space, Vec2.weak((ground.x + ground.width) - (spike.x - ground.x), spike.y));
					addToVector(spike2);
				}
				return true;
			}
			return false;
		}
		
		private function createNewClock(ground:Ground):void {
			var rand:Number = Utils.random(0, Config.ClOCK_SPAWN_CHANCE);
			if (rand < 3){
				var positionX:Number = Utils.random(ground.x - Config.CLOCK_DIST_FROM_GROUND_X_MAX, ground.x + ground.width + Config.CLOCK_DIST_FROM_GROUND_X_MAX);
				var positionY:Number = Utils.random(ground.y - Config.CLOCK_DIST_FROM_GROUND_Y_MAX, ground.y);
				var clock:Clock = new Clock(_space, Vec2.weak(positionX, positionY));
				clock.body.position.y -= clock.height;
				clock.y = clock.body.position.y;
				addToVector(clock);
			}
		}
		
		private function removeDeadObjects(entities:Vector.<Entity>):void {
			var temp:Entity;
			for (var i:Number = entities.length -1; i >= 0; i--){
				temp = entities[i] as Entity;
				if (!temp._isAlive){
					removeChild(temp);
					temp.destroy();
					temp.space = null;
					entities.removeAt(i);
				}
			}
		}
		
		private function addToVector(entity:Entity):void {
			if(entity is Ground){
				entity.body.cbTypes.add(_groundCollisionType);
			} else if (entity is Clock){
				entity.body.cbTypes.add(_clockCollisionType);
			} else if (entity is Spike){
				entity.body.cbTypes.add(_spikeCollisionType);
			} else if (entity is Robot){
				entity.body.cbTypes.add(_robotCollisionType);
			}
			_entities.push(entity);
			_space.bodies.add(entity.body);
			addChild(entity);
		}
		
		private function moveRobots():void {
			for each(var entity:Entity in _entities){
				if (entity is Robot){
					entity.update();
				}
			}
		}
		
		public function update():void {
			if (_runnerOnClock) {
				createTimeGFX();
			}
			moveRobots();
			checkIfOutOfScope(_entities);
			removeDeadObjects(_entities);
		}
		
		public function destroy():void {
			for (var i:Number = 0; i < _entities.length; i++){
				_entities[i]._isAlive = false;
			}
			removeDeadObjects(_entities);
			_space.listeners.remove(_interactionListener1);
			_space.listeners.remove(_clockPreListener);
			_space.listeners.remove(_robotInteractionListener);
			_space.listeners.remove(_spikeInterationListener);
			_interactionListener1 = null;
			_clockPreListener = null;
			_robotInteractionListener = null;
			_spikeInterationListener = null;
			_space = null;
			_playState = null;
			_entities = new Vector.<Entity>;
		}
	}

}