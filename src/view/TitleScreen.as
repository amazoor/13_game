package view {
	import events.GameEvents;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.Screen;
	
	public class TitleScreen extends AbstractScreen {
		private var _titleScreen:ClipTitleScreen;
		
		public function TitleScreen() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		protected function onAddedToStage(event:Event):void {
			_titleScreen = new ClipTitleScreen();
			addChild(_titleScreen);
			_titleScreen.x = stage.stageWidth / 2 - _titleScreen.width / 2;
			_titleScreen.y = stage.stageHeight/ 2 - _titleScreen.height/ 2;
			(_titleScreen.eHowToPlay as SimpleButton).addEventListener(MouseEvent.CLICK, onHowToPlayGameMouseClick);
			(_titleScreen.ePlay as SimpleButton).addEventListener(MouseEvent.CLICK, onPlayGameMouseClick);
		}
		
		protected function onHowToPlayGameMouseClick(event:MouseEvent):void {
			(_titleScreen.eHowToPlay as SimpleButton).removeEventListener(MouseEvent.CLICK, onHowToPlayGameMouseClick);
			(_titleScreen.ePlay as SimpleButton).removeEventListener(MouseEvent.CLICK, onPlayGameMouseClick);
			
			var evt:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			evt.screen = Screen.HOW_TO_PLAY_SCREEN;
			dispatchEvent(evt);
		}
		
		protected function onPlayGameMouseClick(event:MouseEvent):void {
			(_titleScreen.eHowToPlay as SimpleButton).removeEventListener(MouseEvent.CLICK, onHowToPlayGameMouseClick);
			(_titleScreen.ePlay as SimpleButton).removeEventListener(MouseEvent.CLICK, onPlayGameMouseClick);
			
			var evt:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			evt.screen = Screen.PLAY_SCREEN;
			dispatchEvent(evt);
		}
	}
}