package ale.flx.debug;

import ale.flx.util.AleColorUtil.colorToAnsi;

import flixel.util.FlxColor;
import flixel.FlxG;

#if !sys
import haxe.Log;
#end

class AleLogs
{
    static var config:Map<String, AleLogsConfig>;

    @:allow(ale.flx.config.AleMain)
    static function init()
        config = [
            ERROR => {
                title: 'ERROR',
                color: 0xFFFF5555
            },
            WARNING => {
                title: 'WARNING',
                color: 0xFFFFA500
            },
            DEPRECATED => {
                title: 'DEPRECATED',
                color: 0xFF8000
            },
            TRACE => {
                title: 'TRACE',
                color: 0xFFFFFFFF
            },
            MISSING_FILE => {
                title: 'MISSING FILE',
                color: 0xFFFF7F00
            },
            MISSING_FOLDER => {
                title: 'MISSING FOLDER',
                color: 0xFFFF7F00
            }
        ];

    public static function print(msg:Dynamic, ?type:String = TRACE):String
    {
        final data:AleLogsConfig = config[type] ?? config[TRACE];

        final result:String = colorToAnsi(data.title, data.color) + colorToAnsi(' | ', FlxColor.GRAY) + msg;

        #if sys
        Sys.println(result);
        #else
        haxe.Log.trace(result, null);
        #end

        return result;
    }

    public static function popUp(title:String, message:String, ?type:String)
    {
        print(title + ' | ' + message, type);

        FlxG.stage.window.alert(message, title);
    }
}

typedef AleLogsConfig = {
    ?title:String,
    ?color:FlxColor
}

enum abstract AleLogsType(String) from String to String
{
    var TRACE = 'trace';
    var ERROR = 'error';
    var WARNING = 'warning';
    var MISSING_FILE = 'missing_file';
    var MISSING_FOLDER = 'missing_folder';
    var DEPRECATED = 'deprecated';
}