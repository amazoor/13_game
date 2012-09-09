package view
{
	import events.GameEvents;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import model.Screen;

	public class LevelSelectScreen extends AbstractScreen
	{
		private var _card:Image = new Image("assets/rubaha/rubaha1.png");
		private var _level:Label = new Label("1");
		
		public function LevelSelectScreen()
		{
			_level.color = 0x718E92;
			_level.font = "MPS";
			addChild(_level);
			var text:Image = new Image("assets/levelchoice/level_text.png");
			addChild(text);
			var choice:Image = new Image("assets/levelchoice/levelchoice_text.png");
			addChild(choice);
			
			choice.x = 203;
			choice.y = 40;
			
			text.x = 285;
			text.y = 76;
			
			var button:Button = new Button();
			button.upStateImage = "assets/Button/button_play_normal.png";
			button.overStateImage = "assets/Button/button_play_over.png";
			button.downStateImage = "assets/Button/button_play_down.png";
			addChild(button);
			button.x = 244;
			button.y = 270;
			button.addEventListener(MouseEvent.CLICK, onLevelSelected);
			
			addChild(_card);
			_card.x = 255;
			_card.y = 100;
			
			var bLeft:Button = new Button();
			var bRight:Button = new Button();
			
			bLeft.upStateImage		= "assets/levelchoice/levelchoice_left_normal.png";
			bLeft.overStateImage	= "assets/levelchoice/levelchoice_left_over.png";
			bLeft.downStateImage	= "assets/levelchoice/levelchoice_left_down.png";
			addChild(bLeft);
			
			bRight.upStateImage = "assets/levelchoice/levelchoice_right_normal.png";
			bRight.overStateImage = "assets/levelchoice/levelchoice_right_over.png";
			bRight.downStateImage = "assets/levelchoice/levelchoice_right_down.png";
			addChild(bRight);
			
			bLeft.x = 100;
			bLeft.y = 365;
			
			_level.x = 365;
			_level.y = 68;
			
			bRight.x = 515;
			bRight.y = 365;
			addChild(_cont);
			bLeft.addEventListener(MouseEvent.CLICK, onLeftClick);
			bRight.addEventListener(MouseEvent.CLICK, onRightClick);
			generateCardLevels(_s, _e);
		}
		
		protected function onLevelSelected(event:MouseEvent):void
		{
			var ge:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			ge.screen = Screen.PLAY_SCREEN;
			ge.level = parseInt(_level.text);
			dispatchEvent(ge);
		}
		private var _s:uint = 1;
		private var _e:uint = 5;
		protected function onRightClick(event:MouseEvent):void
		{
			_s++;
			_e++;
			if (_e > 7) {
				_s--;
				_e--;
				return;
			}
			generateCardLevels(_s, _e);
		}
		
		protected function onLeftClick(event:MouseEvent):void
		{
			_s--;
			_e--;
			
			if (_s < 1) {
				_s++;
				_e++;
				return;
			}
			generateCardLevels(_s, _e);
		}
		private var _cont:Sprite = new Sprite();
		private function generateCardLevels(start:uint, end:uint):void {
			while(_cont.numChildren)
			_cont.removeChildAt(0);
			var count:uint;
			for (var i:uint = start; i <= end; i++) {
				var ls:LevelSymbol = new LevelSymbol(i);
				ls.addEventListener(MouseEvent.CLICK, onMC);
				ls.x = 130 + ((75 * count) * 1.01) ;
				ls.y = 365;
				_cont.addChild(ls);
				count++
			}
		}
		
		protected function onMC(event:MouseEvent):void
		{
			var ls:LevelSymbol = event.currentTarget as LevelSymbol;
			_card.source = "assets/rubaha/rubaha"+ls.level+".png"
			_level.text = ls.level.toString(); 
		}
		
	}
}