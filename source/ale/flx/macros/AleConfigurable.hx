package ale.flx.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.TypeTools;
using haxe.macro.ComplexTypeTools;
#end

class AleConfigurable
{
    public static function merge<T>(def:Array<T>, custom:Array<T>, overr:Bool):Array<T>
        return overr ? custom : def.concat(custom);

    #if macro
    public static function build(?prefix:String = 'OVERRIDE_', ?suffix:String = '_SETTINGS'):Array<Field>
    {
        final cls = Context.getLocalClass().get();

        final parts = cls.pack.copy();
        parts.push(cls.name + suffix);

        var settings:ClassType = null;

        try
        {
            switch (Context.getType(parts.join('.')))
            {
                case TInst(c, _):
                    settings = c.get();

                default:
            }
        } catch (_) {}

        final fields = Context.getBuildFields();

        if (settings == null)
            return fields;

        function find(name:String):Null<ClassField>
        {
            for (s in settings.statics.get())
                if (s.name == name)
                    return s;

            return null;
        }

        final boolType = Context.getType('Bool');
        final res:Array<Field> = [];

        for (f in fields)
        {
            switch (f.kind)
            {
                case FVar(t, expr) if (expr != null && f.access != null && f.access.contains(AStatic)):
                    final custom = find(f.name);
                    final type = t != null ? t.toType() : Context.typeof(expr);

                    if (custom == null || !Context.unify(custom.type, type))
                    {
                        res.push(f);

                        continue;
                    }

                    final ovr = find(prefix + f.name);

                    final overrExpr:Expr = ovr != null && Context.unify(ovr.type, boolType) ? macro $p{parts.concat([prefix + f.name])} : macro false;

                    final customExpr:Expr = macro $p{parts.concat([f.name])};

                    final ct = t != null ? t : type.toComplexType();

                    res.push({
                        name: f.name,
                        doc: f.doc,
                        meta: f.meta,
                        pos: f.pos,
                        access: f.access,
                        kind: FProp('get', 'null', ct)
                    });

                    res.push({
                        name: 'get_' + f.name,
                        pos: f.pos,
                        access: [AStatic],
                        kind: FFun({
                            args: [],
                            ret: ct,
                            expr: macro return $i{f.name} ??= ale.flx.macros.AleConfigurable.merge($expr, $customExpr, $overrExpr)
                        })
                    });

                default:
                    res.push(f);
            }
        }

        return res;
    }
    #end
}