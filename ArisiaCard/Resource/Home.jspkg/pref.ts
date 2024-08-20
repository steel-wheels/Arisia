/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/pref.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("title", "o(Label)") ;
root._definePropertyType("mode", "o(RadioButtons)") ;
root._definePropertyType("install", "o(Label)") ;
root._definePropertyType("install_button", "o(Button)") ;
root._definePropertyType("buttons", "o(Box)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["title","mode","install","install_button","buttons","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Label */
  let title = _alloc_Label() as root_title_LabelIF  ;
  /* define type for all properties */
  title._definePropertyType("text", "s") ;
  title._definePropertyType("number", "n") ;
  /* define getter/setter for all properties */
  _definePropertyIF(title, ["text","number"]) ;
  /* assign user declared properties */
  title.text = "Appearance";
  root.title = title ;
}
{
  /* allocate function for frame: RadioButtons */
  let mode = _alloc_RadioButtons() as root_mode_RadioButtonsIF  ;
  /* define type for all properties */
  mode._definePropertyType("labels", "a(s)") ;
  mode._definePropertyType("columnNum", "n") ;
  mode._definePropertyType("currentIndex", "n") ;
  mode._definePropertyType("setEnable", "f(v,[s,b])") ;
  /* define getter/setter for all properties */
  _definePropertyIF(mode, ["labels","columnNum","currentIndex","setEnable"]) ;
  /* assign user declared properties */
  mode.labels = ["light", "dark", "automatic"];
  mode.columnNum = 1;
  root.mode = mode ;
}
{
  /* allocate function for frame: Label */
  let install = _alloc_Label() as root_install_LabelIF  ;
  /* define type for all properties */
  install._definePropertyType("text", "s") ;
  install._definePropertyType("number", "n") ;
  /* define getter/setter for all properties */
  _definePropertyIF(install, ["text","number"]) ;
  /* assign user declared properties */
  install.text = "Install";
  root.install = install ;
}
{
  /* allocate function for frame: Button */
  let install_button = _alloc_Button() as root_install_button_ButtonIF  ;
  /* define type for all properties */
  install_button._definePropertyType("title", "s") ;
  install_button._definePropertyType("pressed", "f(v,[o(root_install_button_ButtonIF)])") ;
  install_button._definePropertyType("isEnabled", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(install_button, ["title","pressed","isEnabled"]) ;
  /* assign user declared properties */
  install_button.title = "Install sample scripts";
  install_button.pressed = function(self: root_install_button_ButtonIF): void {
  			let resdir = FileManager.resourceDirectory ;
  			if(resdir != null){
  				let srcdir = resdir.appending("Samples") ;
  				let docdir = FileManager.documentDirectory ;
  				let dstdir = docdir.appending("Samples") ;
  				if(srcdir != null && dstdir != null){
  					console.log("check: " + dstdir.path) ;
  					if(FileManager.fileExists(dstdir)){
  						console.log("remove: " + dstdir.path) ;
  						FileManager.remove(dstdir) ;
  					}
  					console.log("srcdir: " + srcdir.path) ;
  					console.log("dstdir: " + dstdir.path) ;
  					if(!FileManager.copy(srcdir, dstdir)){
  						console.error("Failed to copy sample directory\n") ;
  					}
  				}
  			} else {
  				console.log("no resource directory") ;
  			}
  		};
  root.install_button = install_button ;
}
{
  /* allocate function for frame: Box */
  let buttons = _alloc_Box() as root_buttons_BoxIF  ;
  /* define type for all properties */
  buttons._definePropertyType("axis", "e(Axis)") ;
  buttons._definePropertyType("ok_button", "o(Button)") ;
  buttons._definePropertyType("cancel_button", "o(Button)") ;
  buttons._definePropertyType("alignment", "e(Alignment)") ;
  buttons._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(buttons, ["axis","ok_button","cancel_button","alignment","distribution"]) ;
  /* assign user declared properties */
  buttons.axis = Axis.horizontal;
  {
    /* allocate function for frame: Button */
    let ok_button = _alloc_Button() as root_buttons_ok_button_ButtonIF  ;
    /* define type for all properties */
    ok_button._definePropertyType("title", "s") ;
    ok_button._definePropertyType("pressed", "f(v,[o(root_buttons_ok_button_ButtonIF)])") ;
    ok_button._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(ok_button, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    ok_button.title = "OK";
    ok_button.pressed = function(self: root_buttons_ok_button_ButtonIF): void {
    				leaveView(0) ;
    			};
    buttons.ok_button = ok_button ;
  }
  {
    /* allocate function for frame: Button */
    let cancel_button = _alloc_Button() as root_buttons_cancel_button_ButtonIF  ;
    /* define type for all properties */
    cancel_button._definePropertyType("title", "s") ;
    cancel_button._definePropertyType("pressed", "f(v,[o(root_buttons_cancel_button_ButtonIF)])") ;
    cancel_button._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(cancel_button, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    cancel_button.title = "Cancel";
    cancel_button.pressed = function(self: root_buttons_cancel_button_ButtonIF): void {
    				leaveView(1) ;
    			};
    buttons.cancel_button = cancel_button ;
  }
  root.buttons = buttons ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
