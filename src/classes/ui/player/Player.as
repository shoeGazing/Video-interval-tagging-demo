package ui.player {

	import flash.display.*;
	import flash.events.*;
	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;

	import ui.player.PlayerBar;
	import data.Video;
	import events.EventConstants;
	import events.PlayerBarEvent;
	//import ui.labels.Bubble;
	//import events.TagNavigationEvent;
	import ui.overviewPanel.OverviewPanel;
	import ui.overviewPanel.PanelGrid;
	import events.IconClickEvent;
	import events.PanelUpdateEvent;
	import ui.overviewPanel.TagBox;

	public class Player extends Sprite {

		public static const PLAYER_WIDTH = 720;
		public static const PLAYER_HEIGHT = 405;
		public static const PLAYER_X = 0;
		public static const PLAYER_Y = 100;

		private var _playerOverlay: Sprite;
		private var _player: Object;
		private var _playerBar: PlayerBar;
		private var _video: Video;
		private var _lastPlayedTime: Number;
		//private var _lastTaggedTime:Number;
		//private var _bubble:Bubble;
		private var _overviewPanel: OverviewPanel;
		private var _tagBox: TagBox;
		//private var _taggedTime:Array;
		private var _currentIndex: int;
		private var startThumb: Number;
		private var endThumb: Number;
		private var intervalBarArray: Array;

		private var _nextYPos: int;
		private var _indicator: int;

		private var panelGridArray: Array;
		private var panelArrayIndicator: int;
		private var startTimeArray: Array;
		private var startIndicator: int;
		//private var endTimeArray: Array;
		private var endIndicator: int;
		private var intervalNavigateArray: Array;

		public function Player(video: Video): void {
			_video = video;
			createPlayer();
		}

		private function createPlayer(): void {
			_player = new FLVPlayback();
			_player.width = PLAYER_WIDTH;
			_player.height = PLAYER_HEIGHT;
			_player.x = PLAYER_X;
			_player.y = PLAYER_Y;
			_player.addEventListener(fl.video.VideoEvent.PLAYHEAD_UPDATE, playerUpdate);
			addChild(FLVPlayback(_player));
			_player.source = _video.filename;

			_playerOverlay = new Sprite();
			_playerOverlay.graphics.beginFill(0xff0000, 0);
			_playerOverlay.graphics.drawRect(_player.x, _player.y, _player.width, _player.height);
			_playerOverlay.graphics.endFill();
			_playerOverlay.addEventListener(MouseEvent.CLICK, playerClick);
			addChild(_playerOverlay);

			_playerBar = new PlayerBar(_video, PLAYER_WIDTH, _video.duration);
			_playerBar.x = _player.x;
			_playerBar.y = _player.y + _player.height + 10;
			_playerBar.addEventListener(EventConstants.PlayerBarEventPlay, playVideo);
			_playerBar.addEventListener(PlayerBarEvent.SEEK, playerBarSeek);
			_playerBar.addEventListener(PlayerBarEvent.THUMB, sliderBarSeek);
			_playerBar.addEventListener(PlayerBarEvent.THUMBPRESS, sliderBarPress);
			_playerBar.addEventListener(PlayerBarEvent.THUMBRELEASE, sliderBarRelease);
			//_playerBar.addEventListener(PlayerBarEvent.TAG, showTagBubble);
			_playerBar.playVideo();
			addChild(_playerBar);

			/*_bubble = new Bubble(PLAYER_WIDTH);
			_bubble.x = _player.x;
			_bubble.y = _player.y + _player.height;
			_bubble.addEventListener(TagNavigationEvent.NAVIGATE,bubble_Navigate);*/

			_overviewPanel = new OverviewPanel();
			_overviewPanel.x = _player.x + _player.width + 50;
			_overviewPanel.y = _player.y;
			//_overviewPanel.addEventListener(IconClickEvent.ICON, show_Iconbar);
			//_overviewPanel.addEventListener(PanelUpdateEvent.UPDATE, panelGrid);
			addChild(_overviewPanel);

			_tagBox = new TagBox();
			_tagBox.x = _player.x + _player.width + 50;
			_tagBox.y = _player.y + 425;
			_tagBox.addEventListener(IconClickEvent.ICON, show_Iconbar);
			_tagBox.addEventListener(PanelUpdateEvent.UPDATE, panelGrid);
			addChild(_tagBox);

			_lastPlayedTime = 0;
			_nextYPos = 10;
			_indicator = 1;

			panelGridArray = new Array();
			panelArrayIndicator = 0;
			startTimeArray = new Array();
			startIndicator = 0;
			//endTimeArray = new Array();
			endIndicator = 0;
			intervalBarArray = new Array();
			intervalNavigateArray = new Array();
			//_taggedTime = new Array();

		}

		private function playVideo(e: Event = null): void {
			if (_player.paused) {
				_playerBar.playVideo();
				_player.play();
			} else {
				_playerBar.pauseVideo();
				_player.pause();
			}
		}

		private function playerClick(e: Event = null): void {
			playVideo();
		}

		private function playerUpdate(e: Event = null): void {
			_playerBar.setPlayTime(_player.playheadTime);
		}

		private function playerBarSeek(e: PlayerBarEvent): void {
			_lastPlayedTime = e.time;
			_player.seek(e.time);
			if (e.pause) {
				_player.pause();
			}
		}

		/*	private function showTagBubble(e:PlayerBarEvent):void{			
		var _panelGrid: PanelGrid;
		_lastTaggedTime = e.time/_video.duration;
			//_playerBar.pauseVideo();
			//_player.pause();
	    if (_lastTaggedTime >= 0 && _lastTaggedTime < 1/5){
		_bubble.addChild(_bubble.bubbleCollection[0]);
		_bubble.bubbleCollection[0].label = _playerBar.textInput.text;
		_taggedTime[0] = e.time;
	}
	    else if (_lastTaggedTime >= 1/5 && _lastTaggedTime < 2/5){
		_bubble.addChild(_bubble.bubbleCollection[1]);
		_bubble.bubbleCollection[1].label = _playerBar.textInput.text;
		_taggedTime[1] = e.time;
	}	
	    else if (_lastTaggedTime >= 2/5 && _lastTaggedTime < 3/5){
		_bubble.addChild(_bubble.bubbleCollection[2]);
		_bubble.bubbleCollection[2].label = _playerBar.textInput.text;
		_taggedTime[2] = e.time;
	}
	    else if (_lastTaggedTime >= 3/5 && _lastTaggedTime < 4/5){
		_bubble.addChild(_bubble.bubbleCollection[3]);
		_bubble.bubbleCollection[3].label = _playerBar.textInput.text
		_taggedTime[3] = e.time;
	}
	   else{
		_bubble.addChild(_bubble.bubbleCollection[4]);
		_bubble.bubbleCollection[4].label = _playerBar.textInput.text;
		_taggedTime[4] = e.time;
	}
	
	   	addChild(_bubble);
	
		_playerBar._seekbar.graphics.beginFill(0x00ff00);
		_playerBar._seekbar.graphics.drawRect(e.time/_video.duration*PLAYER_WIDTH-10,0,20,8);//SEEKBAR_HEIGHT
	
	    _panelGrid = new PanelGrid(e.time,_playerBar.textInput.text);
	    _panelGrid.x = 10;
	    _panelGrid.y = _nextYPos;
	    _overviewPanel.container.addChild(_panelGrid);
		_overviewPanel.overviewPanel.update();
	    _nextYPos += _panelGrid.notesLabel.y+_panelGrid.notesLabel.height+20;
	}*/

		/*private function bubble_Navigate(e:TagNavigationEvent):void{
		_currentIndex = e.value;
		_player.seek(_taggedTime[_currentIndex]);
		
	}*/
		private function panelGrid(e: PanelUpdateEvent): void {

			panelGridArray[panelArrayIndicator] = new PanelGrid(startThumb / PLAYER_WIDTH * _video.duration, endThumb / PLAYER_WIDTH * _video.duration,
				_tagBox._tagText.text, _tagBox._notesText.text, _currentIndex);
			panelGridArray[panelArrayIndicator].x = 10;
			panelGridArray[panelArrayIndicator].y = _nextYPos;
			_overviewPanel.container.addChild(panelGridArray[panelArrayIndicator]);
			panelGridArray[panelArrayIndicator].addEventListener(MouseEvent.CLICK, panel_Click);
			_overviewPanel.overviewPanel.update();
			_nextYPos += panelGridArray[panelArrayIndicator].notesLabel.y + panelGridArray[panelArrayIndicator].notesLabel.height + 20;
			_tagBox._notesText.text = "";
			_tagBox._tagText.text = "";
			panelArrayIndicator++;
		}

		private function show_Iconbar(event: IconClickEvent): void {
			_currentIndex = event.value;

			if (_indicator < 2) {
				for (var i: int = 1; i < 6; i++) {
					_playerBar.addChild(_playerBar.barCollection[i]);
				}
			}
			for (var j: int = 1; j < 6; j++) {
				_playerBar.addChild(_playerBar.iconCollection[j]);
			}

			_playerBar.barCollection[_currentIndex].value = _player.playheadTime / _video.duration * 100;
			/*if (_indicator<2){
		_playerBar.removeChild(_playerBar._seekbar);
		_playerBar.removeChild(_playerBar._seekPoint);
		_playerBar.removeChild(_playerBar._toolbar);
		_playerBar.removeChild(_playerBar._timeLabel);
		_playerBar.removeChild(_playerBar._playButton);
		}*/

			//_playerBar._pointer.y = 9+27*(_currentIndex-1);
			//_playerBar.addChild(_playerBar._pointer);

			_indicator++;
		}

		private function sliderBarSeek(e: PlayerBarEvent): void {
			_lastPlayedTime = e.time;
			_player.seek(e.time);
			if (e.pause) {
				_player.pause();
			}
		}

		private function sliderBarPress(e: PlayerBarEvent): void {
			startThumb = e.time;
			startTimeArray[startIndicator] = startThumb / PLAYER_WIDTH * _video.duration;
			startIndicator++;
		}

		private function sliderBarRelease(e: PlayerBarEvent): void {
			endThumb = e.time;
			/*endTimeArray[endIndicator] = endThumb / PLAYER_WIDTH * _video.duration;
			endIndicator++;*/
			intervalBarArray[endIndicator] = new Sprite;
			intervalNavigateArray[endIndicator] = new Number;
			intervalNavigateArray[endIndicator] = _overviewPanel.overviewPanel.maxVerticalScrollPosition;
			if (_currentIndex == 1) {
				intervalBarArray[endIndicator].graphics.beginFill(0xF0F700);
			} else if (_currentIndex == 2) {
				intervalBarArray[endIndicator].graphics.beginFill(0xF05187);
			} else if (_currentIndex == 3) {
				intervalBarArray[endIndicator].graphics.beginFill(0xC20BF7);
			} else if (_currentIndex == 4) {
				intervalBarArray[endIndicator].graphics.beginFill(0x17EC46);
			} else {
				intervalBarArray[endIndicator].graphics.beginFill(0xD01038);
			}
			intervalBarArray[endIndicator].graphics.drawRect(_player.playheadTime / _video.duration * PLAYER_WIDTH, 50 + 27 * (_currentIndex - 1), startThumb - endThumb, 8);
			intervalBarArray[endIndicator].addEventListener(MouseEvent.CLICK, interval_Click);
			_playerBar.addChild(intervalBarArray[endIndicator]);
			endIndicator++;
		}

		private function panel_Click(e: MouseEvent): void {
			var panel: Sprite = e.target as Sprite;
			var index: int = panelGridArray.indexOf(panel);
			_player.seek(startTimeArray[index]);
		}

		private function interval_Click(e: MouseEvent): void {
			var interval: Sprite = e.target as Sprite;
			var index: int = intervalBarArray.indexOf(interval);
			_overviewPanel.overviewPanel.verticalScrollPosition = intervalNavigateArray[index] + 85 * index;
			_player.seek(startTimeArray[index]);
		}
	}

}