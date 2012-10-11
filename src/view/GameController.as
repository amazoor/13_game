package view
{
	import events.GameEvents;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import model.Rules;
	import model.Screen;
	
	public class GameController extends Sprite
	{
		[Embed (source="../assets/bg/bg.jpg")]
		private var BG:Class;
		
		private var _screen:AbstractScreen;
		
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
				_screen.addEventListener(GameEvents.PLAY_SOUND, onPlay);
			}
		}
		
		private var _level:uint;
		public function startGame(level:uint):void {
			_level = level;
			screen = new GameScreen(_level);
			addChild(_screen);
			_screen.addEventListener(GameEvents.SHOW_SCREEN, onChangeScreen);
		}
		
		protected function onChangeScreen(event:GameEvents):void {
			switch (event.screen) {
				case Screen.HOW_TO_PLAY_SCREEN:
					screen = new HowToPlayScreen();
					break;
				
				case Screen.PLAY_SCREEN:trace(_level)
					screen = new GameScreen(_level);
					
					break;
				
				/*case Screen.TITLE_SCREEN:
					screen = new TitleScreen();
					break;*/
				
				case Screen.GAME_OVER_SCREEN:
					game.sccClientController.showEndScreen(event.points, {rulesCompleted:event.rules, level:event.level});
					game.sccClientController.saveScore(event.level, event.points, {rulesCompleted:event.rules});
					//screen = new GameOverScreen(event.level, event.points, event.rules);
					break;
			}
			
			addChild(_screen);
			_screen.addEventListener(GameEvents.SHOW_SCREEN, onChangeScreen);
			
		}
		
		protected function onPlay(event:GameEvents):void {
			game.sccClientController.playSound(event.soundName);
		}
	}
}