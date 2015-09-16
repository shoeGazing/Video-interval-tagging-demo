package ui.overviewPanel {

	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import ui.player.PlayerBar;
	import fl.controls.TextArea;

	public class PanelGrid extends Sprite {

		private var _startTime: Number;
		private var _endTime: Number;
		private var _tf: TextFormat;
		private var _tagText: String;
		private var _notesText: String;

		private var _timeLabel: TextField;
		private var _tagLabel: TextField;
		private var _notesLabel: TextArea;
		private var _icon: Loader;

		public function PanelGrid(startime: Number, endtime: Number, tagText: String, notesText: String, index: int): void {
			_startTime = startime;
			_endTime = endtime;
			_tagText = tagText;
			_notesText = notesText;

			_timeLabel = new TextField();
			_timeLabel.x = 0;
			_timeLabel.y = 0;
			_timeLabel.width = 250;
			_timeLabel.text = PlayerBar.timeInSecondsToTimeString(_startTime) + "--" + PlayerBar.timeInSecondsToTimeString(_endTime); //class instead of instance
			_timeLabel.textColor = 0x000000;
			_timeLabel.mouseEnabled = false;
			_tf = new TextFormat();
			_tf.font = "Verdana";
			_tf.size = 20;
			// _tf.align = TextFormatAlign.CENTER;
			_timeLabel.setTextFormat(_tf);
			//_timeLabel.embedFonts = true; don't know why this does not work for scrollpane font!!??
			_timeLabel.antiAliasType = AntiAliasType.ADVANCED;
			addChild(_timeLabel);

			_icon = new Loader();
			_icon.load(new URLRequest("uiimage/icon" + index + ".png"));
			_icon.x = 300;
			_icon.y = 0;
			addChild(_icon);

			_tagLabel = new TextField();
			_tagLabel.x = 0;
			_tagLabel.y = 50;
			_tagLabel.width = 150;
			_tagLabel.height = 50;
			_tagLabel.text = _tagText;
			_tagLabel.textColor = 0x000000;
			_tagLabel.mouseEnabled = false;
			_tagLabel.setTextFormat(_tf);
			//_tagLabel.embedFonts = true;
			_tagLabel.antiAliasType = AntiAliasType.ADVANCED;
			//	_tagLabel.addEventListener(MouseEvent.CLICK, mouseDownScroll);//does not work because it's within scrollpane
			addChild(_tagLabel);

			_notesLabel = new TextArea();
			_notesLabel.x = 152;
			_notesLabel.y = 50;
			_notesLabel.width = 180;
			_notesLabel.height = 100;
			//_notesLabel.multiline = true;
			//_notesLabel.wordWrap = true;
			//_tagLabel.background = true;
			//_notesLabel.border = true;
			_notesLabel.text = _notesText;
			//_notesLabel.textColor = 0x000000;
			_notesLabel.setStyle("textFormat", _tf);
			//_notesLabel.mouseEnabled = false;
			//_notesLabel.setTextFormat(_tf);
			//_tagLabel.embedFonts = true;
			//_notesLabel.antiAliasType = AntiAliasType.ADVANCED;
			//	_tagLabel.addEventListener(MouseEvent.CLICK, mouseDownScroll);//does not work because it's within scrollpane
			addChild(_notesLabel);

		}
		/*private function mouseDownScroll(event:MouseEvent):void 
        { 
            _tagLabel.scrollV++; 
        } */

		public function get notesLabel(): TextArea {
			return _notesLabel;
		}


	}
}