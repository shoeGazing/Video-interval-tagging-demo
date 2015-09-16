package ui.player {

	import events.EventConstants;
	import events.PlayerBarEvent;
	import data.Video;
	import flash.display.*;
	import flash.geom.Point;
	import flash.events.*;
	import fl.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	//import flash.text.TextField;
	//import flash.text.AntiAliasType;
	import flash.text.*;
	//import fl.controls.Button;
	//import fl.controls.TextInput;
	import fl.controls.Slider;

	public class PlayerBar extends Sprite {

		private static const SEEKBAR_HEIGHT = 8;
		private static const TOOLBAR_HEIGHT = 36;

		//	public static const PLAYERBAR_HEIGHT = SEEKBAR_HEIGHT + TOOLBAR_HEIGHT;

		private var _width: Number;

		private var playButton: Loader;
		private var pauseButton: Loader;
		private var seekPoint: Loader;
		//private var pointer:Loader;
		private var timeLabel: TextField;
		private var tf: TextFormat;

		private var toolbar: Sprite;
		private var seekbar: Sprite;
		private var _video: Video;
		private var currentPlayTime: Number;
		private var totalPlayTime: Number;
		//private var _tagButton:Button;
		//private var _textInput:TextInput;

		private var _barCollection: Array;
		private var _iconCollection: Array;

		private var _slider: Slider;

		public function PlayerBar(video: Video, width: Number, totalTime: Number): void {

			_video = video;
			totalPlayTime = totalTime;
			currentPlayTime = 0;
			_width = width;

			toolbar = new Sprite();
			toolbar.graphics.beginFill(0x1b1b1b1b);
			toolbar.graphics.drawRect(0, 4, width, TOOLBAR_HEIGHT);
			toolbar.graphics.endFill();
			addChild(toolbar);

			seekbar = new Sprite();
			seekbar.graphics.beginFill(0x777777);
			seekbar.graphics.drawRect(0, 0, width, SEEKBAR_HEIGHT);
			seekbar.graphics.endFill();
			seekbar.addEventListener(MouseEvent.CLICK, seekbar_click);
			addChild(seekbar);

			/*_barCollection = new Array();
			for (var i:int =1; i<6; i++){
				_barCollection[i] =  new Sprite();
				_barCollection[i].graphics.beginFill(0x777777);
				_barCollection[i].graphics.drawRect(0,27*(i-1),width, SEEKBAR_HEIGHT);
				_barCollection[i].graphics.endFill();
				//addChild(barCollection[i]);
			}*/
			_barCollection = new Array();
			for (var i: int = 1; i < 6; i++) {
				_barCollection[i] = new Slider;
				_barCollection[i].width = width;
				Sprite(_barCollection[i].getChildAt(0)).height = 8;
				_barCollection[i].snapInterval = 0;
				_barCollection[i].tickInterval = 100;
				_barCollection[i].maximum = 100;
				_barCollection[i].minimum = 0;
				_barCollection[i].value = 0;
				_barCollection[i].move(0, 27 * (i - 1) + 50);
				_barCollection[i].addEventListener(SliderEvent.CHANGE, thumb_Drag);
				_barCollection[i].addEventListener(SliderEvent.THUMB_PRESS, thumb_Press);
				_barCollection[i].addEventListener(SliderEvent.THUMB_RELEASE, thumb_Release);
				_barCollection[i].liveDragging = true;
				//_barCollection[i].removeChildAt(1);			
			}

			_iconCollection = new Array();
			for (var j: int = 1; j < 6; j++) {
				_iconCollection[j] = new Loader();
				_iconCollection[j].load(new URLRequest("uiimage/icon" + j + ".png"));
				_iconCollection[j].x = -48;
				_iconCollection[j].y = -15 + 30 * (j - 1) + 50;

				//addChild(iconCollection[j]);
			}

			/*pointer = new Loader();
			pointer.load(new URLRequest("uiimage/icon6.jpeg"));
			pointer.x = -7;*/


			playButton = new Loader();
			playButton.load(new URLRequest("uiimage/play.png"));
			playButton.y = SEEKBAR_HEIGHT;
			playButton.addEventListener(MouseEvent.CLICK, playButtonPressed);
			addChild(playButton);


			seekPoint = new Loader();
			seekPoint.load(new URLRequest("uiimage/seekPoint.png"));
			seekPoint.y = -8;
			seekPoint.mouseEnabled = false;
			addChild(seekPoint);

			timeLabel = new TextField();
			addChild(timeLabel);
			timeLabel.text = "00:00 / " + timeInSecondsToTimeString(totalTime);
			timeLabel.textColor = 0xffffff;
			timeLabel.width = 200;
			timeLabel.x = 50; // uiimage/play.png is 44 pixels wide
			timeLabel.y = SEEKBAR_HEIGHT + 8;
			timeLabel.mouseEnabled = false;
			tf = new TextFormat();
			tf.font = "Verdana";
			tf.size = 10;
			tf.align = TextFormatAlign.CENTER;
			timeLabel.defaultTextFormat = tf;
			timeLabel.embedFonts = true;
			timeLabel.antiAliasType = AntiAliasType.ADVANCED;

			/*_tagButton = new Button();
			_tagButton.label = "+Tag";
			_tagButton.width = 50;
			_tagButton.x = 665; // uiimage/play.png is 44 pixels wide
			_tagButton.y = SEEKBAR_HEIGHT+8;
			_tagButton.enabled = false;
			_tagButton.addEventListener(MouseEvent.CLICK, tagButton_click);
			addChild(_tagButton);*/

			/*_textInput = new TextInput();
			_textInput.width = 144;
			_textInput.x = _tagButton.x - _textInput.width-5;
			_textInput.y = SEEKBAR_HEIGHT+8;
			_textInput.addEventListener(Event.CHANGE, textEntered);
			addChild(_textInput);*/
			setPlayTime(0);
		}

		public function playVideo(): void {
			playButton.load(new URLRequest("uiimage/pause.png"));
		}

		public function pauseVideo(): void {
			playButton.load(new URLRequest("uiimage/play.png"));
		}

		public function setPlayTime(timeX: Number): void {
			currentPlayTime = timeX;
			timeLabel.text = timeInSecondsToTimeString(timeX) + " / " + timeInSecondsToTimeString(_video.duration);
			seekPoint.x = currentPlayTime / totalPlayTime * _width - seekPoint.width / 2;

			/*	seekbar.graphics.clear();
			seekbar.graphics.beginFill(0x777777);
			seekbar.graphics.drawRect(0, 0, _width, SEEKBAR_HEIGHT);
			seekbar.graphics.endFill();
			seekbar.graphics.beginFill(0xff0000);
			seekbar.graphics.drawRect(0, 0, currentPlayTime/_video.duration * _width, SEEKBAR_HEIGHT);*/
		}

		public function get iconCollection(): Array {
			return _iconCollection;
		}

		public function get barCollection(): Array {
			return _barCollection;
		}
		static public function timeInSecondsToTimeString(timeX: Number): String {
			var newMinutes: String = Math.floor(timeX / 60).toString();
			newMinutes = newMinutes.length == 1 ? "0" + newMinutes : newMinutes;
			var newSeconds: String = Math.floor(timeX % 60).toString();
			newSeconds = newSeconds.length == 1 ? "0" + newSeconds : newSeconds;
			return newMinutes + ":" + newSeconds;
		}

		/*public function get textInput():TextInput{
			return _textInput;
		}*/

		public function get _seekbar(): Sprite {
			return seekbar;
		}

		public function get _seekPoint(): Loader {
			return seekPoint;
		}

		public function get _playButton(): Loader {
			return playButton;
		}

		public function get _timeLabel(): TextField {
			return timeLabel;
		}

		public function get _toolbar(): Sprite {
			return toolbar;
		}

		/*public function get _pointer():Loader{
			return pointer;
		}*/

		private function playButtonPressed(e: Event): void {
			dispatchEvent(new Event(EventConstants.PlayerBarEventPlay));
		}

		private function seekbar_click(e: MouseEvent): void {
			dispatchEvent(new PlayerBarEvent(PlayerBarEvent.SEEK, e.localX / _width * totalPlayTime));
		}

		private function thumb_Drag(e: SliderEvent): void {
			dispatchEvent(new PlayerBarEvent(PlayerBarEvent.THUMB, e.value / 100 * totalPlayTime));
		}

		private function thumb_Press(e: SliderEvent): void {
			dispatchEvent(new PlayerBarEvent(PlayerBarEvent.THUMBPRESS, e.value / 100 * _width));
		}

		private function thumb_Release(e: SliderEvent): void {
			dispatchEvent(new PlayerBarEvent(PlayerBarEvent.THUMBRELEASE, e.value / 100 * _width));
		}


		/*private function tagButton_click(e:MouseEvent):void{
			dispatchEvent(new PlayerBarEvent(PlayerBarEvent.TAG,currentPlayTime));
		}*/

		/*private function textEntered(e:Event):void{
			if (_textInput.text != ""){
				_tagButton.enabled = true;
			}
			else{
			   _tagButton.enabled = false;	
			}
	}*/

	}
}