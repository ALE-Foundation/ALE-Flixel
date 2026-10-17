package;

import ale.flx.AleSubState;
import ale.flx.AleState;

import ale.flx.group.AleTypedGroup;
import ale.flx.group.AleGroup;

import ale.flx.modding.AleModdingConfig;

class State extends AleState
{
    override function create()
    {
        super.create();

        trace(AleModdingConfig.PACKAGES);
    }
}