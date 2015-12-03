package screens 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import utils.Controller;
	import flash.events.KeyboardEvent;
	import screens.ShopScreen;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class IntroScreen extends Screen 
	{
		private var title:TextField;
		private var start:TextField;
		
		private var _shopScreen:ShopScreen;	
	
		
		public var btn_shop:MovieClip;
		
		public static const START_GAME:String = "start game";		
		public static const SHOP_MENU:String = "shop menu";
		
		
		
		public function IntroScreen() 
		{			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
						
			title = new TextField();
			title.embedFonts = true;
			title.text = "Anime Pong";
			title.autoSize = TextFieldAutoSize.CENTER;			
			title.setTextFormat(textFormat);		
			
			title.x = stage.stageWidth / 2 - title.textWidth /2;
			title.y = stage.stageHeight / 2 - title.textHeight /2;
			
			title.mouseEnabled = false;
			
			addChild(title);
			
			
			
			start = new TextField();
			start.embedFonts = true;
			start.text = "press space to start";
			start.autoSize = TextFieldAutoSize.CENTER;
			start.setTextFormat(subFormat)
			
			start.x = stage.stageWidth / 2 - start.textWidth / 2;
			start.y = stage.stageHeight / 2 + 20;
			
			addChild(start);

			
			btn_shop = new MovieClip();
			btn_shop.graphics.beginFill(0xFFCC00);
			btn_shop.graphics.drawRect(0, 0, 120, 120);
			btn_shop.graphics.endFill();
			
			btn_shop.x = 300;
			btn_shop.y = 40;
			
			
			
			
			
			addChild(btn_shop);
			
			start.addEventListener(Event.ENTER_FRAME, loop);
			
			
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			btn_shop.addEventListener(MouseEvent.CLICK, btn_shop_click);	
			
			
			
		}
		
		private function btn_shop_click(e:MouseEvent):void
		{
			start.removeEventListener(Event.ENTER_FRAME, loop);			
			//btn_singlePlayer.removeEventListener(MouseEvent.CLICK, btn_single_click);
			btn_shop.removeEventListener(MouseEvent.CLICK, btn_shop_click);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			dispatchEvent(new Event(SHOP_MENU));
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == 32) 
			{
				start.removeEventListener(Event.ENTER_FRAME, loop);		
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				dispatchEvent(new Event(START_GAME));
				
			}
			
			

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