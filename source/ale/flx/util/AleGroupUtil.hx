package ale.flx.util;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

class AleGroupUtil
{
    public static inline function addBehind<K:FlxBasic, T:K>(group:FlxTypedGroup<K>, target:K, obj:T):T
        return typedInsert(group, group.members.indexOf(target), obj);

    public static inline function addAhead<K:FlxBasic, T:K>(group:FlxTypedGroup<K>, target:K, obj:T):T
        return typedInsert(group, group.members.indexOf(target) + 1, obj);

    public static inline function addBehindGroup<K:FlxBasic, T:K, G:K>(group:FlxTypedGroup<K>, targetGroup:FlxTypedGroup<G>, obj:T):T
        return addBehind(group, targetGroup.members[0], obj);

    public static inline function addAheadGroup<K:FlxBasic, T:K, G:K>(group:FlxTypedGroup<K>, targetGroup:FlxTypedGroup<G>, obj:T):T
        return addAhead(group, targetGroup.members[targetGroup.members.length - 1], obj);

    public static inline function typedAdd<K:FlxBasic, T:K>(group:FlxTypedGroup<K>, obj:T):T
        return cast group.add(obj);

    public static inline function typedInsert<K:FlxBasic, T:K>(group:FlxTypedGroup<K>, index:Int, obj:T):T
        return cast group.insert(index, obj);
}