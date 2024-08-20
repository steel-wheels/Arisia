/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/timer.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("timer", "o(Timer)") ;
root._definePropertyType("label", "o(Label)") ;
root._definePropertyType("ok_button", "o(Button)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["timer","label","ok_button","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Timer */
  let timer = _alloc_Timer() as root_timer_TimerIF  ;
  /* define type for all properties */
  timer._definePropertyType("interval", "n") ;
  timer._definePropertyType("main", "f(v,[o(root_timer_TimerIF)])") ;
  timer._definePropertyType("start", "f(v,[])") ;
  timer._definePropertyType("stop", "f(v,[])") ;
  timer._definePropertyType("addHandler", "f(b,[f(b,[n])])") ;
  /* define getter/setter for all properties */
  _definePropertyIF(timer, ["interval","main","start","stop","addHandler"]) ;
  /* assign user declared properties */
  timer.interval = 1;
  timer.main = function(self: root_timer_TimerIF): void {
        self.addHandler(function(repcnt: number): boolean {
          root.label.text = "count: " + repcnt ;
          return true ;
        }) ;
        self.start() ;
      };
  root.timer = timer ;
}
{
  /* allocate function for frame: Label */
  let label = _alloc_Label() as root_label_LabelIF  ;
  /* define type for all properties */
  label._definePropertyType("text", "s") ;
  label._definePropertyType("number", "n") ;
  /* define getter/setter for all properties */
  _definePropertyIF(label, ["text","number"]) ;
  /* assign user declared properties */
  label.text = "Hello, World !!";
  root.label = label ;
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
            root.timer.stop() ;
            leaveView(0) ;
          };
  root.ok_button = ok_button ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* execute initializer methods for frame timer */
root.timer.main(root.timer) ;
/* This value will be return value of evaluateScript() */
root ;
