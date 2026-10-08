package ale.flx.config;

import flixel.util.typeLimit.NextState;
import flixel.FlxState;

import ale.flx.AleG;

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
        super.create();

        AleG.main.postReset();

        AleG.switchState(initialState);
    }
}