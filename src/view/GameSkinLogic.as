package view {
	import events.GameEvents;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import view.symbol.BGAlphaStyle;
	import view.symbol.BorderStyle;
	import view.symbol.Colors;
	import view.symbol.FIgures;
	import view.symbol.Fill;
	
	import vo.SymbolVO;
	
	public class GameSkinLogic extends Sprite {
		private var _gameSkin:ClipGameScreen;
		
		private var _sym:Symbol = new Symbol();
		
		private var _lastRightCard:Symbol = new Symbol();
		private var _lastWrongCard:Symbol = new Symbol();
		private var _rubaha:ClipRubaha = new ClipRubaha();
		
		private var _lastChance:ClipLastchance;
		private var _ruleWas:ClipRulewas;
		
		[Embed(source="../assets/no.png")]	private var NO:Class;
		[Embed(source="../assets/yes.png")]	private var YES:Class;
		
		private var _no:Bitmap;
		private var _yes:Bitmap;
		
		public function GameSkinLogic(){
			_gameSkin = new ClipGameScreen();
			_lastChance =  new ClipLastchance();
			_ruleWas    =  new ClipRulewas();
			_lastChance.visible = false;
			_ruleWas.visible = false;
			
			addChild(_gameSkin);
			addChild(sym);
			addChild(_ruleWas);
			addChild(_lastChance);
			addChild(_rubaha);
			_rubaha.visible = false;
			
			_lastChance.x = _ruleWas.x = 319 - 78;
			_lastChance.y = _ruleWas.y = 267 - 78;
			
			_no  = new NO as Bitmap;
			_yes = new YES as Bitmap;
			
			addChild(_no);
			addChild(_yes);
			
			_no.x  = _gameSkin.width / 2 - _no.width / 2;
			_yes.x = _gameSkin.width / 2 - _yes.width / 2;
			_no.y = _yes.y = 230;
			_no.visible = _yes.visible = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedTosStage);
		}
		
		public function showNO(show:Boolean):void {
			_no.visible = show;
		}
		
		public function showYES(show:Boolean):void {
			_yes.visible = show;
		}
		
		private var _blocker:Boolean;

		public function get blocker():Boolean{
			return _blocker;
		}

		public function set blocker(value:Boolean):void {
			_blocker = value;
		}

		protected function onKeyDown(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case Keyboard.LEFT: {
					onNoClick();
					break;
				}
					
				case Keyboard.RIGHT: {
					onYesClick();
					break;
				}
			}
		}
		
		protected function onAddedTosStage(event:Event):void {
			_gameSkin.x = stage.stageWidth / 2 - _gameSkin.width / 2;
			_gameSkin.y = stage.stageHeight/ 2 - _gameSkin.height/ 2;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_gameSkin.eYes.addEventListener(MouseEvent.CLICK, onYesClick);
			_gameSkin.eNo.addEventListener(MouseEvent.CLICK, onNoClick);
			_ruleWas.eNext.addEventListener(MouseEvent.CLICK, onNextButtonClick);
			_lastChance.eNext.addEventListener(MouseEvent.CLICK, onNextButtonClick);	
		}
		
		protected function onNextButtonClick(event:MouseEvent = null):void {
			dispatchEvent(new GameEvents(GameEvents.NEXT_CLICK));
		}
		
		public function showRuleCard(show:Boolean):void {
			_blocker = show;
			_ruleWas.visible = show;
		}
		
		public function showLastChance(show:Boolean):void {
			_blocker = show;
			_lastChance.visible = show;
		}
		
		public function set rule(value:Dictionary):void {
			var text:String;
			
			if (value["figureColor"]) {
				text = "Цвет фигуры: \n";
				if (value["figureColor"] == Colors.BLUE)
					text += "синий";
				else if (value["figureColor"] == Colors.GREEN)
					text += "зеленый";
				else if (value["figureColor"] == Colors.RED)
					text += "красный";
			}
			
			if (value["fill"]) {
				text = "Заливка: \n";
				if (value["fill"] == Fill.BORDER)
					text += "граница";
				else if (value["fill"] == Fill.FILL)
					text += "полная заливка";
				else if (value["fill"] == Fill.GRADIENT)
					text += "градиент";
			}
			
			if ( value["figure"]){
				text = "Фигура: \n";
				if (value["figure"] == FIgures.CIRCLE)
					text += "круг";
				else if (value["figure"] == FIgures.TRIANGLE)
					text += "треугольник";
				else if (value["figure"] == FIgures.SQUARE)
					text += "квадрат";
			}
			
			if ( value["bgColor"]){
				text = "Цвет фона: \n";
				if (value["bgColor"] == Colors.BIEGE)
					text += "бежевый";
				else if (value["bgColor"] == Colors.GREY)
					text += "серый";
				else if (value["bgColor"] == Colors.WHITE)
					text += "белый";
			}
			
			if (  value["bgImageAlpah"]){
				text = "Узор фона: \n";
				if (value["bgImageAlpah"] == BGAlphaStyle.DIAGONAL_LINES)
					text += "клетка";
				else if (value["bgImageAlpah"] == BGAlphaStyle.NO_LINES)
					text += "пустой";
				else if (value["bgImageAlpah"] == BGAlphaStyle.HORIZONTAL_LINES)
					text += "линейка";
			}
			
			if (  value["borderStyle"]){
				text = "Граница фона: \n";
				if (value["borderStyle"] == BorderStyle.DASHED)
					text += "пунктир";
				else if (value["borderStyle"] == BorderStyle.DOTS)
					text += "точки";
				else if (value["borderStyle"] == BorderStyle.SOLID)
					text += "непрерывная";
			}
			
			if (  value["figuresAmount"]){
				text = "Кол-во фигур: \n";
				if (value["figuresAmount"] == 1)
					text += "1";
				else if (value["figuresAmount"] == 2)
					text += "2";
				else if (value["figuresAmount"] == 3)
					text += "3";
			}
			
			_ruleWas.eRuleWas.text = text;
		}
		
		protected function onNoClick(event:MouseEvent = null):void{
			if (_blocker) return;
			dispatchEvent(new GameEvents(GameEvents.NO_CLICK));
		}
		
		protected function onYesClick(event:MouseEvent = null):void{
			if (_blocker) return;
			dispatchEvent(new GameEvents(GameEvents.YES_CLICK));
		}
		
		public function set level(value:uint):void {
			_gameSkin.eCardLeft.gotoAndStop(value);
			_gameSkin.eCardRight.gotoAndStop(value);
		}
		
		public function set cardsLeftLabel(value:uint):void {
			_gameSkin.eCardsLeft.text = value.toString();
		}
		
		public function generateCard(level:uint):void {
			sym.getSymbol(level);
			
			sym.x = 319;
			sym.y = 267;
		}
		
		public function get rulesCompleted():uint {
			return parseInt(_gameSkin.eRules.text);
		}
		
		public function set rulesCompleted(value:uint):void{
			_gameSkin.eRules.text = value.toString();
		}
		
		public function set cardsLeft(value:int):void {
			_gameSkin.eCardsLeft.text = value.toString();
		}
		
		public function get cardsLeft():int {
			return parseInt(_gameSkin.eCardsLeft.text);
		}
		
		public function set points(value:int):void {
			_gameSkin.ePoints.text = value.toString();
		}
		
		public function get points():int {
			return parseInt(_gameSkin.ePoints.text);
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
		
		public function get cardRight():MovieClip{
			return _gameSkin.eCardRight;
		}
		
		public function get cardLeft():MovieClip{
			return _gameSkin.eCardLeft;
		}
		
		
		public function get sym():Symbol{
			return _sym;
		}
		
		public function set sym(value:Symbol):void{
			_sym = value;
		}	
		
		public function hideLastCombinations():void {
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