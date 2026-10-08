package;

import ale.flx.config.AleMain;

class Main extends AleMain
{
    override function init()
        addChild(new AleGame(960, 720, State.new));
}