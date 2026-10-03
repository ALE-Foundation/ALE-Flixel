package;

import ale.flixel.AleMain;

class Main extends AleMain
{
    override function init()
    {
        addChild(960, 720, State.new);
    }
}