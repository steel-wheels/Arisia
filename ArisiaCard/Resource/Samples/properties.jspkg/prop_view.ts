/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/prop_view.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("label", "o(Label)") ;
root._definePropertyType("prop_data", "o(PropertiesData)") ;
root._definePropertyType("box", "o(Box)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["label","prop_data","box","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Label */
  let label = _alloc_Label() as root_label_LabelIF  ;
  /* define type for all properties */
  label._definePropertyType("text", "s") ;
  label._definePropertyType("number", "n") ;
  /* define getter/setter for all properties */
  _definePropertyIF(label, ["text","number"]) ;
  /* assign user declared properties */
  label.text = "Properties";
  root.label = label ;
}
{
  /* allocate function for frame: PropertiesData */
  let prop_data = _alloc_PropertiesData() as root_prop_data_PropertiesDataIF  ;
  /* define type for all properties */
  prop_data._definePropertyType("name", "s") ;
  prop_data._definePropertyType("properties", "i(TeamIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(prop_data, ["name","properties"]) ;
  /* assign user declared properties */
  prop_data.name = "prop_data";
  root.prop_data = prop_data ;
}
{
  /* allocate function for frame: Box */
  let box = _alloc_Box() as root_box_BoxIF  ;
  /* define type for all properties */
  box._definePropertyType("axis", "e(Axis)") ;
  box._definePropertyType("set_button", "o(Button)") ;
  box._definePropertyType("ok_button", "o(Button)") ;
  box._definePropertyType("alignment", "e(Alignment)") ;
  box._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(box, ["axis","set_button","ok_button","alignment","distribution"]) ;
  /* assign user declared properties */
  box.axis = Axis.horizontal;
  {
    /* allocate function for frame: Button */
    let set_button = _alloc_Button() as root_box_set_button_ButtonIF  ;
    /* define type for all properties */
    set_button._definePropertyType("title", "s") ;
    set_button._definePropertyType("pressed", "f(v,[o(root_box_set_button_ButtonIF)])") ;
    set_button._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(set_button, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    set_button.title = "Set";
    set_button.pressed = function(self: root_box_set_button_ButtonIF): void {
    				root.prop_data.properties.blue  = 3 ;
    				root.prop_data.properties.green = 4 ;
    				let sum = root.prop_data.properties.blue 
    					    + root.prop_data.properties.green 
    					    ;
    				console.print("sum: " + sum + "\n") ;
    			};
    box.set_button = set_button ;
  }
  {
    /* allocate function for frame: Button */
    let ok_button = _alloc_Button() as root_box_ok_button_ButtonIF  ;
    /* define type for all properties */
    ok_button._definePropertyType("title", "s") ;
    ok_button._definePropertyType("pressed", "f(v,[o(root_box_ok_button_ButtonIF)])") ;
    ok_button._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(ok_button, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    ok_button.title = "OK";
    ok_button.pressed = function(self: root_box_ok_button_ButtonIF): void {
    				leaveView(0) ;
    			};
    box.ok_button = ok_button ;
  }
  root.box = box ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
