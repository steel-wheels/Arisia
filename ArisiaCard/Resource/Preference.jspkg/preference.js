"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/preference.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("label", "o(Label)");
root._definePropertyType("version", "o(Label)");
root._definePropertyType("ok_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["label", "version", "ok_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: Label */
    let label = _alloc_Label();
    /* define type for all properties */
    label._definePropertyType("text", "s");
    label._definePropertyType("number", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(label, ["text", "number"]);
    /* assign user declared properties */
    label.text = "Preference";
    root.label = label;
}
{
    /* allocate function for frame: Label */
    let version = _alloc_Label();
    /* define type for all properties */
    version._definePropertyType("text", "s");
    version._definePropertyType("main", "f(v,[o(root_version_LabelIF)])");
    version._definePropertyType("number", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(version, ["text", "main", "number"]);
    /* assign user declared properties */
    version.text = "Version: ";
    version.main = function (self) {
        self.text = "Version: " + Preference.system.version;
    };
    root.version = version;
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
        leaveView(0);
    };
    root.ok_button = ok_button;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* execute initializer methods for frame version */
root.version.main(root.version);
/* This value will be return value of evaluateScript() */
root;
