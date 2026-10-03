package ale.flixel;

import flixel.util.typeLimit.NextState;
import flixel.FlxGame;

import ale.flixel.AleG;

#if cpp
@:cppFileCode('
namespace ale { namespace flixel {
    using ::flixel::FlxGame_obj;
} }
')
#end
class AleGame extends FlxGame
{
    public function new(?width:Int, ?height:Int, ?initialState:NextState, ?updateFramerate:Int = 60, drawFramerate:Int = 60, ?mainState:NextState -> AleMainState)
    {
        initialState ??= AleState.new;
        mainState ??= AleMainState.new;

        super(width, height, mainState.bind(initialState), updateFramerate, drawFramerate, true);
    }
}