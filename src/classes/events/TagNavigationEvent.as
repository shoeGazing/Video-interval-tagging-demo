package events {

	import flash.events.*;

	public class TagNavigationEvent extends Event {
		public var _value: int;
		public var pause: Boolean;
		public static const NAVIGATE: String = "TagNavigationEvent.NAVIGATE";

		public function TagNavigationEvent(type: String, value: int, pause: Boolean = false, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			_value = value;
			this.pause = pause;
		}

		public function get value(): int {
			return _value;
		}

	}

}