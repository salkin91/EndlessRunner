package states 
{
	import core.Camera;
	import core.GameWorld;
	import core.Time;
	import core.Game;
	import core.State;
	import core.Config;
	import core.Utils;
	import core.Key;
	import core.SoundManager;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import gameObjects.Runner;
	import gameObjects.Clock;
	import nape.geom.Vec2;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.phys.BodyType;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import ui.GUI;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Play extends State {
		
		private var _runner:Runner = null;
		private var _camera:Camera = null;
		private var _debug:BitmapDebug = null;
		private var _time:Time = new Time();
		private var _score:Number = 0;
		private var _gameWorld:GameWorld = null;
		private var _deathTimer:Timer = new Timer(3000, 1);
		private var _isGameOver:Boolean = false;
		private var _gui:GUI = new GUI();
		
		public function Play(fsm:Game, space:Space) {
			super(fsm, space);
			addEventListener(Event.ADDED_TO_STAGE, init);	
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_gui);
			_runner = new Runner(_space, Vec2.weak(100, 100));
			_gameWorld = new GameWorld(this, _space, _runner);
			_gameWorld.addEventListener(GameWorld.PLAYER_DIED_EVENT, onPlayerDied);
			_gameWorld.addEventListener(GameWorld.ADD_TIME_TO_TIMER, onAddMoreTime);
			addChild(_gameWorld);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			_space.bodies.add(_runner.body);
			addChild(_runner);
			_debug = new BitmapDebug(stage.stageWidth, stage.stageHeight, stage.color, true);
			_camera = new Camera(_runner, this, _gui);
			
			_time.addEventListener(Time.UPDATE_TIME, onUpdateTime);
			_time.addEventListener(Time.NO_TIME_LEFT, onNoTimeLeft);
			_time.start();
			SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 1);
			_gui.timeText = _time.currentTime;
		}
		
		private function onAddMoreTime(e:Event):void {
			SoundManager.play(SoundManager.CLOCK_PICKUP_SOUND);
			_time.addTime(Config.CLOCK_TIME_BONUS);
		}
		
		private function onPlayerDied(e:Event):void {
			gameOver();
		}
		
		private function gameOver():void {
			_isGameOver = true;
			_time.stop();
			_gui.addDeathText();
			_runner.body.allowMovement = false;
			_runner.body.type = BodyType.STATIC;
			_deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDeathTimer, false, 0, true);
			_deathTimer.start();
		}
		
		private function onDeathTimer(e:TimerEvent):void {
			_deathTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onDeathTimer);
			_fsm.changeState(Game.GAME_OVER);
		}
		
		private function onTouch(e:TouchEvent):void{
			var touch:Touch = e.getTouch(stage);
			if(touch){
				if(touch.phase == TouchPhase.BEGAN){
					addEventListener(EnterFrameEvent.ENTER_FRAME, onMouseBtnHold);
				}
				else if (touch.phase == TouchPhase.ENDED){
					_runner.hasJumped = true;
					removeEventListener(EnterFrameEvent.ENTER_FRAME, onMouseBtnHold);
				}	
			}
		}
		
		private function onMouseBtnHold(e:EnterFrameEvent):void {
			if(_runner){
				_runner.jump();
			}
		}
		private function onUpdateTime(e:Event):void {
			_gui.timeText = _time.currentTime;
			_score += 57;
			_gui.scoreText = _score;
		}
		private function onNoTimeLeft(e:Event):void {
			gameOver();
		}
		
		private function checkIfPaused():void {
			if (_fsm.isPaused){
				SoundManager.pause(SoundManager.BACKGROUND_MUSIC);
				if(_time.isCounting){
					_time.stop();
				}
				_fsm.changeState(Game.PAUSE_STATE);
			}else {
				if(!_time.isCounting){
					_time.start();
				}
				SoundManager.resume(SoundManager.BACKGROUND_MUSIC);
				SoundManager.setVolume(SoundManager.BACKGROUND_MUSIC, 1);
			}
		}
		
		private function updatePositions():void{
			_runner.update();
			_camera.update();
			_gameWorld.update();
			if (_runner.body.position.y > Config.WORLD_HEIGHT + 100){
				gameOver();
			}
		}
		
		override public function destroy():void{
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			_time.removeEventListener(Time.UPDATE_TIME, onUpdateTime);
			_time.removeEventListener(Time.NO_TIME_LEFT, onNoTimeLeft);
			_time.destroy();
			_time = null;
			_runner = null;
			_camera = null;
			_debug = null;
			_gameWorld.destroy();
			_gameWorld.removeEventListener(GameWorld.PLAYER_DIED_EVENT, onPlayerDied);
			removeChild(_gameWorld);
			_gameWorld = null;
			removeChild(_gui);
			_gui = null;
		}
		
		override public function update():void{
			checkIfPaused();
			_debug.clear();
			_debug.draw(_space);
			_debug.flush();
			_debug.display.x = this.x;
			_debug.display.y = this.y;
			updatePositions();
			if (Key.isDown(Key.EXIT)){
				_fsm.changeState(Game.MENU_STATE);
			}
		}
		
		public function get time():Time {
			return _time;
		}
		
		public function get score():Number {
			return _score;
		}
	}

}