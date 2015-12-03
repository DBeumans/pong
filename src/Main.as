package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import screens.GameOverScreen;
	import screens.GameScreen;
	import screens.IntroScreen;
	import sounds.SoundPlayer;
	import screens.ShopScreen;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class Main extends MovieClip 
	{
		private var gameScreen:GameScreen
		private var introScreen:IntroScreen;
		private var gameOverScreen:GameOverScreen;
		private var soundPlayer:SoundPlayer;
		
		private var shopScreen:ShopScreen;
		
		public var myXml:XML;
		public var myLoader:URLLoader = new URLLoader();
		
		public var playerMoney:uint = 20;
		public var _money:TextField;
		public var _moneyFormat:TextFormat = new TextFormat("../lib/starjedi/Starjedi.ttf", 20, 0xFF0000);
		
		public function Main() 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		private function init(e:Event = null):void 
		{
			
			myLoader.load( new URLRequest("../src/xml/Image.xml"));
			
			myLoader.addEventListener(Event.COMPLETE, onComplete);
			
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			soundPlayer = new SoundPlayer(this);
				
		}
		
			public function onComplete(e:Event):void 
		{
			var backgroundloader:Loader = new Loader();
			
			myXml = new XML(e.target.data);
			trace(myXml.image[0].link);
			trace(myXml.player.money);
			
			backgroundloader.load( new URLRequest(myXml.image[0].link));
			addChild(backgroundloader);
		
			//money
			_money = new TextField();
			_money.embedFonts = false;
			//_money.text = String(playerMoney);
			_money.autoSize = TextFieldAutoSize.CENTER;
			//_money.setTextFormat(subFormat);
			_money.defaultTextFormat = _moneyFormat;
			
			_money.x = 50;
			_money.y = 50;
			
			//addChild(_money);
			addEventListener(Event.ENTER_FRAME, updateText);
			
			buildIntroSreen();
		}
		
		public function buildIntroSreen():void
		{			
			introScreen = new IntroScreen();
			addChild(introScreen);
			addChild(_money);
			
			introScreen.addEventListener(IntroScreen.START_GAME, startGame);
			introScreen.addEventListener(IntroScreen.SHOP_MENU, shopMenu);
			

			
		}
		private function startGame(e:Event):void 
		{
			removeChild(_money);
			removeChild(introScreen);
			gameScreen = new GameScreen();
			addChild(gameScreen);
			gameScreen.addEventListener(GameScreen.GAME_OVER, onGameOver);
			
			
			
		}	
		
		private function shopMenu(e:Event):void
		{
			removeChild(introScreen);
			shopScreen = new ShopScreen();
			addChild(shopScreen);
			shopScreen.addEventListener(ShopScreen.BACK_BUTTON, btn_Back);
			
		}
			
		private function updateText(e:Event):void
		{
			_money.text = "Money: " + myXml.player.money;
		}

		
		private function btn_Back(e:Event):void
		{
			removeChild(shopScreen);
			buildIntroSreen();
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
			
			buildIntroSreen();
		}
		
	}
	
}