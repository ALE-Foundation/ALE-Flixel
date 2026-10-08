package ale.flx.interfaces;

import flixel.FlxBasic;

interface IAleState extends IAleGroup<FlxBasic>
{
    private var allowCamerasInit:Bool;

    private function initCameras():Void;
}