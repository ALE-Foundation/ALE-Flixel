package;

class State extends AleState
{
    var sprite:AleSprite;

    var text:AleText;

    override function create()
    {
        super.create();

        sprite = typedAdd(new AleSprite('oso'));

        text = new AleText(10, sprite.height + 20, 'Masha', 0, 60, FlxColor.CYAN, 'amaticSC.ttf');
        add(text);

        // Non-existing Font
        AleAssets.font('masha');

        // Non-existing Image
        AleAssets.image('masha');

        print('Hello World!');
    }
}