package ui.labels {

	import flash.display.Sprite;
	import fl.controls.Button;
	import flash.events.*;
	import events.TagNavigationEvent;

	public class Bubble extends Sprite {

		private var _width: Number;
		private var _bubbleCollection: Array;

		public function Bubble(width: Number): void {
			_width = width;
			_bubbleCollection = new Array();
			for (var i: int = 0; i < 5; i++) {
				_bubbleCollection[i] = new Button();
				_bubbleCollection[i].x = _width / 5 * i;
				_bubbleCollection[i].y = 2;
				_bubbleCollection[i].width = _width / 5;
				_bubbleCollection[i].height = 40;
				_bubbleCollection[i].addEventListener(MouseEvent.CLICK, bubble_Click);
			}
		}


		/*public function addBubbleAt(index:uint):void {
		
			addChild(_bubble);
           _bubble.x = _width/5 * index;
		   _bubbleCollection[index] = _bubble;
        }*/

		public function get bubbleCollection(): Array {
			return _bubbleCollection;
		}

		private function bubble_Click(e: MouseEvent): void {
			var button: Button = e.target as Button;
			var index: int = _bubbleCollection.indexOf(button);
			dispatchEvent(new TagNavigationEvent(TagNavigationEvent.NAVIGATE, index));
		}


	}

}