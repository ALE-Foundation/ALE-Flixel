package;

import ale.flixel.AleSprite;
import ale.flixel.AleState;

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