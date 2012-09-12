package view
{
	import events.GameEvents;
	
	import flash.events.MouseEvent;
	
	import flashx.textLayout.tlf_internal;
	
	import model.Screen;

	public class GameOverScreen extends AbstractScreen
	{
		
		public function GameOverScreen(level:uint, points:uint, rules:uint)
		{
			var levelLabel:Label = new Label(level.toString());
			var pointsLabel:Label = new Label(points.toString());
			var rulesLabel:Label = new Label(rules.toString());
			levelLabel.font = "MPS";
			pointsLabel.font = "MPS";
			rulesLabel.font = "MPS";
			levelLabel.x = 290; levelLabel.y = 145;
			pointsLabel.x = 275; pointsLabel.y = 264;
			rulesLabel.x = 350; rulesLabel.y = 205;
			
			rulesLabel.color = levelLabel.color = pointsLabel.color = 0x006837;
			
			var title:Image = new Image("assets/title/title.png");
			addChild(title);
			
			var resPanel:Image = new Image("assets/title/rezult_panel.png");
			addChild(resPanel);
			
			var next:Button = new Button();
			next.upStateImage = "assets/Button/button_cont_normal.png";
			next.overStateImage = "assets/Button/button_cont_over.png";
			next.downStateImage = "assets/Button/button_cont_down.png";
			next.addEventListener(MouseEvent.CLICK, onStartGame);
			addChild(next);
			
			var resText:Image = new Image("assets/title/rezult_text.png");
			addChild(resText);
			
			addChild(levelLabel);
			addChild(pointsLabel);
			addChild(rulesLabel);
			
			title.x = 149; title.y = 26;
			resPanel.x = 133; resPanel.y = 126;
			next.x = 240; next.y = 390;
			resText.x = 170; resText.y = 155;
		}
		
		protected function onStartGame(event:MouseEvent):void
		{
			var b:Button = event.currentTarget as Button;
			b.removeEventListener(MouseEvent.CLICK, onStartGame);
			var e:GameEvents = new GameEvents(GameEvents.SHOW_SCREEN);
			e.screen = Screen.PLAY_SCREEN;
			dispatchEvent(e);
		}
	}
}