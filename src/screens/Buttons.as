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
	 * @author Danilo Beumans MG1A
	 */
	public class  Buttons extends Screen
	{
		
		public var btn_singlePlayer:Sprite;
		public var btn_TwoPlayer:Sprite;
		
		private var ai:AI;
		
		
		public function Buttons() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init (e:Event):void
		{
			ai = new AI();
			
			// singleplayer option button.
			btn_singlePlayer = new Sprite();
			btn_singlePlayer.graphics.beginFill(0x555443);
			btn_singlePlayer.graphics.drawRect(0, 0, 100, 130);
			btn_singlePlayer.graphics.endFill();
			addChild(btn_singlePlayer);
			
			// 2 player option button
			btn_TwoPlayer = new Sprite();
			btn_TwoPlayer.graphics.beginFill(0xFFCC00);
			btn_TwoPlayer.graphics.drawRect(0, 0, 120, 120);
			btn_TwoPlayer.graphics.endFill();
			
			btn_TwoPlayer.x = 300;
			btn_TwoPlayer.y = 40;
			
			addChild(btn_TwoPlayer);
			
			btn_singlePlayer.addEventListener(MouseEvent.CLICK, on_btn_s_Click);
			btn_TwoPlayer.addEventListener(MouseEvent.CLICK, on_btn_m_Click);
			
		}
		
		private function on_btn_s_Click (m:MouseEvent):void
		{
			trace("click Singleplayer");
			ai.singleplayerOption = true;
		}
		private function on_btn_m_Click (m:MouseEvent):void
		{
			trace("click 2 player");
			ai.singleplayerOption = false;
		}
		
	}
	
	
	
}