package ale.flx.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;

enum Define
{
    MODDING;
}

class AleDefines
{
    static function define(def:Define, ?force:Bool = false, ?ifCond:Array<String>, ?ifNotCond:Array<String>)
    {
        final noDefine:String = 'ALE_FLX_NO_' + Std.string(def);

        if (force || !Context.defined(noDefine))
        {
            if (ifCond != null)
                for (cond in ifCond)
                    if (!Context.defined(cond))
                    {
                        Compiler.define(noDefine, null);

                        return;
                    }

            if (ifNotCond != null)
                for (cond in ifNotCond)
                    if (Context.defined(cond))
                    {
                        Compiler.define(noDefine, null);

                        return;
                    }

            Compiler.define('ALE_FLX_' + Std.string(def), null);
        }
    }

    public static function init()
    {
        define(MODDING, false, ['sys']);
    }
}
