package events {
	import flash.events.Event;
	
	public class GameEvents extends Event {
		public static const SHOW_SCREEN:String = "showScreen";
		public var screen:String;
		
		public function GameEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}