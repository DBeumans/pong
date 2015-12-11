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

		
		
		public function Paddle() 
		{
				addChild(new PaddleArt);

		}
	}

}