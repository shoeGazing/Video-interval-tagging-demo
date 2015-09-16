package events {

	import flash.events.Event;

	public class PlayerBarEvent extends Event {

		public var time: Number;
		public var pause: Boolean;
		public static const SEEK: String = "PlayerBarEvent.SEEK";
		public static const THUMB: String = "PlayerBarEvent.THUMB";
		public static const THUMBPRESS: String = "PlayerBarEvent.THUMBPRESS";
		public static const THUMBRELEASE: String = "PlayerBarEvent.THUMBRELEASE";
		//public static const TAG:String = "PlayerBarEvent.TAG";

		public function PlayerBarEvent(type: String, time: Number, pause: Boolean = false, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			this.time = time;
			this.pause = pause;
		}

	}

}