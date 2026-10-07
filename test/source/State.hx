package;

import ale.ui.objects.*;

class State extends AleState
{
    var sprite:AleSprite;

    var text:AleText;

    override function create()
    {
        super.create();

        typedAdd(new Button(1, 1));
        typedAdd(new CheckBox(1, 3));
        typedAdd(new DropDownMenu(1, 5, ['a', 'b', 'c']));
        typedAdd(new InputText(1, 7));
        typedAdd(new NumericStepper(1, 9));
        typedAdd(new Slider(1, 11));
        typedAdd(new Tab(1, 13));
        typedAdd(new MultiTab(10, 13, ['a', 'b', 'c']));
    }
}