package actors 
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import screens.ShopScreen;
	import flash.net.FileReference;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Paddle extends MovieClip 
	{
		private var _shopScreen:ShopScreen;

		
		private var _main:Main;
		
		private var opslag:int = 0;
		
		public var spawnPaddle:Array = [new PaddleArt(), //0
										new Paddle2Art() // 1
										];
		
		public function Paddle() 
		{
				addChild(spawnPaddle[0]);

		}
	}

}