package ale.flx;

import ale.flx.assets.AleAssets;
import ale.flx.config.AleMain;

import flixel.FlxG;

class AleG
{
    public static var game(get, never):AleGame;
    static function get_game():AleGame
        return cast FlxG.game;

    public static var main(get, never):AleMain;
    static function get_main():AleMain
        return AleMain.instance;

    public static function switchState(state)
        FlxG.switchState(state);

    public static function reset()
    {
        main.preReset();

        FlxG.resetGame();
    }
}