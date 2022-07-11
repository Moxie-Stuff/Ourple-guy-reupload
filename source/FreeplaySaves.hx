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

class FreeplaySaves
{

    public static var lurkingLock:String = 'locked';
    public static var loreLock:String = 'locked';
    public static var blubberLock:String = 'locked';
    public static var goldenLock:String = 'locked';
    public static var performanceLock:String = 'locked';
    public static var biteLock:String = 'locked';
    public static var trappedLock:String = 'locked';
    public static var gofishLock:String = 'locked';
    public static var watchfulLock:String = 'locked';
    public static var restlessLock:String = 'locked';
    public static var beatboxLock:String = 'locked';
    public static var showtimeLock:String = 'locked';
    public static var manLock:String = 'locked';
    public static var followedLock:String = 'locked';
    public static var fazfuckLock:String = 'locked';
    public static var criminalLock:String = 'locked';
    public static var millerLock:String = 'locked';

    public static function fuckinSet() {
        if (FlxG.save.data.lurkingLock == null) FlxG.save.data.lurkingLock = 'locked';
        if (FlxG.save.data.loreLock == null) FlxG.save.data.loreLock = 'locked';
        if (FlxG.save.data.blubberLock == null) FlxG.save.data.blubberLock = 'locked';
        if (FlxG.save.data.goldenLock == null) FlxG.save.data.goldenLock = 'locked';
        if (FlxG.save.data.performanceLock == null) FlxG.save.data.performanceLock = 'locked';
        if (FlxG.save.data.biteLock == null) FlxG.save.data.biteLock = 'locked';
        if (FlxG.save.data.trappedLock == null) FlxG.save.data.trappedLock = 'locked';
        if (FlxG.save.data.gofishLock == null) FlxG.save.data.gofishLock = 'locked';
        if (FlxG.save.data.watchfulLock == null) FlxG.save.data.watchfulLock = 'locked';
        if (FlxG.save.data.restlessLock == null) FlxG.save.data.restlessLock = 'locked';
        if (FlxG.save.data.beatboxLock == null) FlxG.save.data.beatboxLock = 'locked';
        if (FlxG.save.data.showtimeLock == null) FlxG.save.data.showtimeLock = 'locked';
        if (FlxG.save.data.manLock == null) FlxG.save.data.manLock = 'locked';
        if (FlxG.save.data.followedLock == null) FlxG.save.data.followedLock = 'locked';
        if (FlxG.save.data.fazfuckLock == null) FlxG.save.data.fazfuckLock = 'locked';
        if (FlxG.save.data.criminalLock == null) FlxG.save.data.criminalLock = 'locked';
        if (FlxG.save.data.millerLock == null) FlxG.save.data.millerLock = 'locked';
        FlxG.save.flush();
    }

    public static function saveShit() {
        FlxG.save.data.lurkingLock = lurkingLock;
        FlxG.save.data.loreLock = loreLock;
        FlxG.save.data.blubberLock = blubberLock;
        FlxG.save.data.goldenLock = goldenLock;
        FlxG.save.data.performanceLock = performanceLock;
        FlxG.save.data.biteLock = biteLock;
        FlxG.save.data.trappedLock = trappedLock;
        FlxG.save.data.gofishLock = gofishLock;
        FlxG.save.data.watchfulLock = watchfulLock;
        FlxG.save.data.restlessLock = restlessLock;
        FlxG.save.data.beatboxLock = beatboxLock;
        FlxG.save.data.showtimeLock = showtimeLock;
        FlxG.save.data.manLock = manLock;
        FlxG.save.data.followedLock = followedLock;
        FlxG.save.data.fazfuckLock = fazfuckLock;
        FlxG.save.data.criminalLock = criminalLock;
        FlxG.save.data.millerLock = millerLock;
        FlxG.save.flush();
    }

    public static function loadShit() { //golly gee willikers
        lurkingLock = FlxG.save.data.lurkingLock;
        loreLock = FlxG.save.data.loreLock;
        blubberLock = FlxG.save.data.blubberLock;
        goldenLock = FlxG.save.data.goldenLock;
        performanceLock = FlxG.save.data.performanceLock;
        biteLock = FlxG.save.data.biteLock;
        trappedLock = FlxG.save.data.trappedLock;
        gofishLock = FlxG.save.data.gofishLock;
        watchfulLock = FlxG.save.data.watchfulLock;
        restlessLock = FlxG.save.data.restlessLock;
        beatboxLock = FlxG.save.data.beatboxLock;
        showtimeLock = FlxG.save.data.showtimeLock;
        manLock = FlxG.save.data.manLock;
        followedLock = FlxG.save.data.followedLock;
        fazfuckLock = FlxG.save.data.fazfuckLock;
        criminalLock = FlxG.save.data.criminalLock;
        millerLock = FlxG.save.data.millerLock;
        if (lurkingLock == 'beaten' && loreLock == 'beaten' && blubberLock == 'beaten' && goldenLock == 'beaten' && performanceLock == 'beaten' && trappedLock == 'beaten' && biteLock == 'beaten' && gofishLock == 'beaten' && watchfulLock == 'beaten' && restlessLock == 'beaten' && beatboxLock == 'beaten' && showtimeLock == 'beaten' && manLock == 'beaten' && followedLock == 'beaten' && fazfuckLock == 'beaten' && criminalLock == 'beaten') FlxG.save.data.millerHere = true;
        FlxG.save.flush();
    }
}