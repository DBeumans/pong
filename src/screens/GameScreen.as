package screens
{
	import actors.AI;
	import actors.Ball;
	import actors.Obstacle;
	import actors.Paddle;
	import actors.Player;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import utils.MovementCalculator;
	import screens.Scoreboard;
	import screens.IntroScreen;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameScreen extends Screen
	{
		private var balls:Array = [];
		private var paddles:Array = [];
		private var scoreboard:Scoreboard;
		private var obstacles:Array = [];
		static public const GAME_OVER:String = "game over";
		static public const WIN_SCREEN:String = "you win";
		static public const BALL_BOUNCE:String = "ballBounce";
		public static const BACK_TO_MENU:String = "back to menu";
		
		
		
		private var _main:Main;
		private var _introScreen:IntroScreen;
		
		private var getBalls:int = 2;
		
		public var gameTime:Timer = new Timer(100);
		public var timerCounter:int = 0;
		
		
		
		private var timer_txt:TextField;
		private var timer_txtFormat:TextFormat = new TextFormat("../lib/starjedi/Starjedi.ttf", 20, 0xFF0000);
		
		private var spawningObj:Boolean = false;
		
		public function GameScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			spawningObj += true;
			spawningObjects();
			//timer
			gameTime.start();
			gameTime.addEventListener(TimerEvent.TIMER, timerHandler);
			
			
			
			timer_txt = new TextField();
			timer_txt.autoSize = TextFieldAutoSize.CENTER;
			timer_txt.defaultTextFormat = timer_txtFormat;
			timer_txt.x = 50;
			timer_txt.y = 20;
			addChild(timer_txt);
			
			
			
			scoreboard = new Scoreboard();
			addChild(scoreboard);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 49)
			{
				getBalls ++;
				trace("number 1 is pressed");
				trace(getBalls);
				
			}
			if (e.keyCode == 32)
			{
				paddles[1].paddle_yMove += 10;
				trace("Speed increased!");
			}
		}
		private function onKeyUp(e:KeyboardEvent):void
		{

			if (e.keyCode == 32)
			{
				paddles[1].paddle_yMove -= 10;
				trace("Speed have been set to default!");
			}
		}
		
		private function spawningObjects():void
		{
			if (spawningObj == true)
			{
				for (var i:int = 0; i < getBalls; i++)
				{
					balls.push(new Ball());
					addChild(balls[i]);
					balls[i].reset();
					
					balls[i].addEventListener(Ball.OUTSIDE_RIGHT, onRightOut);
					balls[i].addEventListener(Ball.OUTSIDE_LEFT, onLeftOut);
					
				}
				paddles.push(new AI());
				//paddles.push(new AI());
				paddles.push(new Player());
				
				paddles[1].paddle_yMove += 10;
				trace("Speed: " + paddles[1].paddle_yMove);
				
				for (i = 0; i < 2; i++)
				{
					if (paddles[i] is AI) paddles[i].balls = balls;
					addChild(paddles[i]);
					paddles[i].y = stage.stageHeight / 2;
				}
				paddles[0].x = stage.stageWidth - 100;
				
				paddles[1].x = 100;
				
				for (var j:int = 0; j < 4; j++)
				{
					obstacles.push(new Obstacle());
					addChild(obstacles[j]);
				}
			}
		}
		
		private function loop(e:Event):void
		{
			checkCollision();
			if (timerCounter == 1000)
			{
				
				trace("check");
			}
		}
		
		private function checkCollision():void
		{
			for (var i:int = 0; i < balls.length; i++)
			{
				for (var j:int = 0; j < obstacles.length; j++)
				{
					if (obstacles[j].hitTestObject(balls[i]))
					{
						if (balls[i].xMove > 0 && balls[i].x < obstacles[j].x || balls[i].xMove < 0 && balls[i].x > obstacles[j].x)
						{
							balls[i].xMove *= -1;
							balls[i].x += obstacles[j].x - balls[i].x;
							dispatchEvent(new Event(BALL_BOUNCE));
						}
						if (balls[i].yMove > 0 && balls[i].y < obstacles[j].y || balls[i].yMove < 0 && balls[i].y > obstacles[j].y)
						{
							balls[i].yMove *= -1;
							balls[i].y += obstacles[j].y - balls[i].y;
							dispatchEvent(new Event(BALL_BOUNCE));
							
							obstacles[j].remove();
							
						}
						
					}
					
				}
				for (j = 0; j < paddles.length; j++)
				{
					if (paddles[j].hitTestObject(balls[i]))
					{
						if (balls[i].xMove > 0 && balls[i].x < paddles[j].x || balls[i].xMove < 0 && balls[i].x > paddles[j].x)
						{
							balls[i].xMove *= -1;
							balls[i].x += paddles[j].x - balls[i].x;
							dispatchEvent(new Event(BALL_BOUNCE));
						}
						if (balls[i].yMove > 0 && balls[i].y < paddles[j].y || balls[i].yMove < 0 && balls[i].y > paddles[j].y)
						{
							balls[i].yMove *= -1;
							balls[i].y += paddles[j].y - balls[i].y;
							dispatchEvent(new Event(BALL_BOUNCE));
						}
					}
					
				}
			}
		
		}
		
		private function onLeftOut(e:Event):void
		{
			var b:Ball = e.target as Ball;
			b.reset();
			
			scoreboard.player2 += 1;
			
			checkScore();
		
		}
		
		private function onRightOut(e:Event):void
		{
			var b:Ball = e.target as Ball;
			b.reset();
			scoreboard.player1 += 1;
			
			checkScore();
		
		}
		
		private function checkScore():void
		{
			if (scoreboard.player1 >= 1)
			{
				
				destroy();
				
				dispatchEvent(new Event(WIN_SCREEN));
				
			}
			else if (scoreboard.player2 >= 10)
			{
				destroy();
				
				dispatchEvent(new Event(GAME_OVER));
			}
		
		}
		
		private function destroy():void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
			for (var i:int = 0; i < balls.length; i++)
			{
				balls[i].destroy();
				removeChild(balls[i]);
			}
			for (i = 0; i < paddles.length; i++)
			{
				if (paddles[i] is Player) paddles[i].destroy();
			}
			for (i = 0; i < obstacles.length; i++)
			{
				obstacles[i].destroy();
			}
			balls.splice(0, balls.length);
		}
		
		private function scoreAdd():void
		{
			_main._money += timerCounter + scoreboard.player1
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			timerCounter += 100;
			toTimeCode(timerCounter);
			
		}
		
		private function toTimeCode(milliseconds:int):void
		{
			var time:Date = new Date(milliseconds);
			
			//define minutes/seconds/mseconds
			var minutes:String = String(time.minutes);
			var seconds:String = String(time.seconds);
			var miliseconds:String = String(Math.round(time.milliseconds) / 100);
			
			//add zero if neccecary, for example: 2:3.5 becomes 02:03.5
			minutes = (minutes.length != 2) ? '0' + minutes : minutes;
			seconds = (seconds.length != 2) ? '0' + seconds : seconds;
			
			//display elapsed time on in a textfield on stage
			timer_txt.text = minutes + ":" + seconds + "." + miliseconds
		
		}
	
	}

}