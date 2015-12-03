package screens 
{
	import flash.display.Loader;
	import flash.events.Event;
	import screens.Screen;
	import screens.IntroScreen;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.net.URLLoader;
	
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
		
		private var optionsArt:MovieClip = new OptionsArt;
		
		private var introScreen:IntroScreen;
		
		
		
		public function ShopScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			introScreen = new IntroScreen();
			
			/*btn_back = new MovieClip();
			btn_back.graphics.beginFill(0xFFCC00);
			btn_back.graphics.drawRect(0, 0, 120, 120);
			btn_back.graphics.endFill();
			
			btn_back.x = 600;
			btn_back.y = 40;*/
			optionsArt.x = 400;
			optionsArt.y = 40;
			addChild(optionsArt);
			
			
			
			optionsArt.addEventListener(MouseEvent.CLICK, btn_back_click);
			
			

		}
		
		private function btn_back_click(e:MouseEvent):void
		{
			
			
			optionsArt.removeEventListener(MouseEvent.CLICK, btn_back_click);
			dispatchEvent(new Event(BACK_BUTTON));
			
		}
		

	}
	
	
	
}