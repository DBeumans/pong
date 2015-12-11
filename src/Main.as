package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.FileReference;
	
	import screens.GameOverScreen;
	import screens.GameScreen;
	import screens.WinScreen;
	import screens.IntroScreen;
	import sounds.SoundPlayer;
	import screens.ShopScreen;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flash.events.MouseEvent;
	
	
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class Main extends MovieClip 
	{
		private var gameScreen:GameScreen;
		private var introScreen:IntroScreen;
		private var gameOverScreen:GameOverScreen;
		private var winScreen:WinScreen;
		private var soundPlayer:SoundPlayer;
		
		public static const START_MUSIC:String = "start music";
		
		private var shopScreen:ShopScreen;
		
		
		
		
		public var myXml:XML;
		
		
		public var myLoader:URLLoader = new URLLoader();
		public var backgroundloader:Loader = new Loader();
		
		private var startTimer:Timer;
		
		public function Main() 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		private function init(e:Event = null):void 
		{
			
			
			startTimer = new Timer ( 1500, 1 );
			startTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			startTimer.start();
			
			
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point			
			soundPlayer = new SoundPlayer(this);
			
			
			
				
		}

		
		private function onTimerComplete(t:TimerEvent):void
		{
			startTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
		
			
			myLoader.load( new URLRequest("../src/xml/Image.xml"));
					
			myLoader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		
		
		public function onComplete(e:Event):void 
		{
			myXml = new XML(e.target.data);
			trace(myXml.image[0].link);
			
			backgroundloader.load( new URLRequest(myXml.image[0].link));
			addChild(backgroundloader);		
			
			trace(myXml);

			buildIntroScreen();
			
		}
		

		
		public function buildIntroScreen():void
		{			
			
			introScreen = new IntroScreen();
			addChild(introScreen);
			
			introScreen.addEventListener(IntroScreen.START_GAME, startGame);
			introScreen.addEventListener(IntroScreen.SHOP_MENU, shopMenu);
			
			//introScreen.addEventListener(IntroScreen.BUTTON_CLICK, onClick);
			

			
		}
		private function startGame(e:Event):void 
		{
			
			removeChild(introScreen);
			gameScreen = new GameScreen();
			addChild(gameScreen);
			
			gameScreen.addEventListener(GameScreen.GAME_OVER, onGameOver);
			gameScreen.addEventListener(GameScreen.WIN_SCREEN, onWinScreen);
			gameScreen.addEventListener(GameScreen.BACKGROUND_LOOP, onLoop);

			
			
			
		}	
		
		private function onLoop(e:Event):void
		{
			
			if (backgroundloader.x == 1000)
			{
				backgroundloader.x = -800;
			}
		}
		
		private function shopMenu(e:Event):void
		{
			removeChild(introScreen);
			shopScreen = new ShopScreen();
			addChild(shopScreen);
			shopScreen.addEventListener(ShopScreen.BACK_BUTTON, btn_Back);
			shopScreen.addEventListener(ShopScreen.BACKGROUND_1_CHANGE, onBackground1);
			shopScreen.addEventListener(ShopScreen.BACKGROUND_2_CHANGE, onBackground2);
			shopScreen.addEventListener(ShopScreen.BACKGROUND_3_CHANGE, onBackground3);
			
		}
		
		private function onBackground1(e:Event):void
		{
			removeChild(backgroundloader);
			
			backgroundloader.load( new URLRequest(myXml.image[0].link));
			addChild(backgroundloader);
			
		}
		private function onBackground2(e:Event):void
		{
			removeChild(backgroundloader);
			
			backgroundloader.load( new URLRequest(myXml.image[1].link));
			addChild(backgroundloader);
			
		}
		private function onBackground3(e:Event):void
		{
			removeChild(backgroundloader);
			
			backgroundloader.load( new URLRequest(myXml.image[2].link));
			addChild(backgroundloader);
			
		}

		
		private function btn_Back(e:Event):void
		{
			removeChild(shopScreen);
			buildIntroScreen();
		}
	
		private function onWinScreen(e:Event):void 
		{
			removeChild(gameScreen);
			gameScreen.removeEventListener(GameScreen.WIN_SCREEN, onWinScreen);
						
			winScreen = new WinScreen();
			addChild(winScreen);
			winScreen.addEventListener(WinScreen.RESET2, on_Reset);
			
			
			
		}	
		private function onGameOver(e:Event):void 
		{
			removeChild(gameScreen);
			gameScreen.removeEventListener(GameScreen.GAME_OVER, onGameOver);
						
			gameOverScreen = new GameOverScreen();
			addChild(gameOverScreen);
			gameOverScreen.addEventListener(GameOverScreen.RESET, onReset);
			
			
			
		}		
		private function onReset(e:Event):void 
		{
			removeChild(gameOverScreen);
			
			gameOverScreen.removeEventListener(GameOverScreen.RESET, onReset);
			
			
			buildIntroScreen();
		}
		private function on_Reset(e:Event):void 
		{
			
			removeChild(winScreen);
			
			winScreen.removeEventListener(WinScreen.RESET2, onReset);
			
			buildIntroScreen();
		}
		
	}
	
}