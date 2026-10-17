package ale.flx.settings;

#if ALE_FLX_MODDING
class AleModdingSettings
{
    public static final PACKAGES:Array<String> = [];
    public static final OVERRIDE_PACKAGES:Bool = false;

    public static final IGNORE_PACKAGES:Array<String> = [];
    public static final OVERRIDE_IGNORE_PACKAGES:Bool = false;


    public static final CLASSES:Array<String> = [];
    public static final OVERRIDE_CLASSES:Bool = false;

    public static final IGNORE_CLASSES:Array<String> = [];
    public static final OVERRIDE_IGNORE_CLASSES:Bool = false;


    public static final FORCED_OVERRIDES:Array<String> = [];
    public static final OVERRIDE_FORCED_OVERRIDES:Bool = false;

    public static final IGNORE_FORCED_OVERRIDES:Array<String> = [];
    public static final OVERRIDE_IGNORE_FORCED_OVERRIDES:Bool = false;
}
#end