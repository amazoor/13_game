package {
	import SCClient.SCClientController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import interfaces.IStartup;
	
	import view.GameController;
	
	[SWF(width="640", height="480", backgroundColor="0xCCCCCC")]
	public class game extends Sprite implements IStartup {
		[Embed(source="../assets/font/MyriadPro-Regular.otf",	fontName = "MPR",	mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")] private var MyriadProRegular:Class;
		[Embed(source="../assets/font/MyriadPro-Semibold.otf", fontName = "MPS", mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")] private var MyriadProSemibold:Class;
		
		public static var flashVars			:Object;
		public static var fixPath			:String;
		
		private var _sccClientController	:SCClientController;
		private var _game					:GameController;
		
		public function game() {
			_game				 = new GameController();
			_sccClientController = new SCClientController();
			
			if (stage) 
				initApplication();
			else 
				addEventListener(Event.ADDED_TO_STAGE, initApplication);
		}
		
		private function initApplication(event:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initApplication);
			ready();
		}
		
		public function callAdminPanel():void {
			
		}
		
		public function ready(flashVars:Object=null):void
		{
			game.flashVars = flashVars;
			
			if (!flashVars) {
				game.flashVars = { };
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
		
		public function start(flashVars:Object=null):void
		{
			if (flashVars.level && flashVars.level > 0) 
				var level:uint = flashVars.level;
			else
				level = 1;
			addChild(_game);
			_game.startGame(level);
		}
		
	}
}