package view {
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	
	import events.GameEvents;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import model.Rules;

	public class GameScreen extends AbstractScreen {
		public static const MAX_CARDS		:uint = 90;
		public static const MAX_TRIES		:uint = 20;
		public static const MAX_WRONG_TRIES	:uint = 10;
		public static const WIN_RULE_TRIES	:uint = 5;
		
		private var _rightAnswers:uint; 
		private var _wrongAnswers:uint;
		private var _rules:Rules = new Rules();
		private var _level:uint = 1;
		private var _cardsLeft	:uint;
		private var _points		:uint;
		private var _rule		:uint;
		
		private var _cardsUsed:uint;
		
		private var _skin:GameSkin;
		
		private function countPoints():uint {
			var levelBonus:uint = level * 100;
			
			var points:uint = levelBonus + (20 - _cardsUsed);
			return points;
		}
		
		public function GameScreen(startLevel:uint) {
			_skin = new GameSkin();
			addChild(_skin);
			
			this.level = startLevel;
			_skin.level = startLevel;
			_skin.showRuleCard(false);
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function get rightAnswers():uint {
			return _rightAnswers;
		}

		public function set rightAnswers(value:uint):void
		{
			_rightAnswers = value;
			if (_rightAnswers == WIN_RULE_TRIES) {
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
		
		private function startLevel(level:uint):void {
			_skin.cardsLeft = MAX_TRIES;
			
			_skin.rule = _rules.generateRule(level);
			_skin.generateCard(level);
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
			_skin.generateCard(level);
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