"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/paint.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("title", "o(Label)");
root._definePropertyType("return_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["title", "return_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: Label */
    let title = _alloc_Label();
    /* define type for all properties */
    title._definePropertyType("text", "s");
    title._definePropertyType("number", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(title, ["text", "number"]);
    /* assign user declared properties */
    title.text = "Paint";
    root.title = title;
}
{
    /* allocate function for frame: Button */
    let return_button = _alloc_Button();
    /* define type for all properties */
    return_button._definePropertyType("title", "s");
    return_button._definePropertyType("pressed", "f(v,[o(root_return_button_ButtonIF)])");
    return_button._definePropertyType("isEnabled", "b");
    /* define getter/setter for all properties */
    _definePropertyIF(return_button, ["title", "pressed", "isEnabled"]);
    /* assign user declared properties */
    return_button.title = "Return";
    return_button.pressed = function (self) {
        leaveView(0);
    };
    root.return_button = return_button;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
