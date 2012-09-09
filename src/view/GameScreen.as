package view {
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	
	import events.GameEvents;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import model.LevelDataGenerator;
	import model.Rules;
	import model.vo.LevelVO;

	public class GameScreen extends AbstractScreen {
		private var _rightAnswers:uint; 
		private var _wrongAnswers:uint;
		private var _rules:Rules = new Rules();
		private var _level:uint;
		private var _cardsLeft	:uint;
		private var _points		:uint;
		private var _rule		:uint;
		
		public static const RIGHT_ANSWERS_TARGET:uint = 5;
		public static const WRONG_ANSWERS_TARGET:uint = 10;
		
		private var _skin:GameSkin;
		
		public function GameScreen(level:uint) {
			_skin = new GameSkin();
			addChild(_skin);
			
			this.level = level;
			_skin.level = level;
			_skin.showRuleCard(false);
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function get rightAnswers():uint {
			return _rightAnswers;
		}

		public function set rightAnswers(value:uint):void
		{
			_rightAnswers = value;
			if (_rightAnswers == RIGHT_ANSWERS_TARGET) {
				_rightAnswers = 0;
				_skin.showRuleCard(true);
				ruleComplete();
			}
		}
		
		private function ruleComplete():void {
			
		}
		
		public function set cardsLeft(value:uint):void {
			_cardsLeft = value;
			_skin.cardsLeftLabel = _cardsLeft;
		}

		public function get level():uint {
			return _level;
		}

		public function set level(value:uint):void {
			_level = value;
		}

		private function init(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			startLevel(level);
			_skin.addEventListener(GameEvents.NO_CLICK, onNoClick);
			_skin.addEventListener(GameEvents.YES_CLICK, onYesClick);
			_skin.addEventListener(GameEvents.NEXT_CLICK, nextButtonClick);
		}
		
		protected function nextButtonClick(event:Event):void {
			_skin.showRuleCard(false);
			_skin.rule = _rules.generateRule(level);
		}
		private var _levelVO:LevelVO;
		private function startLevel(level:uint):void {
			_levelVO = LevelDataGenerator.getlevelData(level);
			_skin.cardsLeft = _levelVO.cardsLeft;
			
			_skin.rule = _rules.generateRule(level);
			_skin.generateCard();
		}
		
		public function get cardRight():Image {
			return _skin.cardRight;
		}
		
		public function get cardLeft():Image {
			return _skin.cardLeft;
		}
		
		protected function onYesClick(event:GameEvents = null):void {
			_cardsLeft--;
			
			if (_rules.checkRule(sym)) {
				_skin.lastRightCard = sym.clone();
				TweenNano.to(sym, .4, {x:cardRight.x + cardRight.width / 2, y:cardRight.y + cardRight.height /2, onComplete:rotate});
				rightAnswers++;
				_wrongAnswers = 0;
			} else {
				_skin.lastWrongCard = sym.clone();
				TweenNano.to(sym, .4, {x:cardLeft.x + cardLeft.width / 2, y:cardLeft.y + cardLeft.height /2, onComplete:rotate});
				rightAnswers = 0;
				_wrongAnswers++;
			}	
			
			trace("points:", rightAnswers);
			trace("Wpoints:", _wrongAnswers);
		}
		
		protected function onNoClick(event:GameEvents = null):void {
			_cardsLeft--;
			if (_rules.checkRule(sym)) {
				_skin.lastWrongCard = sym.clone();
				TweenNano.to(sym, .4, {x:cardRight.x + cardRight.width / 2, y:cardRight.y + cardRight.height /2, onComplete:rotate});
				
				rightAnswers = 0;
				_wrongAnswers++;
			} else {
				_skin.lastRightCard = sym.clone();
				TweenNano.to(sym, .4, {x:cardLeft.x + cardLeft.width / 2, y:cardLeft.y + cardLeft.height /2, onComplete:rotate});
				
				rightAnswers++;
				_wrongAnswers = 0;
			}	
			
			trace("points:", rightAnswers);
			trace("Wpoints:", _wrongAnswers);
		}
		
		private function rotate():void {
			TweenNano.to(sym, .2, {scaleX:0, onComplete:finalRotate, ease:Linear.easeNone});
		}
		
		private function finalRotate():void {
			_skin.sym.imageSource = _skin.cardLeft.source; 
			TweenNano.to(sym, .2, {scaleX:1, ease:Linear.easeNone, onComplete:showNextCard});
		}
		
		public function get sym():Symbol {
			return _skin.sym;
		}
		
		private function showNextCard():void {
			_skin.generateCard();
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