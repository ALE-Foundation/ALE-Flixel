package ale.flixel;

import flixel.util.typeLimit.NextState.InitialState;
import flixel.FlxGame;

class AleGame extends FlxGame
{
    public function new(?width:Int, ?height:Int, ?initialState:InitialState, ?updateFramerate:Int = 60, drawFramerate:Int = 60)
    {
        initialState ??= AleState.new;

        super(width, height, initialState, updateFramerate, drawFramerate, true);
    }
}