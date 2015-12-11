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

	
	
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class IntroScreen extends Screen 
	{
		private var title:TextField;
		private var start:TextField;
		
		private var _shopScreen:ShopScreen;	
		
		
		
		private var _quit:MovieClip = new quitArt;
		private var _shop:MovieClip = new optionsArt2;
		
		
		public static const START_GAME:String = "start game";		
		public static const BUTTON_CLICK:String = "button click";		
		public static const SHOP_MENU:String = "shop menu";
		public static const MENU_MUSIC:String = "menu music";
		public static const BUTTON_HOVER:String = "button hover";

		public function IntroScreen() 
		{			
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			dispatchEvent(new Event(MENU_MUSIC));
			
			
						
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
	
			_shop.x = 590;
			_shop.y = 10;

			this.addChild(_shop);

			_quit.x = 750;
			_quit.y = 10;
			
			this.addChild(_quit);
			

			start.addEventListener(Event.ENTER_FRAME, loop);
			
			
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				
			_quit.addEventListener(MouseEvent.CLICK, btn_quit_click);
			_quit.addEventListener(MouseEvent.MOUSE_OVER, btn_quit_over);
			_quit.addEventListener(MouseEvent.MOUSE_OUT, btn_quit_out);
			
			_shop.addEventListener(MouseEvent.CLICK, btn_shop_click);
			_shop.addEventListener(MouseEvent.MOUSE_OVER, btn_shp_over);
			_shop.addEventListener(MouseEvent.MOUSE_OUT, btn_shp_out);	
		}		
		private function btn_quit_over(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_HOVER));
			_quit.alpha = 0.8;
			_quit.buttonMode = true;
			trace("over");
			
			_quit.scaleX = 1.13;
			_quit.scaleY = 1.13;
			
			
		}
		private function btn_quit_out(e:MouseEvent):void
		{
			
			_quit.alpha = 1;
			_quit.buttonMode = false;
			trace("out");
			_quit.scaleX = 1;
			_quit.scaleY = 1;

		}
		private function btn_shp_over(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_HOVER));
			_shop.alpha = 0.8;
			_shop.buttonMode = true;
			trace("over");
			_shop.scaleX = 1.13;
			_shop.scaleY = 1.13;	
			
		}
		private function btn_shp_out(e:MouseEvent):void
		{	
			_shop.alpha = 1;
			_shop.buttonMode = false;
			trace("out");
			_shop.scaleX = 1;
			_shop.scaleY = 1;

		}
		
		public function btn_shop_click(e:MouseEvent):void
		{
			start.removeEventListener(Event.ENTER_FRAME, loop);			
			
			_shop.removeEventListener(MouseEvent.CLICK, btn_shop_click);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			dispatchEvent(new Event(BUTTON_CLICK));
			dispatchEvent(new Event(SHOP_MENU));
		}
		public function btn_quit_click(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_CLICK));
			start.removeEventListener(Event.ENTER_FRAME, loop);			
			
			_shop.removeEventListener(MouseEvent.CLICK, btn_shop_click);
			_quit.removeEventListener(MouseEvent.CLICK, btn_quit_click);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			fscommand("quit");
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