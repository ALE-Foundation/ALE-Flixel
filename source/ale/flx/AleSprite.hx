package ale.flx;

import flixel.util.typeLimit.OneOfTwo;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;

import ale.flx.assets.AleAssets;

class AleSprite extends FlxSprite
{
    public function new(?x:Float, ?y:Float, ?graphic:OneOfTwo<String, FlxGraphic>)
        super(x, y, graphic == null ? null : graphic is FlxGraphic ? cast graphic : AleAssets.image(graphic));
}