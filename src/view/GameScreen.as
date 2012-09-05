package view {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import model.Rules;
	
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;

	public class GameScreen extends AbstractScreen {
		private var _bg		:Image;
		private var _yes	:Button;
		private var _no		:Button;
		
		private var _cardLeft		:Image = new Image();
		private var _cardRight		:Image = new Image();
		
		public function GameScreen() {
			_bg = new Image("assets/bg/scene2_bg.png");
			addChild(_bg);
			
			_yes = new Button();
			_no	 = new Button();
			
			_cardLeft.source = "assets/rubaha/rubaha1.png";
			_cardRight.source = "assets/rubaha/rubaha1.png";
			
			_yes.upStateImage = "assets/Button/button_yes_normal.png";
			_yes.overStateImage = "assets/Button/button_yes_over.png";
			_yes.downStateImage = "assets/Button/button_yes_down.png";
			
			_no.upStateImage = "assets/Button/button_no_normal.png";
			_no.overStateImage = "assets/Button/button_no_over.png";
			_no.downStateImage = "assets/Button/button_no_down.png";
			
			addChild(_yes);
			addChild(_no);
			addChild(_cardLeft);
			addChild(_cardRight);
			
			_cardLeft.x = 20;
			_cardLeft.y = 85;
			
			_cardRight.x = 470;
			_cardRight.y = 85;
			
			_yes.x = 450;
			_yes.y = 260;
			
			_no.x = 20;
			_no.y = 260;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_yes.addEventListener(MouseEvent.CLICK, onYesClick);
			_no.addEventListener(MouseEvent.CLICK, onNoClick);
			
			startLevel(1);
		}
		private var sym:Symbol;
		private function startLevel(level:uint):void
		{
			sym = new Symbol();
			sym.getSymbol();
			addChild(sym);
			sym.x = 242;
			sym.y = 190;
		}
		
		protected function onYesClick(event:MouseEvent = null):void
		{
			if ( Rules.checkRule(1,  this["sym"] as Symbol) ) {
				trace("right")
			}
		}
		
		protected function onNoClick(event:MouseEvent = null):void
		{
			if ( !Rules.checkRule(1,  this["sym"] as Symbol) ) {
				trace("right")
			}	
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode) {
				case Keyboard.LEFT:
					onNoClick();
					break;
				
				case Keyboard.RIGHT:
					onYesClick();
					break;
			}
		}
	}
}