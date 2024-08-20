"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/console-view.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("consoles", "o(Box)");
root._definePropertyType("buttons", "o(Box)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["consoles", "buttons", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: Box */
    let consoles = _alloc_Box();
    /* define type for all properties */
    consoles._definePropertyType("axis", "e(Axis)");
    consoles._definePropertyType("blue", "o(ConsoleView)");
    consoles._definePropertyType("green", "o(ConsoleView)");
    consoles._definePropertyType("alignment", "e(Alignment)");
    consoles._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(consoles, ["axis", "blue", "green", "alignment", "distribution"]);
    /* assign user declared properties */
    consoles.axis = Axis.horizontal;
    {
        /* allocate function for frame: ConsoleView */
        let blue = _alloc_ConsoleView();
        /* define type for all properties */
        blue._definePropertyType("width", "n");
        blue._definePropertyType("height", "n");
        blue._definePropertyType("error", "f(v,[s])");
        blue._definePropertyType("console", "i(ConsoleIF)");
        /* define getter/setter for all properties */
        _definePropertyIF(blue, ["width", "height", "error", "console"]);
        /* assign user declared properties */
        blue.width = 20;
        blue.height = 15;
        consoles.blue = blue;
    }
    {
        /* allocate function for frame: ConsoleView */
        let green = _alloc_ConsoleView();
        /* define type for all properties */
        green._definePropertyType("width", "n");
        green._definePropertyType("height", "n");
        green._definePropertyType("error", "f(v,[s])");
        green._definePropertyType("console", "i(ConsoleIF)");
        /* define getter/setter for all properties */
        _definePropertyIF(green, ["width", "height", "error", "console"]);
        /* assign user declared properties */
        green.width = 20;
        green.height = 15;
        consoles.green = green;
    }
    root.consoles = consoles;
}
{
    /* allocate function for frame: Box */
    let buttons = _alloc_Box();
    /* define type for all properties */
    buttons._definePropertyType("axis", "e(Axis)");
    buttons._definePropertyType("hello_button", "o(Button)");
    buttons._definePropertyType("ok_button", "o(Button)");
    buttons._definePropertyType("alignment", "e(Alignment)");
    buttons._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(buttons, ["axis", "hello_button", "ok_button", "alignment", "distribution"]);
    /* assign user declared properties */
    buttons.axis = Axis.horizontal;
    {
        /* allocate function for frame: Button */
        let hello_button = _alloc_Button();
        /* define type for all properties */
        hello_button._definePropertyType("title", "s");
        hello_button._definePropertyType("pressed", "f(v,[o(root_buttons_hello_button_ButtonIF)])");
        hello_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(hello_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        hello_button.title = "Hello";
        hello_button.pressed = function (self) {
            root.consoles.blue.console.print("Hello from blue\n");
            root.consoles.green.console.print("Hello from green\n");
        };
        buttons.hello_button = hello_button;
    }
    {
        /* allocate function for frame: Button */
        let ok_button = _alloc_Button();
        /* define type for all properties */
        ok_button._definePropertyType("title", "s");
        ok_button._definePropertyType("pressed", "f(v,[o(root_buttons_ok_button_ButtonIF)])");
        ok_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(ok_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        ok_button.title = "OK";
        ok_button.pressed = function (self) {
            leaveView(0);
        };
        buttons.ok_button = ok_button;
    }
    root.buttons = buttons;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
