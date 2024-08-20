"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/basic.d.ts"/>
/// <reference path="data/table_data.d.ts"/>
/// <reference path="types/table.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("table0", "o(TableData)");
root._definePropertyType("calc_button", "o(Button)");
root._definePropertyType("quit_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["table0", "calc_button", "quit_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: TableData */
    let table0 = _alloc_TableData();
    /* define type for all properties */
    table0._definePropertyType("name", "s");
    table0._definePropertyType("recordCount", "n");
    table0._definePropertyType("table", "i(table0_TableIF)");
    /* define getter/setter for all properties */
    _definePropertyIF(table0, ["name", "recordCount", "table"]);
    /* assign user declared properties */
    table0.name = "table0";
    root.table0 = table0;
}
{
    /* allocate function for frame: Button */
    let calc_button = _alloc_Button();
    /* define type for all properties */
    calc_button._definePropertyType("title", "s");
    calc_button._definePropertyType("pressed", "f(v,[o(root_calc_button_ButtonIF)])");
    calc_button._definePropertyType("isEnabled", "b");
    /* define getter/setter for all properties */
    _definePropertyIF(calc_button, ["title", "pressed", "isEnabled"]);
    /* assign user declared properties */
    calc_button.title = "Calc";
    calc_button.pressed = function (self) {
        console.print("count: " + root.table0.recordCount + "\n");
        let table = root.table0.table;
        for (let i = 0; i < table.recordCount; i++) {
            let rec = table.record(i);
            if (rec != null) {
                console.print(i + ": style=" + rec.style + "\n");
            }
        }
    };
    root.calc_button = calc_button;
}
{
    /* allocate function for frame: Button */
    let quit_button = _alloc_Button();
    /* define type for all properties */
    quit_button._definePropertyType("title", "s");
    quit_button._definePropertyType("pressed", "f(v,[o(root_quit_button_ButtonIF)])");
    quit_button._definePropertyType("isEnabled", "b");
    /* define getter/setter for all properties */
    _definePropertyIF(quit_button, ["title", "pressed", "isEnabled"]);
    /* assign user declared properties */
    quit_button.title = "Quit";
    quit_button.pressed = function (self) {
        leaveView(1);
    };
    root.quit_button = quit_button;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
