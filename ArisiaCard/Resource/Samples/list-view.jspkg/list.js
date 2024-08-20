"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/list.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("list0", "o(ListView)");
root._definePropertyType("buttons", "o(Box)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["list0", "buttons", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: ListView */
    let list0 = _alloc_ListView();
    /* define type for all properties */
    list0._definePropertyType("visibleRowCounts", "n");
    list0._definePropertyType("isEditable", "b");
    list0._definePropertyType("main", "f(v,[o(root_list0_ListViewIF)])");
    list0._definePropertyType("slct", "f(v,[o(root_list0_ListViewIF),l(s)])");
    list0._definePropertyType("updt", "f(v,[o(root_list0_ListViewIF),n])");
    list0._definePropertyType("items", "f(a(s),[])");
    list0._definePropertyType("setItems", "f(v,[a(s)])");
    list0._definePropertyType("selectedItem", "l(s)");
    list0._definePropertyType("updated", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(list0, ["visibleRowCounts", "isEditable", "main", "slct", "updt", "items", "setItems", "selectedItem", "updated"]);
    /* assign user declared properties */
    list0.visibleRowCounts = 4;
    list0.isEditable = false;
    list0.main = function (self) {
        let items = [
            "january",
            "february",
            "march",
            "april",
            "may",
            "june",
            "july",
            "august",
            "september",
            "october",
            "november",
            "december",
        ];
        self.setItems(items);
    };
    root.list0 = list0;
}
{
    /* allocate function for frame: Box */
    let buttons = _alloc_Box();
    /* define type for all properties */
    buttons._definePropertyType("axis", "e(Axis)");
    buttons._definePropertyType("edit_button", "o(Button)");
    buttons._definePropertyType("quit_button", "o(Button)");
    buttons._definePropertyType("alignment", "e(Alignment)");
    buttons._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(buttons, ["axis", "edit_button", "quit_button", "alignment", "distribution"]);
    /* assign user declared properties */
    buttons.axis = Axis.horizontal;
    {
        /* allocate function for frame: Button */
        let edit_button = _alloc_Button();
        /* define type for all properties */
        edit_button._definePropertyType("title", "s");
        edit_button._definePropertyType("pressed", "f(v,[o(root_buttons_edit_button_ButtonIF)])");
        edit_button._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(edit_button, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        edit_button.title = "Edit";
        edit_button.pressed = function (self) {
            if (root.list0.isEditable) {
                console.log("editable: off");
                root.list0.isEditable = false;
            }
            else {
                console.log("editable: on");
                root.list0.isEditable = true;
            }
        };
        buttons.edit_button = edit_button;
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
            leaveView(1);
        };
        buttons.quit_button = quit_button;
    }
    root.buttons = buttons;
}
/* Define listner functions */
let _lfunc_root_list0_slct = function (self, item) {
    console.log("selected item = " + item);
};
let _lfunc_root_list0_updt = function (self, item) {
    console.log("updated: [" + self.items() + "]");
};
/* add observers for listner function */
root.list0._addObserver("selectedItem", function () {
    let self = root.list0;
    let item = root.list0.selectedItem;
    root.list0.slct = _lfunc_root_list0_slct(self, item);
});
/* add observers for listner function */
root.list0._addObserver("updated", function () {
    let self = root.list0;
    let item = root.list0.updated;
    root.list0.updt = _lfunc_root_list0_updt(self, item);
});
/* Setup the component */
_setup_component(root);
/* call listner methods to initialize it's property value for frame list0 */
root.list0.slct = _lfunc_root_list0_slct(root.list0, root.list0.selectedItem);
root.list0.updt = _lfunc_root_list0_updt(root.list0, root.list0.updated);
/* execute initializer methods for frame list0 */
root.list0.main(root.list0);
/* This value will be return value of evaluateScript() */
root;
