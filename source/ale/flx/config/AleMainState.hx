package ale.flx.config;

import flixel.util.typeLimit.NextState;
import flixel.FlxSprite;
import flixel.FlxState;

import ale.flx.assets.AleAssets;
import ale.flx.debug.AleLogs;

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

    @:access(ale.flx.debug.AleLogs)
    @:access(ale.flx.assets.AleAssets)
    function init()
    {
        FlxSprite.defaultAntialiasing = true;

        AleAssets.init();

        AleLogs.init();

        #if ale_ui
        ale.ui.Config.reset();
        ale.ui.Config.FONT = 'ale/ui/fonts/montserrat.ttf';
        #end
    }
}