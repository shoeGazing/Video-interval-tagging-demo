package ui.overviewPanel {

	import flash.display.*;
	import fl.controls.*;
	import flash.text.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import events.IconClickEvent;
	import events.PanelUpdateEvent;

	public class TagBox extends Sprite {

		private var boxFrame: Sprite;
		private var tagLabel: TextField;
		private var notesLabel: TextField;
		private var cancelButton: Button;
		private var okButton: Button;
		private var tagText: TextInput;
		private var notesText: TextArea;
		private var iconCollection: Array;
		private var tf: TextFormat;

		private static const LABELXPOS = 10;

		public function TagBox(): void {

			boxFrame = new Sprite();
			addChild(boxFrame);
			boxFrame.graphics.lineStyle(2, 0x777777);
			boxFrame.graphics.beginFill(0xffffff);
			boxFrame.graphics.drawRect(0, 0, 360, 280);
			boxFrame.graphics.endFill();

			tagLabel = new TextField();
			tagLabel.text = "Tag";
			tagLabel.x = LABELXPOS;
			tagLabel.y = 30;
			tagLabel.textColor = 0x000000;
			tagLabel.mouseEnabled = false;
			tf = new TextFormat();
			tf.font = "Verdana";
			tf.size = 15;
			// _tf.align = TextFormatAlign.CENTER;
			tagLabel.setTextFormat(tf);
			//_timeLabel.embedFonts = true; don't know why this does not work for scrollpane font!!??
			tagLabel.antiAliasType = AntiAliasType.ADVANCED;
			addChild(tagLabel);

			tagText = new TextInput();
			tagText.x = LABELXPOS + 40;
			tagText.y = 30;
			tagText.width = 100;
			tagText.setStyle("textFormat", tf);
			addChild(tagText);

			iconCollection = new Array();
			for (var i: int = 1; i < 6; i++) {
				iconCollection[i] = new Loader();
				iconCollection[i].load(new URLRequest("uiimage/icon" + i + ".png"));
				iconCollection[i].x = tagText.x + tagText.width + 20 + 32 * (i - 1); //modify the icon size
				iconCollection[i].y = 27; //icon size
				iconCollection[i].addEventListener(MouseEvent.CLICK, icon_Click);
				addChild(iconCollection[i]);
			}

			notesLabel = new TextField();
			notesLabel.text = "Notes";
			notesLabel.x = LABELXPOS;
			notesLabel.y = 70;
			notesLabel.textColor = 0x000000;
			notesLabel.mouseEnabled = false;
			notesLabel.setTextFormat(tf);
			notesLabel.antiAliasType = AntiAliasType.ADVANCED;
			addChild(notesLabel);

			notesText = new TextArea();
			addChild(notesText);
			notesText.x = LABELXPOS + 55;
			notesText.y = 90;
			notesText.setSize(265, 150);
			notesText.setStyle("textFormat", tf);
			//how to show the frame, and multiline input//remember to drag component to library

			cancelButton = new Button();
			cancelButton.x = LABELXPOS;
			cancelButton.y = notesText.y + notesText.height + 10;
			cancelButton.label = "cancel";
			addChild(cancelButton);


			okButton = new Button();
			okButton.x = LABELXPOS + 220;
			okButton.y = notesText.y + notesText.height + 10;
			okButton.label = "OK";
			okButton.addEventListener(MouseEvent.CLICK, button_Click);
			addChild(okButton);

		}

		public function get _tagText(): TextInput {
			return tagText;
		}

		public function get _notesText(): TextArea {
			return notesText;
		}

		private function icon_Click(e: MouseEvent): void {
			var icon: Loader = e.target as Loader;
			var index: int = iconCollection.indexOf(icon);
			dispatchEvent(new IconClickEvent(IconClickEvent.ICON, index));
		}

		private function button_Click(e: MouseEvent): void {
			dispatchEvent(new PanelUpdateEvent(PanelUpdateEvent.UPDATE));
		}

	}

}