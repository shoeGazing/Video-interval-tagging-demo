package events {

	import flash.events.*;

	public class PanelUpdateEvent extends Event {

		public static const UPDATE: String = "PanelUpdateEvent.UPDATE";

		public function PanelUpdateEvent(type: String, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
		}

	}

}