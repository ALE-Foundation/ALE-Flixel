package ale.flixel;

import ale.flixel.assets.AleAssets;

import flixel.FlxG;

class AleG
{
    public static var game(get, never):AleGame;

    static function get_game():AleGame
        return cast FlxG.game;

    public static function switchState(state)
        FlxG.switchState(state);
}