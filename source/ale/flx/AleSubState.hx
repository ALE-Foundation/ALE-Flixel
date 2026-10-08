package ale.flx;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSubState;
import flixel.FlxBasic;
import flixel.FlxG;

import ale.flx.util.AleGroupUtil;

class AleSubState extends FlxSubState implements ale.flx.interfaces.IAleState
{
    public var subCamera:AleCamera;

    var allowCamerasInit:Bool = true;

    var allowCamerasOverriding:Bool = true;

    override function create()
    {
        super.create();

        if (allowCamerasInit)
            initCameras();
    }

    function initCameras()
		FlxG.cameras.add(subCamera = new AleCamera(), false);

    override function add(obj:FlxBasic):FlxBasic
    {
        if (subCamera != null && allowCamerasOverriding)
            obj.camera = subCamera;

        return super.add(obj);
    }

	override function destroy()
	{
        FlxG.cameras.remove(subCamera, true);
        
		super.destroy();
	}

    public inline function addBehind<T:FlxBasic>(target:FlxBasic, obj:T):T
        return AleGroupUtil.addBehind(this, target, obj);

    public inline function addAhead<T:FlxBasic>(target:FlxBasic, obj:T):T
        return AleGroupUtil.addAhead(this, target, obj);

    public inline function addBehindGroup<T:FlxBasic>(group:FlxTypedGroup<FlxBasic>, obj:T):T
        return AleGroupUtil.addBehindGroup(this, group, obj);

    public inline function addAheadGroup<T:FlxBasic>(group:FlxTypedGroup<FlxBasic>, obj:T):T
        return AleGroupUtil.addAheadGroup(this, group, obj);

    public inline function typedAdd<T:FlxBasic>(obj:T):T
        return AleGroupUtil.typedAdd(this, obj);

    public inline function typedInsert<T:FlxBasic>(index:Int, obj:T):T
        return AleGroupUtil.typedInsert(this, index, obj);
}