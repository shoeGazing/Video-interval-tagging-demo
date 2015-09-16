package events {

	import flash.events.*;

	public class IconClickEvent extends Event {

		public var _value: int;
		public var pause: Boolean;
		public static const ICON: String = "IconClickEvent.ICON";

		public function IconClickEvent(type: String, value: int, pause: Boolean = false, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			_value = value;
			this.pause = pause;
		}

		public function get value(): int {
			return _value;
		}

	}

}