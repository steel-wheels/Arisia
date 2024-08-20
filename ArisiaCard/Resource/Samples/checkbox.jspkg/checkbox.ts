/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/checkbox.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("checks", "o(CheckBox)") ;
root._definePropertyType("checker", "f(v,[o(root_BoxIF),b])") ;
root._definePropertyType("ok_button", "o(Button)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["checks","checker","ok_button","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: CheckBox */
  let checks = _alloc_CheckBox() as root_checks_CheckBoxIF  ;
  /* define type for all properties */
  checks._definePropertyType("label", "s") ;
  checks._definePropertyType("status", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(checks, ["label","status"]) ;
  /* assign user declared properties */
  checks.label = "Check-0";
  checks.status = false;
  root.checks = checks ;
}
{
  /* allocate function for frame: Button */
  let ok_button = _alloc_Button() as root_ok_button_ButtonIF  ;
  /* define type for all properties */
  ok_button._definePropertyType("title", "s") ;
  ok_button._definePropertyType("pressed", "f(v,[o(root_ok_button_ButtonIF)])") ;
  ok_button._definePropertyType("isEnabled", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(ok_button, ["title","pressed","isEnabled"]) ;
  /* assign user declared properties */
  ok_button.title = "OK";
  ok_button.pressed = function(self: root_ok_button_ButtonIF): void {
  	    	leaveView(0) ;
          };
  root.ok_button = ok_button ;
}
/* Define listner functions */
let _lfunc_root_checker = function(self: root_BoxIF, stat: boolean): void {

	console.log("status = " + stat) ;
  } ;
/* add observers for listner function */
root.checks._addObserver("status", function(){
  let self = root ;
  let stat = root.checks.status ;
  root.checker = _lfunc_root_checker(self, stat) ;
}) ;
/* Setup the component */
_setup_component(root) ;
/* call listner methods to initialize it's property value for frame root */
root.checker = _lfunc_root_checker(root, root.checks.status) ;
/* This value will be return value of evaluateScript() */
root ;
