package;

import ale.flx.AleSprite;
import ale.flx.AleState;

class State extends AleState
{
    var sprite:AleSprite;

    override function create()
    {
        super.create();

        sprite = new AleSprite('oso');
        add(sprite);
    }
}