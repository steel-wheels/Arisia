"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/collection.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("home", "o(Collection)");
root._definePropertyType("ok_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["home", "ok_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: Collection */
    let home = _alloc_Collection();
    /* define type for all properties */
    home._definePropertyType("load", "f(a(i(IconIF)),[])");
    home._definePropertyType("pressed", "f(v,[o(root_home_CollectionIF),n])");
    home._definePropertyType("count", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(home, ["load", "pressed", "count"]);
    /* assign user declared properties */
    home.load = function () {
        let self = root.home;
        console.log("load icons");
        let result = [
            Icon(0, Symbols.play, "Run"),
            Icon(1, Symbols.terminal, "Terminal"),
            Icon(2, Symbols.magnifyingglass, "Search"),
            Icon(3, Symbols.gearshape, "Preference"),
            Icon(4, Symbols.gamecontroller, "Game"),
            Icon(5, Symbols.paintbrush, "Pait"),
            Icon(6, Symbols.gamecontroller, "Calender"),
            Icon(7, Symbols.gamecontroller, "Misc")
        ];
        return result;
    };
    home.pressed = function (self, index) {
        console.log("pressed: " + index);
    };
    root.home = home;
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
