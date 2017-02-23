package ui {
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class CustomButton extends Button {
		
		private var img1:Texture = Texture.fromBitmapData(Assets.blueButtonBmapData);
		private var img2:Texture = Texture.fromBitmapData(Assets.redButtonBmapData);
		private var img3:Texture = Texture.fromBitmapData(Assets.greenButtonBmapData);
		private var img4:Texture = Texture.fromBitmapData(Assets.yellowButtonBmapData);
		
		public function CustomButton(text:String="") 
		{
			super(img1, text, img2, img3, img4);
		}
		
	}

}