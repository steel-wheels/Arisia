"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/console-view.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("console", "o(ConsoleView)");
root._definePropertyType("buttons", "o(Box)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["console", "buttons", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: ConsoleView */
    let console = _alloc_ConsoleView();
    /* define type for all properties */
    console._definePropertyType("error", "f(v,[s])");
    console._definePropertyType("height", "n");
    console._definePropertyType("console", "i(ConsoleIF)");
    console._definePropertyType("width", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(console, ["error", "height", "console", "width"]);
    root.console = console;
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
            let cons = root.console.console;
            cons.print("Hello.\n");
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
