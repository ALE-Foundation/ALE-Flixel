package ale.flx.text;

import ale.flx.assets.AleAssets;

import flixel.util.FlxColor;
import flixel.text.FlxText;

class AleText extends FlxText
{
    public function new(?x:Float, ?y:Float, ?text:String, ?fieldWith:Float, ?size:Int, ?color:FlxColor, ?font:String, ?borderStyle:FlxTextBorderStyle, ?borderColor:FlxColor, ?borderSize:Float)
    {
        super(x, y, fieldWith, text, size);

        if (color != null)
            this.color = color;

        if (font != null)
            this.font = AleAssets.font(font);

        if (borderStyle != null)
            setBorderStyle(borderStyle, borderColor, borderSize);
    }
}