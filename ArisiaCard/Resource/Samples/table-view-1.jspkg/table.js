"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="site-list.d.ts"/>
/// <reference path="types/table.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("table", "o(TableView)");
root._definePropertyType("edit_box", "o(Box)");
root._definePropertyType("quit_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["table", "edit_box", "quit_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: TableView */
    let table = _alloc_TableView();
    /* define type for all properties */
    table._definePropertyType("name", "s");
    table._definePropertyType("columnCount", "n");
    table._definePropertyType("rowCount", "n");
    table._definePropertyType("records", "f(a(i(SiteRecordIF)),[])");
    table._definePropertyType("clicked", "f(v,[i(root_table_TableViewIF),b,i(SiteRecordIF),s])");
    table._definePropertyType("table", "i(root_table_TableViewIF)");
    /* define getter/setter for all properties */
    _definePropertyIF(table, ["name", "columnCount", "rowCount", "records", "clicked", "table"]);
    /* assign user declared properties */
    table.name = "site_list";
    root.table = table;
}
{
    /* allocate function for frame: Box */
    let edit_box = _alloc_Box();
    /* define type for all properties */
    edit_box._definePropertyType("axis", "e(Axis)");
    edit_box._definePropertyType("name_label", "o(Label)");
    edit_box._definePropertyType("name_field", "o(TextField)");
    edit_box._definePropertyType("site_label", "o(Label)");
    edit_box._definePropertyType("site_field", "o(TextField)");
    edit_box._definePropertyType("alignment", "e(Alignment)");
    edit_box._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(edit_box, ["axis", "name_label", "name_field", "site_label", "site_field", "alignment", "distribution"]);
    /* assign user declared properties */
    edit_box.axis = Axis.vertical;
    {
        /* allocate function for frame: Label */
        let name_label = _alloc_Label();
        /* define type for all properties */
        name_label._definePropertyType("text", "s");
        name_label._definePropertyType("number", "n");
        /* define getter/setter for all properties */
        _definePropertyIF(name_label, ["text", "number"]);
        /* assign user declared properties */
        name_label.text = "name";
        edit_box.name_label = name_label;
    }
    {
        /* allocate function for frame: TextField */
        let name_field = _alloc_TextField();
        /* define type for all properties */
        name_field._definePropertyType("isEditable", "b");
        name_field._definePropertyType("entered", "f(v,[i(TextFieldIF),s])");
        name_field._definePropertyType("text", "s");
        name_field._definePropertyType("number", "n");
        name_field._definePropertyType("hasBackgroundColor", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(name_field, ["isEditable", "entered", "text", "number", "hasBackgroundColor"]);
        /* assign user declared properties */
        name_field.isEditable = true;
        edit_box.name_field = name_field;
    }
    {
        /* allocate function for frame: Label */
        let site_label = _alloc_Label();
        /* define type for all properties */
        site_label._definePropertyType("text", "s");
        site_label._definePropertyType("number", "n");
        /* define getter/setter for all properties */
        _definePropertyIF(site_label, ["text", "number"]);
        /* assign user declared properties */
        site_label.text = "site";
        edit_box.site_label = site_label;
    }
    {
        /* allocate function for frame: TextField */
        let site_field = _alloc_TextField();
        /* define type for all properties */
        site_field._definePropertyType("isEditable", "b");
        site_field._definePropertyType("entered", "f(v,[i(TextFieldIF),s])");
        site_field._definePropertyType("text", "s");
        site_field._definePropertyType("number", "n");
        site_field._definePropertyType("hasBackgroundColor", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(site_field, ["isEditable", "entered", "text", "number", "hasBackgroundColor"]);
        /* assign user declared properties */
        site_field.isEditable = true;
        edit_box.site_field = site_field;
    }
    root.edit_box = edit_box;
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
