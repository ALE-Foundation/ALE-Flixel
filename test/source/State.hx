package;

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