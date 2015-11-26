package screens 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import utils.Controller;
	import flash.events.KeyboardEvent;
	import actors.AI;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class IntroScreen extends Screen 
	{
		private var title:TextField;
		private var start:TextField;
		
		private var ai:AI;
		
		public var btn_singlePlayer:MovieClip;
		public var btn_TwoPlayer:MovieClip;
		
		public static const START_GAME:String = "start game";		
		
		public function IntroScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			ai = new AI();
			
			
						
			title = new TextField();
			title.embedFonts = true;
			title.text = "Pong";
			title.autoSize = TextFieldAutoSize.CENTER;			
			title.setTextFormat(textFormat);		
			
			title.x = stage.stageWidth / 2 - title.textWidth /2;
			title.y = stage.stageHeight / 2 - title.textHeight /2;
			
			title.mouseEnabled = false;
			
			addChild(title);
			
			
			
			start = new TextField();
			start.embedFonts = true;
			start.text = "Press space to start";
			start.autoSize = TextFieldAutoSize.CENTER;
			start.setTextFormat(subFormat)
			
			start.x = stage.stageWidth / 2 - start.textWidth / 2;
			start.y = stage.stageHeight / 2 + 20;
			
			addChild(start);
			
			//buttons
			
			// singleplayer option button.
			btn_singlePlayer = new MovieClip();
			btn_singlePlayer.graphics.beginFill(0x555443);
			btn_singlePlayer.graphics.drawRect(0, 0, 100, 130);
			btn_singlePlayer.graphics.endFill();
			addChild(btn_singlePlayer);
			
			// 2 player option button
			btn_TwoPlayer = new MovieClip();
			btn_TwoPlayer.graphics.beginFill(0xFFCC00);
			btn_TwoPlayer.graphics.drawRect(0, 0, 120, 120);
			btn_TwoPlayer.graphics.endFill();
			
			btn_TwoPlayer.x = 300;
			btn_TwoPlayer.y = 40;
			
			addChild(btn_TwoPlayer);
			
			start.addEventListener(Event.ENTER_FRAME, loop);
			
			
			//stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			btn_singlePlayer.addEventListener(MouseEvent.CLICK, btn_single_click);
			btn_TwoPlayer.addEventListener(MouseEvent.CLICK, btn_twoPlayer_click);
			
		
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == 32) {
				start.removeEventListener(Event.ENTER_FRAME, loop);		
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				dispatchEvent(new Event(START_GAME));
				
			}
		}
		private function btn_single_click(e:MouseEvent):void
		{
			ai.singleplayerOption = true;
			//start.removeEventListener(Event.ENTER_FRAME, loop);
			btn_singlePlayer.removeEventListener(MouseEvent.CLICK, btn_single_click);
			btn_TwoPlayer.removeEventListener(MouseEvent.CLICK, btn_twoPlayer_click);
			dispatchEvent(new Event(START_GAME));
		}
		private function btn_twoPlayer_click(e:MouseEvent):void
		{
			ai.singleplayerOption = false;
			//start.removeEventListener(Event.ENTER_FRAME, loop);
			btn_singlePlayer.removeEventListener(MouseEvent.CLICK, btn_single_click);
			btn_TwoPlayer.removeEventListener(MouseEvent.CLICK, btn_twoPlayer_click);
			dispatchEvent(new Event(START_GAME));
		}
		
		private var dir:Boolean = true;
		private function loop(e:Event):void 
		{
			if (dir)
			{
				start.alpha -= .1;	
				if (start.alpha <= 0) dir = false;
				
			}else
			{
				start.alpha += .1;	
				if (start.alpha >= 1) dir = true;
			}
			
			
		}
		
	}

}

/*



*/