package view
{
	import events.GameEvents;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import model.Screen;
	
	public class GameController extends Sprite
	{
		private var _screen:AbstractScreen;
		
		public function GameController()
		{
			super();
		}
		
		public function get screen():AbstractScreen {
			return _screen;
		}
		
		public function set screen(value:AbstractScreen):void {
			if (_screen != value) {
				if (_screen && _screen.parent) {
					_screen.removeEventListener(GameEvents.SHOW_SCREEN, onChangeScreen);
					removeChild(_screen);
					_screen = null;
				}
				
				_screen = value;
			}
		}
		
		public function set pause(value:Boolean):void {
			
		}
		
		public function startGame():void {
			_screen = new TitleScreen();
			addChild(_screen);
			_screen.addEventListener(GameEvents.SHOW_SCREEN, onChangeScreen);
		}
		
		protected function onChangeScreen(event:GameEvents):void {
			switch (event.screen) {
				case Screen.HOW_TO_PLAY_SCREEN:
					screen = new HowToPlayScreen();
					break;
				
				case Screen.PLAY_SCREEN:
					screen = new GameScreen();
					break;
				
				case Screen.TITLE_SCREEN:
					screen = new TitleScreen();
					break;
			}
			
			addChild(_screen);
			_screen.addEventListener(GameEvents.SHOW_SCREEN, onChangeScreen);
		}
	}
}