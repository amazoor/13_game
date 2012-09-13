package view {
	import events.GameEvents;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.tlf_internal;
	
	import model.Screen;

	public class GameOverScreen extends AbstractScreen {
		private var _screen:ClipGameOverScreen;
		
		public function GameOverScreen(level:uint, points:uint, rules:uint) {
			_screen = new ClipGameOverScreen();
			_screen.eLevel.text = level.toString();
			_screen.ePoints.text = points.toString();
			_screen.eRules.text = rules.toString();
			_screen.eCont.addEventListener(MouseEvent.CLICK, onStartGame);
			addChild(_screen);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void {
			_screen.x = stage.stageWidth / 2 - _screen.width / 2;
			_screen.y = stage.stageHeight/ 2 - _screen.height/ 2;
		}
		
		protected function onStartGame(event:MouseEvent):void {
			_screen.eCont.removeEventListener(MouseEvent.CLICK, onStartGame);
			var e:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			e.screen = Screen.PLAY_SCREEN;
			dispatchEvent(e);
		}
	}
}