package ale.flixel;

import openfl.display.Sprite;

class AleMain extends Sprite
{
    public function new()
    {
        super();

        addChild(new AleGame());
    }
}