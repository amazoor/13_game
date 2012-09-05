package view
{
	import events.GameEvents;
	
	import flash.events.MouseEvent;
	
	import model.Screen;

	public class HowToPlayScreen extends AbstractScreen
	{
		private var _playButton			:Button;
		private var _nextButton			:Button;
		private var _backButton			:Button;
		
		private var _instruction		:Image;
		private var _instructionNumber	:int;
		
		public function HowToPlayScreen()
		{
			super();
			
			_instruction = new Image("assets/instruction/instruction0.png");
			
			_playButton = new Button();
			_nextButton = new Button();
			_backButton = new Button();
			
			_playButton.upStateImage	= "assets/Button/button_play_normal.png";
			_playButton.overStateImage	= "assets/Button/button_play_over.png";
			_playButton.downStateImage	= "assets/Button/button_play_down.png";
			
			_nextButton.upStateImage	= "assets/Button/button_next_normal.png";
			_nextButton.overStateImage	= "assets/Button/button_next_over.png";
			_nextButton.downStateImage	= "assets/Button/button_next_down.png";
			
			_backButton.upStateImage	= "assets/Button/button_back_normal.png";
			_backButton.overStateImage	= "assets/Button/button_back_over.png";
			_backButton.downStateImage	= "assets/Button/button_back_down.png";
			
			_playButton.x = 230;
			_playButton.y = 380;
			
			_nextButton.x = 420;
			_nextButton.y = 380;
			
			_backButton.x = 45;
			_backButton.y = 380;
			
			_instruction.x = 47;
			_instruction.y = 20;
			
			addChild(_playButton);
			addChild(_nextButton);
			addChild(_backButton);
			addChild(_instruction);
			
			_playButton.addEventListener(MouseEvent.CLICK, onPlayButtonMouseClick);
			_nextButton.addEventListener(MouseEvent.CLICK, onBackButtonMouseClick);
			_backButton.addEventListener(MouseEvent.CLICK, onNextButtonMouseClick);
		}
		
		
		public function getInstructionURL(id:int):String {
			return "assets/instruction/instruction"+id+".png";
		}
		
		public function get instructionNumber():int {
			return _instructionNumber;
		}

		public function set instructionNumber(value:int):void {
			_instructionNumber = value;
			
			if (_instructionNumber < 0) {
				_instructionNumber = 2;
			} else if (_instructionNumber > 2) {
				_instructionNumber = 0;
			}
			
			_instruction.source = getInstructionURL(_instructionNumber);
			trace(_instruction.source)
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
			_playButton.removeEventListener(MouseEvent.CLICK, onPlayButtonMouseClick);
			_nextButton.removeEventListener(MouseEvent.CLICK, onBackButtonMouseClick);
			_backButton.removeEventListener(MouseEvent.CLICK, onNextButtonMouseClick);
		}
	}
}