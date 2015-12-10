package sounds 
{
	import flash.media.Sound;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import screens.*; 
	

	/**
	 * ...
	 * @author erwin henraat
	 */
	public class SoundPlayer 
	{
		private var _sounds:Array = [];
		private var _channels:Array = [];
		private var _main:Main;
				
		public function SoundPlayer(main:Main):void
		{
			_main = main;			
			
			loadSound("../lib/pong.mp3");//0		
			loadSound("../lib/pong2.mp3");//1			
			loadSound("../lib/pong3.mp3");//2	
			loadSound("../lib/lose.mp3");//3	
			loadSound("../lib/intro.mp3");//4	
			loadSound("../lib/menuhit.mp3");//5
			loadSound("../lib/menubackground.mp3");//6
			loadSound("../lib/gos.mp3");//7
			loadSound("../lib/menuhover.mp3");//8
						
			_main.addEventListener(GameScreen.BALL_BOUNCE, onBounce, true);
			_main.addEventListener(GameScreen.GAME_OVER, onGameOver, true);
			_main.addEventListener(IntroScreen.START_GAME, onIntro, true);
			_main.addEventListener(IntroScreen.BUTTON_CLICK, onClick, true);
			_main.addEventListener(ShopScreen.BUTTON_CLICK, onClick, true);
			_main.addEventListener(IntroScreen.MENU_MUSIC, onbackgroundMusic, true);
			_main.addEventListener(IntroScreen.BUTTON_HOVER, onHover, true);
			//_main.addEventListener(ShopScreen.BUTTON_HOVER, onHover, true);
			
			_main.addEventListener(Main.START_MUSIC, onMusicStart, true);
		
			
			
			
		}
		private function onHover(e:Event):void
		{
			playSound(8);
		}
		private function onMusicStart(e:Event):void
		{
			stopAllSounds();
			playSound(7);
		}
		
		private function onClick(e:Event):void
		{
			
			stopAllSounds();
			playSound(5);
		}
		private function onbackgroundMusic(e:Event):void
		{
			
			//stopAllSounds();
			playSound(6);
		}
		private function onIntro(e:Event):void 
		{
			stopAllSounds();
			playSound(4);
		}
		
		private function onGameOver(e:Event):void 
		{
			stopAllSounds();
			playSound(3);
		}		
		private function onBounce(e:Event):void 
		{
			
			playSound(Math.floor(Math.random() * 3));
		}
		private function loadSound(file:String):void
		{
			_sounds.push(new Sound(new URLRequest(file)));
				
		}
		private function playSound(index:int, loops:int = 1, volume:Number = 1, pan:Number = 0):void
		{
			if (index > _sounds.length - 1)
			{
				trace("referenced sound is not loaded");				
			}
			else
			{			
				var transform:SoundTransform = new SoundTransform(volume, pan);
				_channels.push(_sounds[index].play(0, loops));
				_channels[_channels.length-1].soundTransform = transform;
			}			
		}	
		private function stopAllSounds():void
		{
			var amount:int = _channels.length;
			for (var i:int = 0; i < amount; i++) 
			{
				_channels[i].stop();
			}
			_channels = [];
			
		}
		
	}

}