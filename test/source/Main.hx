package;

import ale.flixel.AleMain;
import ale.flixel.AleGame;

class Main extends AleMain
{
    override function init()
    {
        addChild(new AleGame(960, 720, State.new));
    }
}