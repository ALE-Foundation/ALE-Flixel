package ale.flx;

import openfl.display.Sprite;

class AleMain extends Sprite
{
    public function new()
    {
        super();

        init();
    }

    public function init()
        addChild(new AleGame());
}