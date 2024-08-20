"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/icon.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("homeIcon", "o(IconView)");
root._definePropertyType("ok_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["homeIcon", "ok_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: IconView */
    let homeIcon = _alloc_IconView();
    /* define type for all properties */
    homeIcon._definePropertyType("symbol", "s");
    homeIcon._definePropertyType("title", "s");
    homeIcon._definePropertyType("pressed", "f(v,[o(root_homeIcon_IconViewIF)])");
    /* define getter/setter for all properties */
    _definePropertyIF(homeIcon, ["symbol", "title", "pressed"]);
    /* assign user declared properties */
    homeIcon.symbol = "house";
    homeIcon.title = "home";
    homeIcon.pressed = function (self) {
        console.log("home");
    };
    root.homeIcon = homeIcon;
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
/* This value will be return value of evaluateScript() */
root;
