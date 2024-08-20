"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/textfield.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("edit", "o(TextField)");
root._definePropertyType("ok_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["edit", "ok_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: TextField */
    let edit = _alloc_TextField();
    /* define type for all properties */
    edit._definePropertyType("isEditable", "b");
    edit._definePropertyType("hasBackgroundColor", "b");
    edit._definePropertyType("text", "s");
    edit._definePropertyType("number", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(edit, ["isEditable", "hasBackgroundColor", "text", "number"]);
    /* assign user declared properties */
    edit.isEditable = true;
    edit.hasBackgroundColor = true;
    edit.text = "hello";
    root.edit = edit;
}
{
    /* allocate function for frame: Button */
    let ok_button = _alloc_Button();
    /* define type for all properties */
    ok_button._definePropertyType("title", "s");
    ok_button._definePropertyType("pressed", "f(v,[o(root_ok_button_ButtonIF)])");
    ok_button._definePropertyType("isEnabled", "b");
    /* define getter/setter for all properties */
    _definePropertyIF(ok_button, ["title", "pressed", "isEnabled"]);
    /* assign user declared properties */
    ok_button.title = "OK";
    ok_button.pressed = function (self) {
        console.log("textfield: " + root.edit.text);
        leaveView(0);
    };
    root.ok_button = ok_button;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
