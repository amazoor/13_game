package {
	import SCClient.SCClientController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import interfaces.IStartup;
	
	import view.GameController;
	import view.TipCard;
	
	[SWF(width="640", height="480", backgroundColor="0xCCCCCC")]
	public class Main extends Sprite implements IStartup {
		[Embed(source="assets/font/MyriadPro-Regular.otf",	fontName = "MPR",	mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")] private var MyriadProRegular:Class;
		[Embed(source="assets/font/MyriadPro-Semibold.otf", fontName = "MPS", mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")] private var MyriadProSemibold:Class;
		
		public static var flashVars			:Object;
		public static var fixPath			:String;
		
		private var _sccClientController	:SCClientController;
		private var _game					:GameController;
		
		public function Main() {
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
			Main.flashVars = flashVars;
			
			if (!flashVars) {
				Main.flashVars = { };
				Main.flashVars.levels = [];
				loadLevel();
			}
		}
		
		private function loadLevel():void
		{
			start();
		}
		
		public function setPause(value:Boolean):void {
			_game.pause = true;
		}
		
		public function start(flashVars:Object=null):void
		{
			addChild(_game);
			_game.startGame();
		}
		
	}
}