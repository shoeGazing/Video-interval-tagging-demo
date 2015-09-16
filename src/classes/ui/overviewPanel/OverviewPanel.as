package ui.overviewPanel {

	import fl.containers.ScrollPane;
	import flash.display.*;
	//import fl.events.*;
	import fl.controls.*;
	//import flash.events.*;

	// import ui.overviewPanel.TagBox;
	//import events.IconClickEvent;
	// import events.PanelUpdateEvent;

	public class OverviewPanel extends Sprite {

		private var _overviewPanel: ScrollPane;
		private var _container: MovieClip;
		//private var _tagBox: TagBox;
		//	private var _scrollBar: UIScrollBar;

		public function OverviewPanel(): void {
			_container = new MovieClip();
			_overviewPanel = new ScrollPane();
			//	_tagBox = new TagBox();
			//	_overviewPanel.addChild(_tagBox);
			//	_tagBox.x = 0;
			//	_tagBox.y = 420; 

			/*	_scrollBar = new UIScrollBar();
			_scrollBar.x = 360;
		    _scrollBar.height = 499;
			
            _scrollBar.setScrollProperties(499, 0, 600, 499);
            _scrollBar.addEventListener(ScrollEvent.SCROLL, onVerticalScrollHandler);*/

			_overviewPanel.scrollDrag = true;
			_overviewPanel.setSize(360, 420); //579
			_overviewPanel.source = _container;
			//_overviewPanel.addEventListener(ScrollEvent.SCROLL, scrollHandler);
			//_overviewPanel.addEventListener(ScrollEvent.SCROLL, scrollListener);
			addChild(_overviewPanel);
			//addChild(_scrollBar);
			/*_tagBox.addEventListener(IconClickEvent.ICON, 
				function asdf(e:IconClickEvent):void {
					dispatchEvent(new IconClickEvent(IconClickEvent.ICON, e.value));
				});
			_tagBox.addEventListener(PanelUpdateEvent.UPDATE, 
				function fdsa(e:PanelUpdateEvent):void {
					dispatchEvent(new PanelUpdateEvent(PanelUpdateEvent.UPDATE));
				});	*/
		}
		public function get overviewPanel(): ScrollPane {
			return _overviewPanel;
		}
		public function get container(): MovieClip {
			return _container;
		}

		/*	private function scrollHandler(event: ScrollEvent): void {
			var mySP: ScrollPane = event.currentTarget as ScrollPane;
			trace("scrolling");
			trace("\t" + "direction:", event.direction);
			trace("\t" + "position:", event.position);
			trace("\t" + "horizontalScrollPosition:", mySP.horizontalScrollPosition, "of", mySP.maxHorizontalScrollPosition);
			trace("\t" + "verticalScrollPosition:", mySP.verticalScrollPosition, "of", mySP.maxVerticalScrollPosition);
		}*/ //for test

		/*	public function get tagBox():TagBox{
			return _tagBox;
		}*/

		/* private function onVerticalScrollHandler(event:ScrollEvent):void{
            _overviewPanel.y = -event.position + _scrollBar.y + 5;
		}
		
		private function scrollListener(event:ScrollEvent):void{
			trace(_overviewPanel.verticalScrollPosition);
		}*/
	}
}