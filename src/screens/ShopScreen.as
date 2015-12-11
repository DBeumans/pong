package screens 
{
	import actors.Paddle;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import mx.core.ButtonAsset;
	import screens.Screen;
	import screens.IntroScreen;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.net.URLLoader;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import screens.GameScreen;
	import Main;
	
	/**
	 * ...
	 * @author Danilo
	 */
	public class ShopScreen extends MovieClip
	{
		
		public static const BACK_BUTTON:String = "back button";	
		public static const BUTTON_CLICK:String = "button click";	
		public static const BUTTON_HOVER:String = "button hover";	
		public static const MENU_MUSIC:String = "menu music";
		public static const BACKGROUND_1_CHANGE:String = "background 1";
		public static const BACKGROUND_2_CHANGE:String = "background 2";
		public static const BACKGROUND_3_CHANGE:String = "background 3";
		
		private var _gameScreen:GameScreen;
		
		private var optionsArt:MovieClip = new OptionsArt;
		private var background1:MovieClip = new BackgroundBtnArt;
		private var background2:MovieClip = new backgroundBtnArt2;
		private var background3:MovieClip = new backgroundArt3;
		
		private var _paddle:Paddle;
		private var _main:Main;
		
		private var introScreen:IntroScreen;
		
		private var infoText:TextField;
		private var infoTextFormat:TextFormat = new TextFormat("../lib/starjedi/Starjedi.ttf", 20, 0xffffff);
		
		
		
		
		
		public function ShopScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			
			dispatchEvent(new Event(MENU_MUSIC));
			introScreen = new IntroScreen();
			
			infoText = new TextField();
			infoText.autoSize = TextFieldAutoSize.CENTER;
			infoText.defaultTextFormat = infoTextFormat;
			infoText.x = 450;
			infoText.y = 20;
			infoText.text = "How To Play :" + "\n" + "\n" + "Controls: " + "\n" +"Use the arrow keys ( arrow key up and arrow key down ) to go up and down." + "\n";
			
			addChild(infoText);
			
			/*btn_back = new MovieClip();
			btn_back.graphics.beginFill(0xFFCC00);
			btn_back.graphics.drawRect(0, 0, 120, 120);
			btn_back.graphics.endFill();
			
			btn_back.x = 600;
			btn_back.y = 40;*/
			
			background1.x = 100;
			background1.y = 400;
			addChild(background1);
			
			background2.x = 400;
			background2.y = 400;
			addChild(background2);
			
			background3.x = 700;
			background3.y = 400;
			addChild(background3);
			
			optionsArt.x = 50;
			optionsArt.y = 575;
			addChild(optionsArt);
				
			
			optionsArt.addEventListener(MouseEvent.CLICK, btn_back_click);
			optionsArt.addEventListener(MouseEvent.MOUSE_OVER, btn_back_over);
			optionsArt.addEventListener(MouseEvent.MOUSE_OUT, btn_back_out);
			
			background1.addEventListener(MouseEvent.CLICK, background1_click);
			background1.addEventListener(MouseEvent.MOUSE_OVER, background1_over);
			background1.addEventListener(MouseEvent.MOUSE_OUT, background1_out);
			
			background2.addEventListener(MouseEvent.CLICK, background2_click);
			background2.addEventListener(MouseEvent.MOUSE_OVER, background2_over);
			background2.addEventListener(MouseEvent.MOUSE_OUT, background2_out);
			
			background3.addEventListener(MouseEvent.CLICK, background3_click);
			background3.addEventListener(MouseEvent.MOUSE_OVER, background3_over);
			background3.addEventListener(MouseEvent.MOUSE_OUT, background3_out);
			
			
		}

		
		private function btn_back_click(e:MouseEvent):void
		{
			
			
			optionsArt.removeEventListener(MouseEvent.CLICK, btn_back_click);
			dispatchEvent(new Event(BUTTON_CLICK));
			dispatchEvent(new Event(BACK_BUTTON));
			
		}
		private function btn_back_over(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_HOVER));
			optionsArt.alpha = 0.8;
			optionsArt.buttonMode = true;
			trace("over");
			optionsArt.scaleX = 1.13;
			optionsArt.scaleY = 1.13;
			
		}
		private function btn_back_out(e:MouseEvent):void
		{
			
			
			
			optionsArt.alpha = 1;
			optionsArt.buttonMode = false;
			trace("out");
			optionsArt.scaleX = 1;
			optionsArt.scaleY = 1;
		}
		
		private function background1_click(e:MouseEvent):void
		{
			
			
			background1.removeEventListener(MouseEvent.CLICK, btn_back_click);
			dispatchEvent(new Event(BACKGROUND_1_CHANGE));
			dispatchEvent(new Event(BACK_BUTTON));
			
		}
		private function background1_over(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_HOVER));
			background1.alpha = 0.8;
			background1.buttonMode = true;
			trace("over");
			background1.scaleX = 1.13;
			background1.scaleY = 1.13;
			
		}
		private function background1_out(e:MouseEvent):void
		{
			
			
			
			background1.alpha = 1;
			background1.buttonMode = false;
			trace("out");
			background1.scaleX = 1;
			background1.scaleY = 1;
		}
		
		private function background2_click(e:MouseEvent):void
		{
			
			
			background2.removeEventListener(MouseEvent.CLICK, btn_back_click);
			dispatchEvent(new Event(BACKGROUND_2_CHANGE));
			dispatchEvent(new Event(BACK_BUTTON));
			
		}
		private function background2_over(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_HOVER));
			background2.alpha = 0.8;
			background2.buttonMode = true;
			trace("over");
			background2.scaleX = 1.13;
			background2.scaleY = 1.13;
			
		}
		private function background2_out(e:MouseEvent):void
		{
			
			
			
			background2.alpha = 1;
			background2.buttonMode = false;
			trace("out");
			background2.scaleX = 1;
			background2.scaleY = 1;
		}
		
		
		private function background3_click(e:MouseEvent):void
		{
			
			
			background3.removeEventListener(MouseEvent.CLICK, btn_back_click);
			dispatchEvent(new Event(BACKGROUND_3_CHANGE));
			dispatchEvent(new Event(BACK_BUTTON));
			
		}
		private function background3_over(e:MouseEvent):void
		{
			dispatchEvent(new Event(BUTTON_HOVER));
			background3.alpha = 0.8;
			background3.buttonMode = true;
			trace("over");
			background3.scaleX = 1.13;
			background3.scaleY = 1.13;
			
		}
		private function background3_out(e:MouseEvent):void
		{
			
			
			
			background3.alpha = 1;
			background3.buttonMode = false;
			trace("out");
			background3.scaleX = 1;
			background3.scaleY = 1;
		}

	}
	
	
	
}