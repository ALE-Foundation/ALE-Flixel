package ale.flx.utils;

import flixel.util.FlxColor;

class AleColorUtil
{
    public static inline function colorToAnsi(text:String, color:FlxColor):String
		return rgbToAnsi(text, color.red, color.green, color.blue);

	public static inline function rgbToAnsi(text:String, r:Int, g:Int, b:Int)
		return '\x1b[38;2;' + r + ';' + g + ';' + b + 'm' + text + '\x1b[0m';
}