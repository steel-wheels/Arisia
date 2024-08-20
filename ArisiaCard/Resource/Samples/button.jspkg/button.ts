/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/button.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("ok_button", "o(Button)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["ok_button","axis","alignment","distribution"]) ;
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
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
