package ale.flx.interfaces;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

interface IAleGroup<K:FlxBasic>
{
    public function addBehind<T:K>(target:K, obj:T):T;
    public function addAhead<T:K>(target:K, obj:T):T;

    public function addBehindGroup<T:K>(group:FlxTypedGroup<K>, obj:T):T;
    public function addAheadGroup<T:K>(group:FlxTypedGroup<K>, obj:T):T;

    public function typedAdd<T:K>(obj:T):T;
    public function typedInsert<T:K>(index:Int, obj:T):T;
}