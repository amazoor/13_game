package view {
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	
	import events.GameEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import model.Rules;
	import model.Screen;
	
	import vo.SymbolVO;
	
	public class GameScreen extends AbstractScreen {
		public static const MAX_CARDS			:uint = 90;
		public static const MAX_TRIES			:uint = 20;
		public static const MAX_WRONG_TRIES		:uint = 10;
		public static const WIN_RULE_TRIES		:uint = 5;
		public static const RULES_TO_NEXT_LEVEL	:uint = 10;
		
		private var _rules:Rules = new Rules();
		private var _rightAnswers		:uint;
		private var _wrongAnswers		:uint;
		private var _level				:uint;
		private var _cardsLeft			:uint;
		private var _points				:uint;
		private var _rulesCompleted		:uint;
		private var _cardsUsed			:uint;
		private var _skin				:GameSkinLogic;
		private var _isLastChance		:Boolean;
		private var _lastWrongCardVO	:SymbolVO = new SymbolVO();
		private var _lastRightCardVO	:SymbolVO = new SymbolVO();
		private var _isGameOver			:Boolean;
		
		public function GameScreen(startLevel:uint) {
			_skin = new GameSkinLogic();
			addChild(_skin);
			this.level = startLevel;
			_skin.rulesCompleted = 0;
			_skin.showRuleCard(false);
			init();
			_skin.showLastChance(false);
			
		}
		
		public function get cardsUsed():int {
			return _cardsUsed;
		}
		
		public function set cardsUsed(value:int):void {
			_cardsUsed = value;
			
			if (_cardsUsed == MAX_TRIES - 1) {
				_skin.showLastChance(true);
			}
			
			if (_cardsUsed == MAX_TRIES) {
				_isLastChance = true;
				_skin.showRuleCard(true);
				_cardsUsed = 0;
			}
		}
		
		private function init():void {
			startLevel(level);
			_skin.addEventListener(GameEvents.NO_CLICK, onNoClick);
			_skin.addEventListener(GameEvents.YES_CLICK, onYesClick);
			_skin.addEventListener(GameEvents.NEXT_CLICK, nextButtonClick);
		}
		
		private function countPoints():uint {
			return (level * 100) + (20 - cardsUsed);
		}
		
		public function get rightAnswers():uint {
			return _rightAnswers;
		}
		
		private function playSound(sound:String):void {
			var event:GameEvents = new GameEvents(GameEvents.PLAY_SOUND);
			event.soundName = sound;
			dispatchEvent(event);
		}
		
		public function set rightAnswers(value:uint):void {
			_rightAnswers = value;
			if(_rightAnswers == WIN_RULE_TRIES) {
				_rulesCompleted++;
				playSound("rule_complete")
				_skin.rulesCompleted = _rulesCompleted;
				_skin.points += countPoints();
				_skin.showRuleCard(true);
				_rightAnswers = 0;
				cardsUsed = 0;
				
				if (_rulesCompleted % RULES_TO_NEXT_LEVEL == 0) {
					level++;
				}
				
				if (_isGameOver) {
					gameOver();
				}
			}
			_skin.hideLastCombinations();
		}
		
		public function get wrongAnswers():uint {
			return _wrongAnswers;
		}
		
		public function set wrongAnswers(value:uint):void {
			_wrongAnswers = value;
			if (_wrongAnswers == MAX_WRONG_TRIES) {
				_skin.showLastCombinations(_lastWrongCardVO, _lastRightCardVO);
				_wrongAnswers = 0;
			}
			
			if (_isGameOver) {
				gameOver();
			}
		}
		
		private function gameOver():void {
			if (_isGameOver) {
				_isGameOver = true;
				_skin.removeEventListener(GameEvents.NO_CLICK, onNoClick);
				_skin.removeEventListener(GameEvents.YES_CLICK, onYesClick);
				_skin.removeEventListener(GameEvents.NEXT_CLICK, nextButtonClick);
				
				var e:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
				e.screen = Screen.GAME_OVER_SCREEN;
				e.level  = level;
				e.points = _skin.points;
				e.rules  = _rulesCompleted;
				dispatchEvent(e);
			}
		}
		
		public function get cardsLeft():uint{
			return _skin.cardsLeft;
		}
		
		public function set cardsLeft(value:uint):void {
			_cardsLeft = value;
			_skin.cardsLeftLabel = _cardsLeft;
			cardsUsed++;
			
			if (_cardsLeft <= 0) {
				_isGameOver = true;
				_cardsLeft = 0;
			}
		}
		
		public function get level():uint {
			return _level;
		}
		
		public function set level(value:uint):void {
			trace(value);
			trace(_level)
			trace(_skin)
			trace(_skin.points)
			trace(_skin.rulesCompleted)
			
			game.sccClientController.scc_trace(value);
			game.sccClientController.scc_trace(_level);
			game.sccClientController.scc_trace(_skin);
			game.sccClientController.scc_trace(_skin.points);
			game.sccClientController.scc_trace(_skin.rulesCompleted);
			
			game.sccClientController.saveScore(_level, _skin.points, {rulesCompleted:_skin.rulesCompleted});
			_level = value;
			_skin.level = level;
		}
		
		protected function nextButtonClick(event:Event):void {
			_skin.showRuleCard(false);
			_skin.showLastChance(false);
			if (!_isLastChance)
				_skin.rule = _rules.generateRule(level);
		}
		
		private function startLevel(level:uint):void {
			_skin.cardsLeft = MAX_CARDS;
			
			_skin.rule = _rules.generateRule(level);
			_skin.generateCard(level);
		}
		
		public function get cardRight():MovieClip {
			return _skin.cardRight;
		}
		
		public function get cardLeft():MovieClip {
			return _skin.cardLeft;
		}
		
		protected function onYesClick(event:GameEvents = null):void {
			_skin.blocker = true;
			cardsLeft--;
			if(_rules.checkRule(sym)) {
				_lastRightCardVO = sym.cloneVO();
				TweenNano.to(sym, .4, {x:cardRight.x + cardRight.width / 2, y:cardRight.y + cardRight.height / 2, onComplete:rotate});
				rightAnswers++;
				wrongAnswers = 0;
				playSound("right");
				_skin.showYES(true);
			} else {
				_lastWrongCardVO = sym.cloneVO();
				TweenNano.to(sym, .4, {x:cardLeft.x + cardLeft.width / 2, y:cardLeft.y + cardLeft.height / 2, onComplete:rotate});
				rightAnswers = 0;
				wrongAnswers++;
				playSound("wrong");
				_skin.showNO(true);
			}
			trace("+:", rightAnswers, " -:", _wrongAnswers);
		}
		
		protected function onNoClick(event:GameEvents = null):void {
			_skin.blocker = true;
			cardsLeft--;
			if(_rules.checkRule(sym)) {
				_lastRightCardVO = sym.cloneVO();
				TweenNano.to(sym, .4, {x:cardRight.x + cardRight.width / 2, y:cardRight.y + cardRight.height / 2, onComplete:rotate});
				rightAnswers = 0;
				wrongAnswers++;
				playSound("wrong");
				_skin.showNO(true);
			} else {
				_lastWrongCardVO = sym.cloneVO();
				TweenNano.to(sym, .4, {x:cardLeft.x + cardLeft.width / 2, y:cardLeft.y + cardLeft.height / 2, onComplete:rotate});
				rightAnswers++;
				wrongAnswers = 0;
				playSound("right");
				_skin.showYES(true);
			}
			trace("+:", rightAnswers, " -:", _wrongAnswers);
		}
		
		private function rotate():void {
			TweenNano.to(sym, .2, {scaleX:0, onComplete:finalRotate, ease:Linear.easeNone});
		}
		
		private function finalRotate():void {
			sym.rotate();
			TweenNano.to(sym, .2, {scaleX:1, ease:Linear.easeNone, onComplete:showNextCard});
		}
		
		public function get sym():Symbol {
			return _skin.sym;
		}
		
		private function showNextCard():void {
			_skin.showYES(false);
			_skin.showNO(false);
			_skin.blocker = false;
			_skin.generateCard(level);	
		}
	}
}
