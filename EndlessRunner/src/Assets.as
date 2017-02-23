package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.net.URLRequest;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Assets {
		
		public static const BACKGROUND_MUSIC:URLRequest = new URLRequest("./assets/LugnTechno.mp3");
		public static const JUMP_SOUND:URLRequest = new URLRequest("./assets/jump.mp3");
		public static const PICKUP_CLOCK_SOUND:URLRequest = new URLRequest("./assets/powerUp2.mp3");
		public static const END_BEEP:URLRequest = new URLRequest("./assets/zap1.mp3");
		
		public static var playerWalk1BmapData:BitmapData = null;
		public static var playerWalk2BmapData:BitmapData = null;
		public static var playerJumpBmapData:BitmapData = null;
		public static var playerDeathBmapData:BitmapData = null;
		public static var clockBmapData:BitmapData = null;
		public static var backgroundBmapData:BitmapData = null;
		public static var blueButtonBmapData:BitmapData = null;
		public static var redButtonBmapData:BitmapData = null;
		public static var greenButtonBmapData:BitmapData = null;
		public static var yellowButtonBmapData:BitmapData = null;
		public static var spikesBmapData:BitmapData = null;
		public static var robotBmapData:BitmapData = null;
		
		public function Assets() {
			init();
		}
		
		//Embeded Font creation
		[Embed(source = "/Assets/LeagueGothic-Regular.otf",
		fontName = "LeagueGothic",
		mimeType = "application/x-font",
		unicodeRange = "U+0021-U+0023, U+0025-U+0026, U+0028-U+002a, U+002c, U+002e-U+003f, U+005e-U+007a, U+007c, U+00a4, U+00e4-U+00e5, U+00f6",
		advancedAntiAliasing = "true",
		embedAsCFF = "false")]
		public var LeagueGothicClass:Class;
		
		[Embed(source = "/Assets/playerGreen_walk1.png")]
		public var PlayerWalk1:Class
		
		[Embed(source = "/Assets/playerGreen_walk2.png")]
		public var PlayerWalk2:Class
		
		[Embed(source = "/Assets/playerGreen_walk4.png")]
		public var PlayerJump:Class
		
		[Embed(source = "/Assets/player_death.png")]
		public var PlayerDeath:Class
		
		[Embed(source = "/Assets/clock.png")]
		public var Clock:Class
		
		[Embed(source = "/Assets/backgroundImage.jpg")]
		public var Background:Class
		
		[Embed(source = "/Assets/blue_button.png")]
		public var BlueButton:Class
		
		[Embed(source = "/Assets/red_button.png")]
		public var RedButton:Class
		
		[Embed(source = "/Assets/green_button.png")]
		public var GreenButton:Class
		
		[Embed(source = "/Assets/yellow_button.png")]
		public var YellowButton:Class
		
		[Embed(source = "/Assets/spikes.png")]
		public var Spikes:Class
		
		[Embed(source = "/Assets/robot.png")]
		public var Robot:Class
		
		private function init():void {
			playerJumpBmapData = (new PlayerJump() as Bitmap).bitmapData;
			playerWalk1BmapData = (new PlayerWalk1() as Bitmap).bitmapData;
			playerWalk2BmapData = (new PlayerWalk2() as Bitmap).bitmapData;
			playerDeathBmapData = (new PlayerDeath() as Bitmap).bitmapData;
			backgroundBmapData = (new Background() as Bitmap).bitmapData;
			
			blueButtonBmapData = (new BlueButton() as Bitmap).bitmapData;
			redButtonBmapData = (new RedButton() as Bitmap).bitmapData;
			greenButtonBmapData = (new GreenButton() as Bitmap).bitmapData;
			yellowButtonBmapData = (new YellowButton() as Bitmap).bitmapData;
			spikesBmapData = (new Spikes() as Bitmap).bitmapData;
			robotBmapData = (new Robot() as Bitmap).bitmapData;
			
			clockBmapData = (new Clock() as Bitmap).bitmapData;
		}
	}
	
	

}