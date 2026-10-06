package ale.flx.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

class AleOverrides
{
    public static function init()
        for (cls in [
            'flixel.FlxSprite',
            'flixel.text.FlxText'
        ])
            Compiler.addGlobalMetadata(cls, '@:build(ale.flx.macros.AleOverrides.build())', true);

    macro public static function build():Array<Field>
    {
        var fields = Context.getBuildFields();

        final localType = Context.getLocalType();

        switch (localType)
        {
            case TInst(_, _):

            default:
                return fields;
        }

        final cls = Context.getLocalClass().get();
        
        final fullName = cls.pack.join('.') + '.' + cls.name;

        switch (fullName)
        {
            case 'flixel.FlxSprite':
                for (f in fields)
                {
                    switch (f.name)
                    {
                        case 'checkEmptyFrame':
                            f.kind = FFun({
                                args: [],
                                ret: macro:Void,
                                expr: macro {
                                    if (_frame == null)
                                    {
                                        loadGraphic('ale/flixel/images/_default.png');
                                    } else if (graphic != null && graphic.isDestroyed) {
                                        final width = this.width;
                                        final height = this.height;

                                        flixel.FlxG.log.error('Cannot render a destroyed graphic, the placeholder image will be used instead');

                                        loadGraphic('ale/flixel/images/_default.png');

                                        this.width = width;
                                        this.height = height;
                                    }
                                }
                            });

                        case 'set_angle':
                            f.kind = FFun({
                                args: [{name: 'value', type: macro:Float}],
                                ret: macro:Float,
                                expr: macro {
                                    final newAngle:Bool = angle != value;

                                    final res:Float = super.set_angle(value);

                                    if (newAngle)
                                    {
                                        _angleChanged = true;

                                        animation?.update(0);
                                    }

                                    return res;
                                }
                            });
                    }
                }
        }

        return fields;
    }
}