package ale.flx.util;

import flixel.system.scaleModes.RatioScaleMode;
import flixel.FlxG;

import openfl.Lib;

class AleAppUtil
{
    @:access(flixel.FlxG)
	public static function resize(width:Int, height:Int, ?centerWindow:Bool = true, ?scale:Float = 1)
	{
		final previousFullscreen:Bool = FlxG.fullscreen;

		FlxG.initialWidth = width;
		FlxG.initialHeight = height;

		FlxG.resizeGame(width, height);
		FlxG.resizeWindow(Math.floor(width * scale), Math.floor(height * scale));

		#if !mobile
		FlxG.fullscreen = false;

		if (centerWindow)
		{
			Lib.application.window.x = Std.int((Lib.application.window.display.bounds.width - Lib.application.window.width) / 2);
			Lib.application.window.y = Std.int((Lib.application.window.display.bounds.height - Lib.application.window.height) / 2);
		}
		#end

		for (camera in FlxG.cameras.list)
		{
			camera.width = width;
			camera.height = height;
		}

		FlxG.scaleMode = new RatioScaleMode();

		#if !mobile
		FlxG.fullscreen = previousFullscreen;
		#end
	}
}