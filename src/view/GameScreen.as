package view {
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	
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
		private var _rules:Rules = new Rules();
		private var _bg		:Image;
		private var _yes	:Button;
		private var _no		:Button;
		
		private var _cardLeft		:Image = new Image();
		private var _cardRight		:Image = new Image();
		private var sym:Symbol = new Symbol();
		private var _level:uint;
		
		private var _cardsLeft	:uint;
		private var _points		:uint;
		private var _rule		:uint;
		
		private var _cardsLeftLabel		:Label;
		private var _pointsLable		:Label;
		private var _ruleLabel			:Label;
		
		public function GameScreen(level:uint) {
			_cardsLeftLabel = new Label();
			_pointsLable = new Label();
			_ruleLabel = new Label();
			
			_cardsLeftLabel.x = 275;
			_cardsLeftLabel.y = 6;
			
			this.level = level;
			
			
			
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
			
			addChild(_cardsLeftLabel);
			addChild(_pointsLable);
			addChild(_ruleLabel);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function get cardsLeft():uint
		{
			return _cardsLeft;
		}

		public function set cardsLeft(value:uint):void
		{
			_cardsLeft = value;
			_cardsLeftLabel.text = cardsLeft.toString();
		}

		public function get cardsLeftLabel():Label
		{
			return _cardsLeftLabel;
		}

		public function set cardsLeftLabel(value:Label):void
		{
			_cardsLeftLabel = value;
		}

		public function get level():uint {
			return _level;
		}

		public function set level(value:uint):void {
			_level = value;
			
			switch ( _level ) {
				case 1:
					_cardsLeft = 30;
					break;
			}
			
			_cardsLeftLabel.text = _cardsLeft.toString();
			_pointsLable.text 	= _points.toString();;
			_ruleLabel.text = _rule.toString();
		}

		private function init(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_yes.addEventListener(MouseEvent.CLICK, onYesClick);
			_no.addEventListener(MouseEvent.CLICK, onNoClick);
			
			startLevel(level);
		}
		
		private function startLevel(level:uint):void {
			_rules.generateRule(level);
			sym.getSymbol();
			addChild(sym);
			sym.x = 319;
			sym.y = 267;
		}
		
		protected function onYesClick(event:MouseEvent = null):void
		{
			cardsLeft--;
			
			if ( _rules.checkRule(this["sym"] as Symbol) ) {
				TweenNano.to(sym, .2, {x:_cardRight.x + _cardRight.width / 2, y:_cardRight.y + _cardRight.height /2, onComplete:rotate});
			} else {
				TweenNano.to(sym, .2, {x:_cardLeft.x + _cardLeft.width / 2, y:_cardLeft.y + _cardLeft.height /2, onComplete:rotate});
			}
		}
		
		protected function onNoClick(event:MouseEvent = null):void
		{
			cardsLeft--;
			
			if ( !_rules.checkRule( this["sym"] as Symbol) ) {
				TweenNano.to(sym, .2, {x:_cardLeft.x + _cardLeft.width / 2, y:_cardLeft.y + _cardLeft.height /2, onComplete:rotate});
			}	else {
				TweenNano.to(sym, .2, {x:_cardRight.x + _cardRight.width / 2, y:_cardRight.y + _cardRight.height /2, onComplete:rotate});
				
			}
		}
		
		private function rotate():void {
			TweenNano.to(sym, .15, {rotationY:-110, onComplete:finalRotate, ease:Linear.easeNone});
		}
		
		private function finalRotate():void {
			sym.imageSource = _cardLeft.source; 
			TweenNano.to(sym, .15, {rotationY:0, ease:Linear.easeNone, onComplete:showNextCard});
		
		}
		
		private function showNextCard():void {
			sym.getSymbol();
			//addChild(sym);
			sym.x = 319;
			sym.y = 267;
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