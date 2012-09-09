package view {
	import events.GameEvents;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import model.Screen;
	
	public class TitleScreen extends AbstractScreen {
		private var _howToPlatButton	:Button;
		private var _platButton			:Button;
		private var _title				:Image;
		private var _titleText			:Image;
		private var _titleImage			:Image;
		
		public function TitleScreen() {
			super();
			_howToPlatButton = new Button();
			_howToPlatButton.upStateImage	= "assets/Button/button_blue_normal.png";
			_howToPlatButton.overStateImage = "assets/Button/button_blue_over.png";
			_howToPlatButton.downStateImage	= "assets/Button/button_blue_down.png";
			
			_platButton = new Button();
			_platButton.upStateImage	= "assets/Button/button_play_normal.png";
			_platButton.overStateImage = "assets/Button/button_play_over.png";
			_platButton.downStateImage	= "assets/Button/button_play_down.png";
			
			_title = new Image("assets/title/title.png");
			_title.x = 145;
			_title.y = 30;
			
			_titleText = new Image("assets/title/title_text.png");
			_titleText.x = 90;
			_titleText.y = 80;
			
			_titleImage = new Image("assets/title/title_pict.png");
			_titleImage.x = 104;
			_titleImage.y = 104;
			
			_howToPlatButton.x = 100;
			_howToPlatButton.y = 390;
			
			_platButton.x = 360;
			_platButton.y = 390;
			
			addChild(_howToPlatButton);
			addChild(_platButton);
			addChild(_title);
			addChild(_titleText);
			addChild(_titleImage);
			
			_platButton.addEventListener(MouseEvent.CLICK, onPlayGameMouseClick);
			_howToPlatButton.addEventListener(MouseEvent.CLICK, onHowToPlayGameMouseClick);
		}
		
		protected function onHowToPlayGameMouseClick(event:MouseEvent):void {
			_platButton.removeEventListener(MouseEvent.CLICK, onPlayGameMouseClick);
			_howToPlatButton.removeEventListener(MouseEvent.CLICK, onHowToPlayGameMouseClick);
			
			var evt:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			evt.screen = Screen.HOW_TO_PLAY_SCREEN;
			dispatchEvent(evt);
		}
		
		protected function onPlayGameMouseClick(event:MouseEvent):void {
			_platButton.removeEventListener(MouseEvent.CLICK, onPlayGameMouseClick);
			_howToPlatButton.removeEventListener(MouseEvent.CLICK, onHowToPlayGameMouseClick);
			
			var evt:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			evt.screen = Screen.LEVEL_CHOOSE__SCREEN;
			dispatchEvent(evt);
		}
	}
}