package actors 
{
	import flash.events.Event;
	import utils.Controller;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class AI extends Paddle 
	{
		private var _target:Ball;
		private var _speed:Number = 0;
		private var _maxSpeed:Number = 12;
		private var _balls:Array;
		
		private var controller:Controller;
		private var speed:Number = 0;
		
		public var singleplayerOption:Boolean = true;
		
		public function set balls(b:Array):void
		{
			_balls = b;			
		}
		public function AI() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			singleplayerOption = true;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			controller = new Controller(stage);
			this.addEventListener(Event.ENTER_FRAME, loop);						
		}
		private function getTarget():void
		{
			if (_target == null)_target = _balls[0];
			if(_balls.length>1){
				var closest:Ball = _balls[0];
				for (var i:int = 1; i < _balls.length; i++) 
				{
					var d:Number = _balls[i-1].x - _balls[i].x;
					if (d < 0) closest = _balls[i];
				}
				_target = closest;
			}
		}
		private function loop(e:Event):void 
		{
			if (singleplayerOption == true)
			{
				getTarget();
										
				if(_target != null){
					if (_target.y < this.y - 20)_speed = -_maxSpeed;
					else if (_target.y > this.y + 20)_speed = _maxSpeed;
					else _speed = 0;
					
					this.y += _speed;
				}
			}
			if (!singleplayerOption == true)
			{
				if (controller.up)
				{
					speed = -15;
				}
				else if(controller.down)
				{
					speed = 15;
				}else
				{
					if (speed > 0) speed--;
					if (speed < 0) speed++;
					
				}
				if (controller.fire)
				{
					
					
				}
				this.y += speed;
			}
		
		}
	}
}