"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/popup-menu.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("menu", "o(PopupMenu)");
root._definePropertyType("ok_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["menu", "ok_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: PopupMenu */
    let menu = _alloc_PopupMenu();
    /* define type for all properties */
    menu._definePropertyType("main", "f(v,[o(root_menu_PopupMenuIF)])");
    menu._definePropertyType("selected", "f(v,[o(root_menu_PopupMenuIF),i(MenuItemIF)])");
    menu._definePropertyType("current", "l(i(MenuItemIF))");
    menu._definePropertyType("set", "f(v,[a(i(MenuItemIF))])");
    /* define getter/setter for all properties */
    _definePropertyIF(menu, ["main", "selected", "current", "set"]);
    /* assign user declared properties */
    menu.main = function (self) {
        let menus = [
            MenuItem("apple", 0),
            MenuItem("banana", 1),
            MenuItem("cherry", 2)
        ];
        self.set(menus);
    };
    menu.selected = function (self, item) {
        console.log("selected_item: " + item.title);
    };
    root.menu = menu;
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
        let item = root.menu.current;
        if (item != null) {
            console.log("current: " + item.title);
        }
        leaveView(0);
    };
    root.ok_button = ok_button;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* execute initializer methods for frame menu */
root.menu.main(root.menu);
/* This value will be return value of evaluateScript() */
root;
