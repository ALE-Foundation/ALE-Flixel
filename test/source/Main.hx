package;

import ale.flx.AleMain;
import ale.flx.AleGame;

class Main extends AleMain
{
    override function init()
    {
        addChild(new AleGame(960, 720, State.new));
    }
}