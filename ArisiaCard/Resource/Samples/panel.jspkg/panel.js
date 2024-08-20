"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/panel.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("buttons", "o(Box)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["buttons", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: Box */
    let buttons = _alloc_Box();
    /* define type for all properties */
    buttons._definePropertyType("axis", "e(Axis)");
    buttons._definePropertyType("load_button", "o(Button)");
    buttons._definePropertyType("save_button", "o(Button)");
    buttons._definePropertyType("quit_button", "o(Button)");
    buttons._definePropertyType("alignment", "e(Alignment)");
    buttons._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(buttons, ["axis", "load_button", "save_button", "quit_button", "alignment", "distribution"]);
    /* assign user declared properties */
    buttons.axis = Axis.vertical;
    {
        /* allocate function for frame: Button */
        let load_button = _alloc_Button();
        /* define type for all properties */
        load_button._definePropertyType("title", "s");
        load_button._definePropertyType("pressed", "f(v,[o(root_buttons_load_button_ButtonIF)])");
        load_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(load_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        load_button.title = "Load";
        load_button.pressed = function (self) {
            let url = openPanel("Select file to load", FileType.file, ["js"]);
            if (url != null) {
                console.log("load file from " + url.path);
            }
        };
        buttons.load_button = load_button;
    }
    {
        /* allocate function for frame: Button */
        let save_button = _alloc_Button();
        /* define type for all properties */
        save_button._definePropertyType("title", "s");
        save_button._definePropertyType("pressed", "f(v,[o(root_buttons_save_button_ButtonIF)])");
        save_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(save_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        save_button.title = "Save";
        save_button.pressed = function (self) {
            let url = savePanel("Select file to load");
            if (url != null) {
                console.log("save file to " + url.path);
            }
        };
        buttons.save_button = save_button;
    }
    {
        /* allocate function for frame: Button */
        let quit_button = _alloc_Button();
        /* define type for all properties */
        quit_button._definePropertyType("title", "s");
        quit_button._definePropertyType("pressed", "f(v,[o(root_buttons_quit_button_ButtonIF)])");
        quit_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(quit_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        quit_button.title = "Quit";
        quit_button.pressed = function (self) {
            leaveView(0);
        };
        buttons.quit_button = quit_button;
    }
    root.buttons = buttons;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
