package ui {

	import flash.display.*;
	import flash.events.*;

	import data.Video;
	import ui.player.Player;

	public class VideoTag extends Sprite {
		private var _player: Player;
		private var videos: Array;

		public function VideoTag() {
			videos = new Array();
			videos.push(new Video(0, "videos/Google I-O.mp4", "Google IO", "Google IO", 616));
			//_player.player.load("videos/Google I-O.mp4");
			_player = new Player(videos[0]);
			//  _player.player.load(videos[0].filename);
			//_player.player.source = "videos/Google I-O.mp4"; will play automatically
			addChild(_player);
		}
	}

}