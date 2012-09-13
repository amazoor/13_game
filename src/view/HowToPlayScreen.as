package view {
	import events.GameEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.Screen;

	public class HowToPlayScreen extends AbstractScreen {
		private var _instructionNumber	:int;
		private var _htp				:ClipHTP;
		
		public function HowToPlayScreen() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		 
		protected function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_htp = new ClipHTP();
			_htp.x = stage.stageWidth / 2 - _htp.width / 2;
			_htp.y = stage.stageHeight/ 2 - _htp.height/ 2;
			addChild(_htp);
			instructionNumber = 1;
			_htp.ePlay.addEventListener(MouseEvent.CLICK, onPlayButtonMouseClick);
			_htp.eBack.addEventListener(MouseEvent.CLICK, onBackButtonMouseClick);
			_htp.eNext.addEventListener(MouseEvent.CLICK, onNextButtonMouseClick);
		}		
		
		private function hideAll():void {
			_htp.i1.visible = false;
			_htp.i2.visible = false;
			_htp.i3.visible = false;
		}
		
		public function get instructionNumber():int {
			return _instructionNumber;
		}

		public function set instructionNumber(value:int):void {
			hideAll();
			
			_instructionNumber = value;
			
			if (_instructionNumber < 1) {
				_instructionNumber = 3;
			} else if (_instructionNumber > 3) {
				_instructionNumber = 1;
			}
			
			(_htp["i"+_instructionNumber] as MovieClip).visible = true;
		}

		protected function onNextButtonMouseClick(event:MouseEvent):void {
			instructionNumber--;
		}
		
		protected function onBackButtonMouseClick(event:MouseEvent):void {
			instructionNumber++;
		}
		
		protected function onPlayButtonMouseClick(event:MouseEvent):void {
			removeListeners();
			var evt:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			evt.screen = Screen.PLAY_SCREEN;
			dispatchEvent(evt);
		}
		
		private function removeListeners():void {
			_htp.ePlay.removeEventListener(MouseEvent.CLICK, onPlayButtonMouseClick);
			_htp.ePlay.removeEventListener(MouseEvent.CLICK, onBackButtonMouseClick);
			_htp.ePlay.removeEventListener(MouseEvent.CLICK, onNextButtonMouseClick);
		}
	}
}