package ale.flx.group;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

import ale.flx.util.AleGroupUtil;

class AleTypedGroup<K:FlxBasic> extends FlxTypedGroup<K>
{
    public inline function addBehind<T:K>(target:K, obj:T):T
        return AleGroupUtil.addBehind(this, target, obj);

    public inline function addAhead<T:K>(target:K, obj:T):T
        return AleGroupUtil.addAhead(this, target, obj);

    public inline function addBehindGroup<T:K>(group:FlxTypedGroup<K>, obj:T):T
        return AleGroupUtil.addBehindGroup(this, group, obj);

    public inline function addAheadGroup<T:K>(group:FlxTypedGroup<K>, obj:T):T
        return AleGroupUtil.addAheadGroup(this, group, obj);

    public inline function typedAdd<T:K>(obj:T):T
        return AleGroupUtil.typedAdd(this, obj);

    public inline function typedInsert<T:K>(index:Int, obj:T):T
        return AleGroupUtil.typedInsert(this, index, obj);
}