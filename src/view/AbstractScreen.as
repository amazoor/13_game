package view
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	
	public class AbstractScreen extends Sprite
	{
		public function AbstractScreen()
		{
			drawBG();	
		}
		
		private function drawBG():void
		{
			var image:Image = new Image("assets/bg/bg.jpg");
			addChild(image);
		}
	}
}