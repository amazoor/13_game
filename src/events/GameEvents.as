package events {
	import flash.events.Event;
	
	public class GameEvents extends Event {
		public static const SHOW_SCREEN:String = "showScreen";
		public static const YES_CLICK:String = "yesClick";
		public static const NO_CLICK:String = "noClick";
		public static const NEXT_CLICK:String = "nextClick";
		public static const PLAY_SOUND:String = "playSound";
		
		public var soundName:String;
		
		public var screen:String;
		
		public var level	:uint;
		public var rules	:uint;
		public var points	:uint;
		
		public function GameEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}