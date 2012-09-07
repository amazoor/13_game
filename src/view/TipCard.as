package view
{
	import events.ImageEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	
	import model.Rules;
	
	public class TipCard extends Sprite
	{
		private var card:Image;
		private var label:Label;
		public function TipCard(lastRule:Dictionary)
		{
			
			var next:Button = new Button();
			next.upStateImage = "assets/Button/smallbutton_next_normal.png";
			next.overStateImage = "assets/Button/smallbutton_next_over.png";
			next.downStateImage = "assets/Button/smallbutton_next_down.png";
			label = new Label();
			label.text = "asdasf";
			
			label.font = "MPS";
			card = new Image("assets/more/paneltext_lastchance.png");
			addChild(card);
			next.x = 22;
			next.y = 110;
			addChild(next);			
			addChild(label);
			next.addEventListener(MouseEvent.CLICK, onNextButtonClick);
		}
		
		protected function onNextButtonClick(event:MouseEvent):void {
			card.source = "assets/more/paneltext_rulewas.png";
		}
	}
}