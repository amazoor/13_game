package view {
	import events.GameEvents;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;
	
	import vo.SymbolVO;
	
	public class GameSkin extends Sprite {
		private var _level:uint;
		
		private var _bg		:Image;
		private var _yes	:Button;
		private var _no		:Button;
		
		private var _cardLeft		:Image = new Image();
		private var _cardRight		:Image = new Image();
		private var _sym:Symbol = new Symbol();
		
		private var _cardsLeftLabel		:Label;
		private var _ruleLabel			:Label;
		private var _rulesCompleted		:Label;
		
		private var _lastRightCard:Symbol = new Symbol();
		private var _lastWrongCard:Symbol = new Symbol();
		
		private var _ruleWas:Image = new Image("assets/more/paneltext_rulewas.png");
		private var _lastChance:Image = new Image("assets/more/paneltext_lastchance.png");
		private var _next:Button = new Button();
		
		private var _pointsLabel:Label = new Label("0");
		private var _text:String;
		
		public function GameSkin(){
			_rulesCompleted = new Label();
			_rulesCompleted.color = 0x006837;
			_rulesCompleted.x = 500;
			_rulesCompleted.y = 4;
			_rulesCompleted.font = "MPS";
			
			
			_pointsLabel.color = 0x006837;
			_pointsLabel.x = 375;
			_pointsLabel.y = 4;
			_pointsLabel.font = "MPS";
			
			_cardsLeftLabel = new Label();
			
			_ruleLabel = new Label();
			
			_cardsLeftLabel.text = "0";
			_cardsLeftLabel.x = 275;
			_cardsLeftLabel.y = 4;
			_cardsLeftLabel.color = 0x006837;
			_cardsLeftLabel.font = "MPS";
			
			_bg = new Image("assets/bg/scene2_bg.png");
			addChild(_bg);
			
			_yes = new Button();
			_no	 = new Button();
			
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
			
			_yes.addEventListener(MouseEvent.CLICK, onYesClick);
			_no.addEventListener(MouseEvent.CLICK, onNoClick);
			
			_cardLeft.x = 20;
			_cardLeft.y = 85;
			
			_cardRight.x = 470;
			_cardRight.y = 85;
			
			_yes.x = 450;
			_yes.y = 260;
			
			_no.x = 20;
			_no.y = 260;
			addChild(sym);
			
			addChild(_ruleWas);
			addChild(_lastChance);
			addChild(_ruleLabel);
			addChild(_pointsLabel);
			addChild(_cardsLeftLabel);
			addChild(_rulesCompleted);
			_ruleLabel.color = 0xC1272D;
			
			_ruleWas.x = 319 - 77;
			_ruleWas.y = 267 - 77;
			_lastChance.x = 319 - 77;
			_lastChance.y = 267 - 77;
			
			_next.upStateImage = "assets/Button/smallbutton_next_normal.png";
			_next.overStateImage = "assets/Button/smallbutton_next_over.png";
			_next.downStateImage = "assets/Button/smallbutton_next_down.png";
			addChild(_next);
			
			_next.x  = _ruleWas.x + 21;
			_next.y  = _ruleWas.y + 110;
			_next.addEventListener(MouseEvent.CLICK, onNextButtonClick);
		}
		
		protected function onNextButtonClick(event:MouseEvent):void {
			dispatchEvent(new GameEvents(GameEvents.NEXT_CLICK));
		}
		
		public function showRuleCard(show:Boolean):void {
			_next.visible = show;
			_ruleWas.visible = show;
			_ruleLabel.visible = show;
		}
		
		public function showLastChance(show:Boolean):void {
			_lastChance.visible = show; 
			_next.visible		= show;
		}
		
		
		public function set rule(value:Dictionary):void {
			if (value["figureColor"]) {
				_text = "Цвет фигуры: \n";
				if (value["figureColor"] == Colors.BLUE)
					_text += "синий";
				else if (value["figureColor"] == Colors.GREEN)
					_text += "зеленый";
				else if (value["figureColor"] == Colors.RED)
					_text += "красный";
			}
			
			if (value["fill"]) {
				_text = "Заливка: \n";
				if (value["fill"] == Fill.BORDER)
					_text += "граница";
				else if (value["fill"] == Fill.FILL)
					_text += "полная заливка";
				else if (value["fill"] == Fill.GRADIENT)
					_text += "градиент";
			}
			
			if ( value["figure"]){
				_text = "Фигура: \n";
				if (value["figure"] == FIgures.CIRCLE)
					_text += "круг";
				else if (value["figure"] == FIgures.TRIANGLE)
					_text += "треугольник";
				else if (value["figure"] == FIgures.SQUARE)
					_text += "квадрат";
			}
			
			if ( value["bgColor"]){
				_text = "Цвет фона: \n";
				if (value["bgColor"] == Colors.BIEGE)
					_text += "бежевый";
				else if (value["bgColor"] == Colors.GREY)
					_text += "серый";
				else if (value["bgColor"] == Colors.WHITE)
					_text += "белый";
			}
			
			if (  value["bgImageAlpah"]){
				_text = "Узор фона: \n";
				if (value["bgImageAlpah"] == BGAlphaStyle.DIAGONAL_LINES)
					_text += "клетка";
				else if (value["bgImageAlpah"] == BGAlphaStyle.NO_LINES)
					_text += "пустой";
				else if (value["bgImageAlpah"] == BGAlphaStyle.HORIZONTAL_LINES)
					_text += "линейка";
			}
			
			if (  value["borderStyle"]){
				_text = "Граница фона: \n";
				if (value["borderStyle"] == BorderStyle.DASHED)
					_text += "пунктир";
				else if (value["borderStyle"] == BorderStyle.DOTS)
					_text += "точки";
				else if (value["borderStyle"] == BorderStyle.SOLID)
					_text += "непрерывная";
			}
			
			if (  value["figuresAmount"]){
				_text = "Кол-во фигур: \n";
				if (value["figuresAmount"] == 1)
					_text += "1";
				else if (value["figuresAmount"] == 2)
					_text += "2";
				else if (value["figuresAmount"] == 3)
					_text += "3";
			}
			
			_ruleLabel.text = _text;
			_ruleLabel.x = _ruleWas.x + 150 / 2 - _ruleLabel.width / 2;
			_ruleLabel.y = _ruleWas.y + 30;
			trace(_ruleLabel.text)
		}
		
		protected function onNoClick(event:MouseEvent):void{
			dispatchEvent(new GameEvents(GameEvents.NO_CLICK));
		}
		
		protected function onYesClick(event:MouseEvent):void{
			dispatchEvent(new GameEvents(GameEvents.YES_CLICK));
		}
		
		public function get level():uint {
			return _level;
		}
		
		public function set level(value:uint):void {
			if (_level != value) {
				_level = value;
				_cardLeft.source = "assets/rubaha/rubaha"+level+".png";
				_cardRight.source = "assets/rubaha/rubaha"+level+".png";
			}
		}
		
		public function set cardsLeftLabel(value:uint):void {
			_cardsLeftLabel.text = value.toString();
		}
		
		public function generateCard(level:uint):void {
			sym.getSymbol(level);
			
			sym.x = 319;
			sym.y = 267;
		}
		
		public function get rulesCompleted():uint {
			return parseInt(_rulesCompleted.text);
		}
		
		public function set rulesCompleted(value:uint):void{
			_rulesCompleted.text = value.toString();
		}
		
		public function set cardsLeft(value:int):void {
			_cardsLeftLabel.text = value.toString();
		}
		
		public function get cardsLeft():int {
			return parseInt(_cardsLeftLabel.text);
		}
		
		public function set points(value:int):void {
			_pointsLabel.text = value.toString();
		}
		
		public function get points():int {
			return parseInt(_pointsLabel.text);
		}
		public function get lastWrongCard():Symbol{
			return _lastWrongCard;
		}
		
		public function set lastWrongCard(value:Symbol):void{
			_lastWrongCard = value;
		}
		
		public function get lastRightCard():Symbol{
			return _lastRightCard;
		}
		
		public function set lastRightCard(value:Symbol):void{
			_lastRightCard = value;
		}
		
		public function get cardRight():Image{
			return _cardRight;
		}
		
		public function set cardRight(value:Image):void{
			_cardRight = value;
		}
		
		public function get cardLeft():Image{
			return _cardLeft;
		}
		
		public function set cardLeft(value:Image):void{
			_cardLeft = value;
		}
		
		public function get sym():Symbol{
			return _sym;
		}
		
		public function set sym(value:Symbol):void{
			_sym = value;
		}	
		
		public function hideLastCombinations():void
		{
			_lastRightCard.visible = false;
			_lastWrongCard.visible = false;
		}
		
		public function showLastCombinations(wrong:SymbolVO, right:SymbolVO):void {
			if (right.bgImageAlpah)
				_lastRightCard.makeSymbolFromVO(right);
			if (wrong.bgImageAlpah)
				_lastWrongCard.makeSymbolFromVO(wrong);
			
			addChild(_lastWrongCard);
			_lastWrongCard.x = 20 + 77;
			_lastWrongCard.y = 85 + 77;
			
			addChild(_lastRightCard);
			_lastRightCard.x = 470 + 77;
			_lastRightCard.y = 85 + 77;
			
			_lastRightCard.visible = true;
			_lastWrongCard.visible = true;
		}
	}
}