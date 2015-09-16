package data {

	public class Video {

		public var id: int;
		public var filename: String;
		public var title: String;
		public var description: String;
		public var duration: Number;

		public function Video(id: int, filename: String, title: String, description: String, duration: Number) {
			this.id = id;
			this.filename = filename;
			this.title = title;
			this.description = description;
			this.duration = duration;
		}

	}

}