package ale.flx.modding;

#if ALE_FLX_MODDING
@:build(ale.flx.macros.AleConfigurable.build())
class AleModdingConfig
{
    public static var PACKAGES:Array<String> = [
        'flixel.group',
        'flixel.graphics',
        'flixel.effects',
        'flixel.tweens',
        'flixel.text',
        'flixel',

        #if flixel_animate
        'animate',
        #end

        #if flixel_addons
        'flixel.addons.display'
        #end
    ];

    public static var IGNORE_PACKAGES:Array<String> = [];

    public static var CLASSES:Array<String> = [
        'openfl.display.Sprite',
        'openfl.text.TextField'
    ];

    public static var IGNORE_CLASSES:Array<String> = [
        'flixel.group.FlxSpriteContainer',
        'flixel.system.FlxAutoVersion',
        'flixel.FlxGame',
        'animate.FlxAnimateAssets'
    ];

    public static var FORCED_OVERRIDES:Array<String> = [];

    public static var IGNORE_FORCED_OVERRIDES:Array<String> = [];
}
#end