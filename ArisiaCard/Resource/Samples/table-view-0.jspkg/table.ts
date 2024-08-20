/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="table-0.d.ts"/>
/// <reference path="types/table.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("table0", "o(TableView)") ;
root._definePropertyType("quit_button", "o(Button)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["table0","quit_button","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: TableView */
  let table0 = _alloc_TableView() as root_table0_TableViewIF  ;
  /* define type for all properties */
  table0._definePropertyType("name", "s") ;
  table0._definePropertyType("columnCount", "n") ;
  table0._definePropertyType("rowCount", "n") ;
  table0._definePropertyType("records", "f(a(i(SampleRecordIF)),[])") ;
  table0._definePropertyType("clicked", "f(v,[i(root_table0_TableViewIF),b,i(SampleRecordIF),s])") ;
  table0._definePropertyType("table", "i(root_table0_TableViewIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(table0, ["name","columnCount","rowCount","records","clicked","table"]) ;
  /* assign user declared properties */
  table0.name = "table0";
  root.table0 = table0 ;
}
{
  /* allocate function for frame: Button */
  let quit_button = _alloc_Button() as root_quit_button_ButtonIF  ;
  /* define type for all properties */
  quit_button._definePropertyType("title", "s") ;
  quit_button._definePropertyType("pressed", "f(v,[o(root_quit_button_ButtonIF)])") ;
  quit_button._definePropertyType("isEnabled", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(quit_button, ["title","pressed","isEnabled"]) ;
  /* assign user declared properties */
  quit_button.title = "Quit";
  quit_button.pressed = function(self: root_quit_button_ButtonIF): void {
        //console.print("c0:    " + root.table0.record(0).c0 + "\n") ;
        leaveView(1) ;
      };
  root.quit_button = quit_button ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
