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
        FlxG.save.flush();
    }
}