package view
{
	import events.GameEvents;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import model.Screen;
	
	public class GameController extends Sprite
	{
		[Embed (source="assets/bg/bg.jpg")]
		private var BG:Class;
		
		private var _screen:AbstractScreen;
		private var _level:uint = 1;
		
		public function GameController()
		{
			super();
			addChild(new BG as Bitmap);
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
					screen = new GameScreen(event.level);
					break;
				
				case Screen.TITLE_SCREEN:
					screen = new TitleScreen();
					break;
				
				case Screen.LEVEL_CHOOSE__SCREEN:
					screen = new LevelSelectScreen();
					break;
			}
			
			addChild(_screen);
			_screen.addEventListener(GameEvents.SHOW_SCREEN, onChangeScreen);
		}
	}
}