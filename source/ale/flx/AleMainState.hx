package ale.flx;

import flixel.util.typeLimit.NextState;
import flixel.FlxState;

import ale.flx.assets.AleAssets;

class AleMainState extends FlxState
{
    final initialState:NextState;

    public function new(initialState:NextState)
    {
        super();

        this.initialState = initialState;
    }

    override function create()
    {
        init();

        AleG.switchState(initialState);
    }

    function init()
    {
        AleAssets.init();
    }
}