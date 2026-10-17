package ale.flx.modding;

import ale.flx.settings.AleModdingSettings as AleMS;

#if ALE_FLX_MODDING
@:unreflective
class AleModdingConfig
{
    public static var PACKAGES(get, null):Array<String>;
    static function get_PACKAGES():Array<String>
        return PACKAGES ??= merge([
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
        ], AleMS.PACKAGES, AleMS.OVERRIDE_PACKAGES);

    public static var IGNORE_PACKAGES(get, null):Array<String>;
    static function get_IGNORE_PACKAGES():Array<String>
        return IGNORE_PACKAGES ??= merge([], AleMS.IGNORE_PACKAGES, AleMS.OVERRIDE_IGNORE_PACKAGES);


    public static var CLASSES(get, null):Array<String>;
    static function get_CLASSES():Array<String>
        return CLASSES ??= merge([
            'openfl.display.Sprite',
            'openfl.text.TextField'
        ], AleMS.CLASSES, AleMS.OVERRIDE_CLASSES);

    public static var IGNORE_CLASSES(get, null):Array<String>;
    static function get_IGNORE_CLASSES():Array<String>
        return IGNORE_CLASSES ??= merge([
            'flixel.group.FlxSpriteContainer',
            'flixel.system.FlxAutoVersion',
            'flixel.FlxGame',

            'animate.FlxAnimateAssets'
        ], AleMS.IGNORE_CLASSES, AleMS.OVERRIDE_IGNORE_CLASSES);


    public static var FORCED_OVERRIDES(get, null):Array<String>;
    static function get_FORCED_OVERRIDES():Array<String>
        return FORCED_OVERRIDES ??= merge([], AleMS.FORCED_OVERRIDES, AleMS.OVERRIDE_FORCED_OVERRIDES);

    public static var IGNORE_FORCED_OVERRIDES(get, null):Array<String>;
    static function get_IGNORE_FORCED_OVERRIDES():Array<String>
        return IGNORE_FORCED_OVERRIDES ??= merge([], AleMS.IGNORE_FORCED_OVERRIDES, AleMS.OVERRIDE_IGNORE_FORCED_OVERRIDES);


    @:noPrivateAccess
    static function merge(def:Array<String>, custom:Array<String>, overr:Bool):Array<String>
        return overr ? custom : def.concat(custom);
}
#end