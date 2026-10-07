package;

import ale.ui.objects.*;

class State extends AleState
{
    var sprite:AleSprite;

    var text:AleText;

    override function create()
    {
        super.create();

        typedAdd(new Button());
        typedAdd(new CheckBox());
        typedAdd(new DropDownMenu(0, 0, ['a', 'b', 'c']));
        typedAdd(new InputText());
        typedAdd(new MultiTab(0, 0, ['a', 'b', 'c']));
        typedAdd(new NumericStepper());
        typedAdd(new Slider());
        typedAdd(new Tab());
    }
}