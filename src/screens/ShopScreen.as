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
	
	import Main;
	
	/**
	 * ...
	 * @author Danilo
	 */
	public class ShopScreen extends MovieClip
	{
		
		public static const BACK_BUTTON:String = "back button";	
		public static const BUTTON_CLICK:String = "button click";	
		public static const MENU_MUSIC:String = "menu music";
		
		private var optionsArt:MovieClip = new OptionsArt;
		private var display1Art:MovieClip = new Display1Art;
		private var display2Art:MovieClip = new Display2Art;
		
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
			infoText.text = "How To Play :" + "\n" + "\n" + "Controls: " + "\n" +"Use the arrow keys ( arrow key up and arrow key down ) to go up and down." + "\n" + "Powerups: " + "\n" + "Press the 'Spacebar' to increase your speed for 3 seconds! ( 20 seconds cooldown),";
			
			addChild(infoText);
			
			/*btn_back = new MovieClip();
			btn_back.graphics.beginFill(0xFFCC00);
			btn_back.graphics.drawRect(0, 0, 120, 120);
			btn_back.graphics.endFill();
			
			btn_back.x = 600;
			btn_back.y = 40;*/
			optionsArt.x = 50;
			optionsArt.y = 575;
			addChild(optionsArt);
			
			display1Art.x = 30;
			display1Art.y = 250;
			addChild(display1Art);
			
			display2Art.x = 180;
			display2Art.y = 250;
			addChild(display2Art);
			
			
			
			optionsArt.addEventListener(MouseEvent.CLICK, btn_back_click);
			display1Art.addEventListener(MouseEvent.CLICK, display1Art_click);
			display2Art.addEventListener(MouseEvent.CLICK, display2Art_click);
			
			
		}
		
		private function btn_back_click(e:MouseEvent):void
		{
			
			
			optionsArt.removeEventListener(MouseEvent.CLICK, btn_back_click);
			dispatchEvent(new Event(BUTTON_CLICK));
			dispatchEvent(new Event(BACK_BUTTON));
			
		}
		public function display1Art_click(ev:MouseEvent):void
		{
			trace("Art1");
			
			
		}
		public function display2Art_click(ev:MouseEvent):void
		{
			trace("Art2");
			
			
		}
		
		

	}
	
	
	
}