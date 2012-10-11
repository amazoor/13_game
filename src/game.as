package {
	import SCClient.SCClientController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import interfaces.IStartup;
	
	import view.GameController;
	
	[SWF(width="640", height="480", backgroundColor="0xCCCCCC")]
	public class game extends Sprite implements IStartup {
		public static var flashVars			:Object;
		public static var fixPath			:String;
		
		public static var sccClientController	:SCClientController = new SCClientController();
		private var _game						:GameController;
		
		public function game() {
			_game				 = new GameController();
			
			if (stage) 
				initApplication();
			else 
				addEventListener(Event.ADDED_TO_STAGE, initApplication);
		}
		
		private function initApplication(event:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initApplication);
			if (!ExternalInterface.available)
				ready();
		}
		
		public function callAdminPanel():void {
			
		}
		
		public function ready(flashVars:Object=null):void
		{
			game.flashVars = flashVars;
			
			if (!flashVars) {
				game.flashVars = {};
				game.flashVars.noContainerMode = true
				game.flashVars.levels = [];
				loadLevel();
			}
		}
		
		private function loadLevel():void
		{
			start();
		}
		
		public function setPause(value:Boolean):void {
			
		}
		
		public function start(flashVars:Object=null):void {
			addChild(_game);
			if (!ExternalInterface.available) {
				game.flashVars.noContainerMode = false;
			} else {
				game.flashVars.noContainerMode = true;
			}
			
			fixPath = "/tunes/"; // - префикс для запуска локально 
			  if (game.flashVars.noContainerMode)
			  {
				   fixPath = "/game/tunes/"; // - префикс для запуска с контейнера 
			  }
			var level:int = 1
			_game.startGame(level);
		}
		
	}
}