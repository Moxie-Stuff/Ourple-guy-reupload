package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxSort;
import flash.system.System;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	public var aftonScream:Character;
	public var aftonAflame:FlxSprite;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var startScare:Bool = false;

	var stageSuffix:String = "";

	public static var aftonX:Float = 0;
	public static var aftonY:Float = 0;
	public static var jumpscare:Bool = false;
	public static var characterName:String = 'bf';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
		jumpscare = false;
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		if (!jumpscare){
			boyfriend = new Boyfriend(x, y, characterName);
			boyfriend.x += boyfriend.positionArray[0];
			boyfriend.y += boyfriend.positionArray[1];
			add(boyfriend);

			camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);

			if (characterName != 'cc')
				FlxG.sound.play(Paths.sound(deathSoundName));
			Conductor.changeBPM(100);
			// FlxG.camera.followLerp = 1;
			// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
			FlxG.camera.scroll.set();
			FlxG.camera.target = null;

			boyfriend.playAnim('firstDeath');

			var exclude:Array<Int> = [];

			camFollowPos = new FlxObject(0, 0, 1, 1);
			camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
			add(camFollowPos);
			
			FlxG.camera.follow(camFollowPos, LOCKON, 1);
			updateCamera = true;
			isFollowingAlready = true;
		}
		else
		{
			aftonScream = new Character(aftonX, aftonY, 'criminal');
			aftonScream.x += aftonScream.positionArray[0];
			aftonScream.y += aftonScream.positionArray[1];
			add(aftonScream);
			
			aftonAflame = new FlxSprite(0, 0);
			aftonAflame.frames = Paths.getSparrowAtlas('aflame');
			aftonAflame.animation.addByPrefix('aflame', 'aflame idle', 40, true);
			aftonAflame.animation.play('aflame', true);
			aftonAflame.antialiasing = false;
			aftonAflame.scrollFactor.set(0, 0);
			aftonAflame.scale.set(3, 3);
			aftonAflame.updateHitbox();
			aftonAflame.screenCenter();
			aftonAflame.alpha = 0.000001;
			add(aftonAflame);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				System.exit(0);
			});
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxG.camera.shake(0.020, 1);
				startScare = true;
				aftonAflame.alpha = 1;
				aftonScream.visible = false;
				FlxG.sound.play(Paths.sound(deathSoundName));
			});
		}
	}

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if (!jumpscare){
			if(updateCamera) {
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
				camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
			}

			if (controls.ACCEPT)
			{
				endBullshit();
			}

			if (controls.BACK)
			{
				FlxG.sound.music.stop();
				PlayState.deathCounter = 0;
				PlayState.seenCutscene = false;

				if (PlayState.isStoryMode)
					MusicBeatState.switchState(new StoryMenuState());
				else
					MusicBeatState.switchState(new FreeplayState());

				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
			}

			if (boyfriend.animation.curAnim.name == 'firstDeath')
			{

				if (boyfriend.animation.curAnim.finished)
				{
					coolStartDeath();
					boyfriend.startedDeath = true;
				}
			}
		}
		else
		{
			if (aftonScream != null)
			{
				if (!startScare)
					aftonScream.playAnim('singUP', true, false, 5);
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
