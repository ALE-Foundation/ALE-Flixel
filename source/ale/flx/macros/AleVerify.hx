package ale.flx.macros;

import haxe.macro.Context;

class AleVerify
{
    public static function init(main:String)
        Context.onAfterTyping(_ -> {
            final type = try Context.getType(main) catch (e:Dynamic) return;

            switch (type)
            {
                case TInst(ref, _):
                    var cl = ref.get();

                    while (cl != null)
                    {
                        if (cl.pack.concat([cl.name]).join('.') == 'ale.flx.config.AleMain')
                            return;

                        cl = cl.superClass != null ? cl.superClass.t.get() : null;
                    }

                default:
            }

            throw 'Main must extend ale.flx.config.AleMain';
        });
}