package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.addons.display.FlxTiledSprite;

using StringTools;

class FirstTimeFreeplay
{

    public static var firstTimeFreeplay:Bool = true;

    public static function fuckinSet() {
        if (FlxG.save.data.firstTimeFreeplay == null) FlxG.save.data.firstTimeFreeplay = true;
        FlxG.save.flush();
    }

    public static function saveShit() {
		FlxG.save.data.firstTimeFreeplay = firstTimeFreeplay;
        FlxG.save.flush();
    }

    public static function loadShit() {
		firstTimeFreeplay = FlxG.save.data.firstTimeFreeplay;
        FlxG.save.flush();
    }
}
