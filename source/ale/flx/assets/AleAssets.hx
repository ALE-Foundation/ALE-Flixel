package ale.flx.assets;

import ale.flx.debug.AleLogs;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;

import openfl.display.BitmapData;
import openfl.utils.Assets;
import openfl.media.Sound;

import lime.utils.Bytes;

class AleAssets
{
    public static var library(get, set):AleAssetsLibrary;

    static function get_library():AleAssetsLibrary
        return cast Assets.getLibrary('default');

    static function set_library(lib:AleAssetsLibrary):AleAssetsLibrary
    {
        Assets.registerLibrary('default', lib);

        return lib;
    }

    public static var config(default, null):Map<String, AleAssetsConfig<Dynamic>>;

    @:access(openfl.display.BitmapData)
    static function init()
    {
        library = new AleAssetsLibrary(['assets']);

        config = [];

        final image:AleAssetsConfig<FlxGraphic> = {
            prefix: 'images/',
            suffix: '.png',
            get: (path, _) -> {
                final img = library.getImage(path);

                if (img == null)
                    return null;

                final btm = BitmapData.fromImage(img);

                if (btm.image != null && FlxG.stage.context3D != null)
                {
                    btm.lock();
                    btm.getTexture(FlxG.stage.context3D);
                    btm.getSurface();
                    btm.disposeImage();

                    btm.image.data = null;
                    btm.image = null;
                    
                    btm.readable = true;
                }

                final grp:FlxGraphic = FlxGraphic.fromBitmapData(btm, false, path);
                grp.persist = true;
                grp.destroyOnNoUse = false;

                return grp;
            }
        };

        config[IMAGE] = image;

        final font:AleAssetsConfig<String> = {
            prefix: 'fonts/',
            get: (path, _) -> path
        };

        config[FONT] = font;
    }

    public static function getPath(path:String):String
        return library.getPath(path);
    
    public static function exists(path:String):Bool
        return library.exists(path, null);

    public static function getContent(path:String):String
        return library.getText(path);

    public static function getBytes(path:String):Bytes
        return library.getBytes(path);

    public static function get(file:String, type:String, persist:Bool = false, missingPrint:Bool = true, ?args:Array<Dynamic>, ?cache:Bool = true):Dynamic
    {
        final data = config[type];

        if (data == null)
            return null;

        data.suffix ??= '';
        data.prefix ??= '';
        data.check ??= true;
        data.cache ??= [];

        final path:String = data.prefix + file + data.suffix;

        if (data.cache.exists(path))
            return data.cache[path].content;

        if (data.check && !exists(path))
        {
            if (missingPrint)
                AleLogs.print(path, MISSING_FILE);

            return null;
        }

        final res = data.get(path, args);

        if (cache && res != null)
            data.cache[path] = {
                content: res,
                persist: persist
            };

        return res;
    }

    public static function image(path:String, ?persist:Bool, ?missingPrint:Bool):FlxGraphic
        return get(path, IMAGE, missingPrint, persist);

    public static function audio(path:String, ?persist:Bool, ?missingPrint:Bool):Sound
        return get(path, AUDIO, missingPrint, persist);

    public static function sound(path:String, ?persist:Bool, ?missingPrint:Bool):Sound
        return audio('sounds/' + path, persist, missingPrint);

    public static function music(path:String, ?persist:Bool, ?missingPrint:Bool):Sound
        return audio('music/' + path, persist, missingPrint);

    public static function font(path:String, ?persist:Bool, ?missingPrint:Bool):String
        return get(path, FONT, persist, missingPrint);
}


typedef AleAssetsConfig<T> = {
    ?suffix:String,
    ?prefix:String,
    ?check:Bool,
    ?cache:Map<String, AleAssetsCache<T>>,
    get:String -> Null<Array<Dynamic>> -> T
}

typedef AleAssetsCache<T> = {
    content:T,
    ?persist:Bool
}


enum abstract AleAssetType(String) from String to String
{
    var IMAGE = 'image';
    var FONT = 'font';
    var AUDIO = 'sound';
}