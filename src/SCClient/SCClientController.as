package SCClient
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ArtDon
	 */
	public class SCClientController extends MovieClip
	{
		private static var _tasks:int = 0;
		
		
		private static var mem:Object = { };
		
		
		public function SCClientController()
		{
		
		}
		
		public function scc_trace(e:*):void {
			if (game.flashVars.noContainerMode)
			trace(e);
			return;
			(Object(root) as Object).parent.scc_trace(e);
		}
		
		
		
		public function playSound(urlCore:String):void {
			if (game.flashVars.noContainerMode){
				SCClientSound.playSound(urlCore);
			return;
			}
				
			(Object(root) as Object).parent.playSound(urlCore);
		}
		
		public function stopSound(urlCore:String):void {
			if (game.flashVars.noContainerMode){
				SCClientSound.stopSound(urlCore);
			return;
			}
				
			(Object(root) as Object).parent.stopSound(urlCore);
		}
		
		public function setAsButton(mc:MovieClip, urlCore:String):void {				
			if (game.flashVars.noContainerMode){
			SCClientSkin.setAsButton(mc, urlCore);
			return;
			}
			
			(Object(root) as Object).parent.setAsButton(mc, urlCore);
		}
		public function setAsMovieClip(mc:MovieClip, urlCore:String, width:int = 0, height:int = 0):void
		{

			if (game.flashVars.noContainerMode){
				SCClientSkin.setAsMovieClip(mc, urlCore);
			return;
			}
				
			(Object(root) as Object).parent.setAsMovieClip(mc, urlCore, width, height);
		}
		
		
		public function addNewMedia(fileCore:String):void
		{
			if (game.flashVars.noContainerMode)return
			(Object(root) as Object).parent.addNewMedia(fileCore, false); // Пока не работает 
		}
		
		public function saveAsNewTuneFile(data:String):void
		{
			if (game.flashVars.noContainerMode)return
			(Object(root) as Object).parent.santune(data); // Пока не работает
		}
		
		public function saveScore(level:int, score:int, other:Object = null):void
		{
			
			
			if (game.flashVars.noContainerMode)
				
				return
			(Object(root) as Object).parent.savescore(level, score, other);
		}
		
		public function showEndScreen(score:int, other:Object = null):void
		{
			if (game.flashVars.noContainerMode)return
			(Object(root) as Object).parent.showEndScreen(score, other);
		}
		
		public function showMainMenu():void
		{
			if (game.flashVars.noContainerMode)return
			(Object(root) as Object).parent.restart();
		}
		
		static public function get tasks():int 
		{
		 return 0;
		}
		
	}

}
