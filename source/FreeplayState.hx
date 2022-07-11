package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import openfl.filters.ShaderFilter;
import WeekData;
import Shaders;
import flixel.addons.display.FlxTiledSprite;
import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.system.FlxAssets;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	public var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var arcadeGrp:FlxTypedGroup<ArcadeMachine>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxTiledSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;

	public var camBG:FlxCamera;
	public var camGame:FlxCamera;

	var r_arrow:FlxSprite;
	var l_arrow:FlxSprite;

	var vignette:FlxSprite;

	var bgTargetX:Int;

	override function create()
	{

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		/*for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}*/

		FreeplaySaves.loadShit();

		addSong('guy', 0, 'guy', 0xFF000000, 'unlocked');
		addSong('midnight', 0, 'orange', 0xFF000000, 'unlocked');
		addSong('terminated', 0, 'henryt', 0xFF000000, 'unlocked');
		addSong('lurking', 0, 'guy', 0xFF000000, FlxG.save.data.lurkingLock);
		addSong('lore', 0, 'guy', 0xFF000000, FlxG.save.data.loreLock);
		addSong('blubber', 0, 'guy', 0xFF000000, FlxG.save.data.blubberLock);
		addSong('golden', 0, 'guy', 0xFF000000, FlxG.save.data.goldenLock);
		addSong('performance', 0, 'guy', 0xFF000000, FlxG.save.data.performanceLock);
		addSong('bite', 0, 'guy', 0xFF000000, FlxG.save.data.biteLock);
		addSong('trapped', 0, 'guy', 0xFF000000, FlxG.save.data.trappedLock);
		addSong('go fish', 0, 'guy', 0xFF000000, FlxG.save.data.gofishLock);
		addSong('watchful', 0, 'guy', 0xFF000000, FlxG.save.data.watchfulLock);
		addSong('restless', 0, 'guy', 0xFF000000, FlxG.save.data.restlessLock);
		addSong('beatbox', 0, 'guy', 0xFF000000, FlxG.save.data.beatboxLock);
		addSong('showtime', 0, 'guy', 0xFF000000, FlxG.save.data.showtimeLock);
		addSong('man', 0, 'guy', 0xFF000000, FlxG.save.data.manLock);
		addSong('followed', 0, 'guy', 0xFF000000, FlxG.save.data.followedLock);
		addSong('fazfuck news', 0, 'guy', 0xFF000000, FlxG.save.data.fazfuckLock);
		addSong('criminal', 0, 'guy', 0xFF000000, FlxG.save.data.criminalLock);
		#if !debug 
			if (everyFreeplaySongBeaten() || FlxG.save.data.millerHere) addSong('miller', 0, 'guy', 0xFF000000, FlxG.save.data.millerLock);
		#else
		addSong('miller', 0, 'guy', 0xFF000000, FlxG.save.data.millerLock);
		#end

		WeekData.loadTheFirstEnabledMod();

		camGame = new FlxCamera();
		camBG = new FlxCamera();
		camBG.bgColor.alpha = 0;
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camBG);
		FlxCamera.defaultCameras = [camBG];

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

		bg = new FlxTiledSprite(Paths.image('freeplaywall', 'preload'), FlxG.width * 3, FlxG.width * 3, true, true);
		bg.antialiasing = false;
		bg.scrollFactor.set(0.8, 0.8);
		bgTargetX = 10;
		bg.cameras = [camGame];
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		arcadeGrp = new FlxTypedGroup<ArcadeMachine>();
		add(arcadeGrp);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			//grpSongs.add(songText);

			var arcadeMachine:ArcadeMachine = new ArcadeMachine((100 * i) + 30, 200);
			if (songs[i].lockstatus == 'unlocked' || songs[i].lockstatus == 'beaten') arcadeMachine.loadGraphic(Paths.image('machines/' + songs[i].songName.toLowerCase(), 'preload'));
			else {
			#if !debug
				if (songs[i].songName != 'miller') arcadeMachine.loadGraphic(Paths.image('machines/blank', 'preload'));
				else arcadeMachine.loadGraphic(Paths.image('machines/bl_miller', 'preload'));
			#else
				arcadeMachine.loadGraphic(Paths.image('machines/' + songs[i].songName.toLowerCase(), 'preload'));
			#end
			}
			arcadeMachine.coolArcadeTargetX = i;
			arcadeGrp.add(arcadeMachine);
			arcadeMachine.scale.set(1.5, 1.5);
			arcadeMachine.antialiasing = false;
			arcadeMachine.cameras = [camBG];
			
			trace(songs[i].lockstatus);

			if (songText.width > 980)
			{
				var textScale:Float = 980 / songText.width;
				songText.scale.x = textScale;
				for (letter in songText.lettersArray)
				{
					letter.x *= textScale;
					letter.offset.x *= textScale;
				}
				//songText.updateHitbox();
				//trace(songs[i].songName + ' new scale: ' + textScale);
			}

			Paths.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		scoreText.cameras = [camBG];

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);
		scoreBG.cameras = [camBG];

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);
		diffText.cameras = [camBG];

		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		//bg.color = songs[curSelected].color;
		//intendedColor = bg.color;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection();
		changeDiff();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		r_arrow = new FlxSprite(900, 300);
		r_arrow.frames = Paths.getSparrowAtlas('freeplayarrow', 'preload');
		r_arrow.animation.addByPrefix('normal', 'normal', 12, true);
		r_arrow.animation.addByPrefix('press', 'press', 16, false);
		r_arrow.setGraphicSize(Std.int(r_arrow.width * 1.5));
		r_arrow.updateHitbox();
		r_arrow.animation.play('normal', true);
		add(r_arrow);

		l_arrow = new FlxSprite(250, 300);
		l_arrow.frames = Paths.getSparrowAtlas('freeplayarrow', 'preload');
		l_arrow.animation.addByPrefix('normal', 'normal', 12, true);
		l_arrow.animation.addByPrefix('press', 'press', 16, false);
		l_arrow.setGraphicSize(Std.int(l_arrow.width * 1.5));
		l_arrow.flipX = true;
		l_arrow.updateHitbox();
		l_arrow.animation.play('normal', true);
		add(l_arrow);
		

		FlxG.sound.playMusic(Paths.music('8bitMenu'), 0);

		FlxG.sound.music.fadeIn(2, 0, 0.8);

		vignette = new FlxSprite(0, 0);
		vignette.loadGraphic(Paths.image('menuvig', 'preload'));
		vignette.screenCenter();
		vignette.alpha = 0.85;
		vignette.cameras = [camBG];
		add(vignette);

		super.create();
		camGame.setFilters([new ShaderFilter(new PincushionShader())]);
		camGame.filtersEnabled = !ClientPrefs.lowQuality;
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int, lockstatus:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color, lockstatus));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	private static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		bg.x = FlxMath.lerp(bg.x, (FlxMath.remapToRange(bgTargetX, 0, 1, 0, 1.3)), CoolUtil.boundTo(elapsed * 9.6, 0, 1));

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
		{
			if (controls.UI_LEFT_P)
			{
				changeSelection(-shiftMult);
				l_arrow.animation.play('press', false);
				l_arrow.animation.finishCallback = function (name:String) {
					l_arrow.animation.play('normal', true);
				};
				holdTime = 0;
			}
			if (controls.UI_RIGHT_P)
			{
				changeSelection(shiftMult);
				r_arrow.animation.play('press', false);
				r_arrow.animation.finishCallback = function (name:String) {
					r_arrow.animation.play('normal', true);
				};
				holdTime = 0;
			}

			if(controls.UI_LEFT_P || controls.UI_RIGHT_P)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					changeDiff();
				}
			}
		}

		//if (controls.UI_LEFT_P)
			//changeDiff(-1);
		//else if (controls.UI_RIGHT_P)
			//changeDiff(1);
		if (controls.UI_LEFT_P || controls.UI_RIGHT_P) changeDiff();

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.sound.music.fadeOut(1);
			MusicBeatState.switchState(new MainMenuState());
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(1, 0, 0.7);
		}
		if (accepted)
		{
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
			}

				LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.volume = 0;
					
			destroyFreeplayVocals();
		}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
			
		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

		var i = 0;
		for(item in arcadeGrp.members) {
			item.coolArcadeTargetX = i - curSelected;
			i++;
		}

		var fucker:Int = 0;

		bgTargetX = (fucker - curSelected) * 55;
		fucker++;
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
	}

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;

		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}

	function everyFreeplaySongBeaten() {
			return FreeplaySaves.lurkingLock == 'beaten' && FreeplaySaves.loreLock == 'beaten' && FreeplaySaves.blubberLock == 'beaten' && FreeplaySaves.goldenLock == 'beaten' && FreeplaySaves.performanceLock == 'beaten' && FreeplaySaves.trappedLock == 'beaten' && FreeplaySaves.biteLock == 'beaten' && FreeplaySaves.gofishLock == 'beaten' && FreeplaySaves.watchfulLock == 'beaten' && FreeplaySaves.restlessLock == 'beaten' && FreeplaySaves.beatboxLock == 'beaten' && FreeplaySaves.showtimeLock == 'beaten' && FreeplaySaves.manLock == 'beaten' && FreeplaySaves.followedLock == 'beaten' && FreeplaySaves.fazfuckLock == 'beaten' && FreeplaySaves.criminalLock == 'beaten';
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var lockstatus:String = 'locked';
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int, lockstatus:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.lockstatus = lockstatus;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}

class ArcadeMachine extends FlxSprite
{

    public var coolArcadeTargetX:Int;

    public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
        {
            super(X, Y);
        }


    override function update(elapsed:Float) {
            x = FlxMath.lerp(x, (FlxMath.remapToRange(coolArcadeTargetX, 0, 1, 0, 1.3) * 460) + 510, CoolUtil.boundTo(elapsed * 9.6, 0, 1));
            super.update(elapsed);
        } 

}