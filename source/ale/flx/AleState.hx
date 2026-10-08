package ale.flx;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import flixel.FlxBasic;

import ale.flx.assets.AleAssets;

class AleState extends FlxState
{
    public function addBehind(target:FlxBasic, obj:FlxBasic):FlxBasic
    {
        insert(members.indexOf(target), obj);

        return obj;
    }

    public function addAhead(target:FlxBasic, obj:FlxBasic):FlxBasic
    {
        insert(members.indexOf(target) + 1, obj);

        return obj;
    }

    public function addBehindGroup<T:FlxBasic>(group:FlxTypedGroup<T>, obj:FlxBasic):FlxBasic
        return addBehind(group.members[0], obj);

    public function addAheadGroup<T:FlxBasic>(group:FlxTypedGroup<T>, obj:FlxBasic):FlxBasic
        return addAhead(group.members[group.members.length - 1], obj);

    public function typedAdd<T:FlxBasic>(obj:T):T
        return cast add(obj);

    public var allowMemoryCleaning:Bool = true;

    override function destroy()
    {
        super.destroy();

        AleAssets.clear(allowMemoryCleaning);
    }
}