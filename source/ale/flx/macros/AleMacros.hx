package ale.flx.macros;

class AleMacros
{
    public static function init(main:String)
    {
        AleDefines.init();
        AleOverrides.init();
        AleVerify.init(main);
    }
}