package ui {
	import starling.text.TextFormat;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	
	/**
	 * ...
	 * @author Niklas le Comte
	 */
	public class Label extends TextField {
		private var _format:TextFormat = new TextFormat();
		//Creates a textfield with an given format
		public function Label(text:String, width:Number, height:Number, size:Number = 14, color:uint = 0xFFFFFF, fontName:String = "Verdana"){
			_format.font = fontName;
			_format.color = color;
			_format.size = size;
			super(width, height, text, _format);
		}
	}

}