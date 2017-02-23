package ui {
	import core.Config;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class GUI extends Sprite{
		private var _background:Image = new Image(Texture.fromBitmapData(Assets.backgroundBmapData));
		private var _timeLabel:Label = new Label("0:00", 100, 50, 32, Config.WHITE);
		private var _scoreLabel:Label = new Label("Score: 0", 500, 50, 32, Config.WHITE);
		public function GUI() {
			addChild(_background);
			_timeLabel.x = Config.WORLD_CENTER_X - _timeLabel.width * 0.5;
			_timeLabel.y = 0;
			addChild(_timeLabel);
			
			_scoreLabel.x =  Config.WORLD_WIDTH -  _scoreLabel.width;
			_scoreLabel.y = 0;
			addChild(_scoreLabel);
		}
		
		public function set timeText(text:String):void {
			_timeLabel.text = text;
		}
		public function set scoreText(text:Number):void {
			_scoreLabel.text = "Score: " + text.toString();
		}
		
		public function addDeathText():void {
			var deathText:Label = new Label("YOU DIED", 200, 200, 48, Config.RED);
			deathText.x = Config.WORLD_CENTER_X - deathText.width * 0.5;
			deathText.y = (Config.WORLD_CENTER_Y - deathText.height * 0.5) * 0.20;
			addChild(deathText);
		}
	}

}