package view
{
	import flash.display.Sprite;
	
	public class LevelSymbol extends Sprite
	{
		
		private var _card:Image = new Image();
		private var _circle:Image = new Image("assets/levelchoice/levelchoice_number_bg.png");
		private var _level:int = -1;
		private var _label:Label = new Label();
		
		public function LevelSymbol(level:uint)
		{
			
			this.level = level;
		}
		
		public function get level():uint
		{
			return _level;
		}
		
		public function set level(value:uint):void
		{
			if (_level != value) {
				_level = value;
				_label.text = level.toString();
				
				_label.x = 30;
				_label.y = 23;
				_label.color= 0x718E92;
				_label.font = "MPS";
				_card.source = "assets/rubaha/rubaha"+level+".png";
				addChild(_card);
				_card.scaleX = _card.scaleY = .5;
				addChild(_circle);
				_circle.x = 22;
				addChild(_label);
			}
		}
	}
	
}
