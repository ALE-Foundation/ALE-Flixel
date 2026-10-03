package ale.flixel.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;

enum Define
{
    MODDING;
}

class DefinesMacro
{
    static function define(def:Define, ?force:Bool = false, ?ifCond:Array<String>, ?ifNotCond:Array<String>)
    {
        if (force || !Context.defined('ALE_FLX_NO_' + Std.string(def)))
        {
            if (ifCond != null)
                for (cond in ifCond)
                    if (!Context.defined(cond))
                        return;

            if (ifNotCond != null)
                for (cond in ifNotCond)
                    if (Context.defined(cond))
                        return;

            Compiler.define('ALE_FLX_' + Std.string(def), null);
        }
    }

    public static function init()
    {
        define(MODDING, false, ['sys']);
    }
}
