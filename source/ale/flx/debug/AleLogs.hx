package ale.flx.debug;

import ale.flx.utils.AleColorUtil.colorToAnsi;

import flixel.util.FlxColor;

#if !sys
import haxe.Log;
#end

class AleLogs
{
    static var config:Map<String, AleLogsConfig>;

    static function init()
        config = [
            AleLogsType.ERROR => {
                title: 'ERROR',
                color: 0xFFFF5555
            },
            AleLogsType.WARNING => {
                title: 'WARNING',
                color: 0xFFFFA500
            },
            AleLogsType.DEPRECATED => {
                title: 'DEPRECATED',
                color: 0xFF8000
            },
            AleLogsType.TRACE => {
                title: 'TRACE',
                color: 0xFFFFFFFF
            },
            AleLogsType.MISSING_FILE => {
                title: 'MISSING FILE',
                color: 0xFFFF7F00
            },
            AleLogsType.MISSING_FOLDER => {
                title: 'MISSING FOLDER',
                color: 0xFFFF7F00
            }
        ];

    public static function print(msg:Dynamic, ?type:String = AleLogsType.TRACE):String
    {
        final message:StringBuf = new StringBuf();
        
        final data:AleLogsConfig = config[type] ?? config[AleLogsType.TRACE];

        message.add(colorToAnsi(data.title, data.color));
        message.add(colorToAnsi(' | ', FlxColor.GRAY));
        message.add(msg);

        final result:String = message.toString();

        #if sys
        Sys.println(result);
        #else
        haxe.Log.trace(result, null);
        #end

        return result;
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