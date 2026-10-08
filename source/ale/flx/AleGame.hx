package ale.flx;

import flixel.util.typeLimit.NextState;
import flixel.input.keyboard.FlxKey;
import flixel.FlxGame;
import flixel.FlxG;

import ale.flx.config.AleMainState;

@:allow(ale.flx.config.AleMain)
class AleGame extends FlxGame
{
    var initialWidth:Int;
    var initialHeight:Int;
    var initialUpdateFramerate:Int;
    var initialDrawFramerate:Int;

    public function new(?width:Int = 1280, ?height:Int = 720, ?initialState:NextState, ?updateFramerate:Int = 120, drawFramerate:Int = 120, ?mainState:NextState -> AleMainState)
    {
        initialState ??= AleState.new;
        mainState ??= AleMainState.new;

        super(initialWidth = width, initialHeight = height, mainState.bind(initialState), initialUpdateFramerate = updateFramerate, initialDrawFramerate = drawFramerate, true);
    }
}