"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/textedit.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("edit", "o(TextEdit)");
root._definePropertyType("buttons", "o(Box)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["edit", "buttons", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: TextEdit */
    let edit = _alloc_TextEdit();
    /* define type for all properties */
    edit._definePropertyType("isEditable", "b");
    edit._definePropertyType("main", "f(v,[o(root_edit_TextEditIF)])");
    edit._definePropertyType("terminal", "i(EscapeCodesIF)");
    /* define getter/setter for all properties */
    _definePropertyIF(edit, ["isEditable", "main", "terminal"]);
    /* assign user declared properties */
    edit.isEditable = true;
    edit.main = function (self) {
        let term = root.edit.terminal;
        term.string("Hello, from init.");
        term.execute();
    };
    root.edit = edit;
}
{
    /* allocate function for frame: Box */
    let buttons = _alloc_Box();
    /* define type for all properties */
    buttons._definePropertyType("axis", "e(Axis)");
    buttons._definePropertyType("write_button", "o(Button)");
    buttons._definePropertyType("ok_button", "o(Button)");
    buttons._definePropertyType("alignment", "e(Alignment)");
    buttons._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(buttons, ["axis", "write_button", "ok_button", "alignment", "distribution"]);
    /* assign user declared properties */
    buttons.axis = Axis.horizontal;
    {
        /* allocate function for frame: Button */
        let write_button = _alloc_Button();
        /* define type for all properties */
        write_button._definePropertyType("title", "s");
        write_button._definePropertyType("pressed", "f(v,[o(root_buttons_write_button_ButtonIF)])");
        write_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(write_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        write_button.title = "Write";
        write_button.pressed = function (self) {
            let term = root.edit.terminal;
            term.string("Hello, ");
            term.foregroundColor(Colors.yellow);
            term.backgroundColor(Colors.black);
            term.string("Good morning");
            term.setFontStyle(FontStyle.monospace);
            term.string("Good evening");
            term.execute();
        };
        buttons.write_button = write_button;
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
/* execute initializer methods for frame edit */
root.edit.main(root.edit);
/* This value will be return value of evaluateScript() */
root;
