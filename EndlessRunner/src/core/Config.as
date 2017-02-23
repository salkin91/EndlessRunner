package core {
	import nape.geom.Vec2;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Config {
		
		public function Config() {}
		public static const CUSTOMEFONT:String = "LeagueGothic";
		
		public static const BLACK:uint = 0x000000;
		public static const GREY:uint = 0x808080;
		public static const BLUE:uint = 0x0080FF;
		public static const WHITE:uint = 0xFFFFFF;
		public static const RED:uint = 0xFF0000;
		public static const GREEN:uint = 0x00FF00;
		public static const LINE_SIZE:Number = 2;
		
		public static const WORLD_WIDTH:Number = 1500;
		public static const WORLD_HEIGHT:Number = 720;
		public static const WORLD_CENTER_X:Number = WORLD_WIDTH * 0.5;
		public static const WORLD_CENTER_Y:Number = WORLD_HEIGHT * 0.5;
		
		public static const GRAVITY:Vec2 = Vec2.weak(0, 2300);
		
		public static const GROUND_POSITION_Y_MIN:Number = 300;
		public static const GROUND_POSITION_Y_MAX:Number = 500;
		public static const GAP_SIZE_MIN:Number = 180;
		public static const GAP_SIZE_MAX:Number = 300;
		
		public static const RUNNER_SPEED:Number = 800;
		public static const RUNNER_SPEED_GAIN:Number = 6;
		public static const JUMP_TIME:Number = 14;
		public static const RUNNER_IMG_SWITCH:Number = 10;
		
		public static const START_TIME:Number = 60;
		public static const CLOCK_TIME_BONUS:Number = 10;
		
		public static const ClOCK_SPAWN_CHANCE:Number = 10;
		public static const CLOCK_DIST_FROM_GROUND_Y_MAX:Number = 200;
		public static const CLOCK_DIST_FROM_GROUND_X_MAX:Number = 100;
		
		public static const BUTTON_GAP:Number = 50;
		
		public static const TO_RAD:Number = (Math.PI / 180);
		public static const TO_DEG:Number = (180 / Math.PI);
	}

}