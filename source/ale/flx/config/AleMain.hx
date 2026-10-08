package ale.flx.config;

import haxe.CallStack;

import lime.system.System;

import openfl.events.UncaughtErrorEvent;
import openfl.events.KeyboardEvent;
import openfl.display.Sprite;
import openfl.ui.Mouse;
import openfl.Lib;

import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxG;

import ale.flx.assets.AleAssets;
import ale.flx.util.AleAppUtil;
import ale.flx.debug.AleLogs;
import ale.flx.AleG;

class AleMain extends Sprite
{
    public static var instance(default, null):AleMain;
    
    public function new()
    {
        super();

        if (instance == null)
            instance = this;
        else
            throw 'This class should not be instantiated more than once';

        preInit();

        init();

        postInit();

        if (FlxG.game == null)
            throw 'There is no game at all';

        if (!(FlxG.game is AleGame))
            throw 'FlxG.game does not have an AleGame';
    }

    public function preInit()
    {
        Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, error -> {
			final title:String = 'ALE Flixel | Crash Handler';

			var printMessage:String = '';

			var consoleMessage:String = '\n' + title + '\n';

			for (stackItem in CallStack.exceptionStack(true))
				switch (stackItem)
				{
					case FilePos(item, file, line, _):
						switch (item)
						{
							case Method(className, func):
								printMessage += className + '.' + func + ' - Line ' + line;
							default:
								printMessage += file + ':' + line;
						}

						printMessage += '\n';

						consoleMessage += file + '#' + line + '\n';
                        
					default:
				}

			final errorMessage:String = '\n' + error.error;

			AleLogs.print(consoleMessage + errorMessage, ERROR);
			
			AleLogs.popUp(title, printMessage + errorMessage);

			destroy();

			System.exit(1);
        });

        Lib.application.window.onClose.add(() -> destroy());

        FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, event -> {
            if (event.altKey && event.keyCode == FlxKey.ENTER)
            {
                event.stopImmediatePropagation();
            } else if (event.ctrlKey && event.shiftKey) {
                switch (event.keyCode)
                {
                    case FlxKey.N:
                        AleG.reset();
                }
            }
        }, false, 1);
    }

    public function init()
        addChild(new AleGame());

    public function postInit()
    {
		function resetSpriteCache(sprite:Sprite)
			@:privateAccess {
		        sprite.__cacheBitmap = null;
				sprite.__cacheBitmapData = null;
			}
		
		FlxG.signals.gameResized.add((w, h) -> {
		     if (FlxG.cameras != null)
				for (cam in FlxG.cameras.list)
					if (cam != null && cam.filters != null)
						resetSpriteCache(cam.flashSprite);

			if (FlxG.game != null)
				resetSpriteCache(FlxG.game);
		});
    }

    public function preReset()
    {
        #if desktop
        Mouse.cursor = ARROW;
        #end

        if (FlxG.state.subState != null)
            FlxG.state.subState.close();

        FlxTween.globalManager.clear();
        FlxTimer.globalManager.clear();
    }

    public function postReset()
    {
		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		FlxG.sound.muteKeys = FlxG.sound.volumeDownKeys = FlxG.sound.volumeUpKeys = [];

		FlxG.autoPause = false;

		FlxG.mouse.unload();
		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;
        
        FlxSprite.defaultAntialiasing = true;

        FlxG.updateFramerate = AleG.game.initialDrawFramerate;
        FlxG.drawFramerate = AleG.game.initialDrawFramerate;

        AleAppUtil.resize(AleG.game.initialWidth, AleG.game.initialHeight);

        AleAssets.clear(true, true);
        AleAssets.init();

        AleLogs.init();

        #if ale_ui
        ale.ui.Config.reset();
        ale.ui.Config.FONT = 'ale/ui/fonts/montserrat.ttf';
        #end
    }

    public function destroy() {}
}