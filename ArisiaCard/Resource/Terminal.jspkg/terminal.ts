/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/terminal.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("terminal", "o(Terminal)") ;
root._definePropertyType("buttons", "o(Box)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["terminal","buttons","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Terminal */
  let terminal = _alloc_Terminal() as root_terminal_TerminalIF  ;
  /* define type for all properties */
  terminal._definePropertyType("console", "i(ConsoleIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(terminal, ["console"]) ;
  root.terminal = terminal ;
}
{
  /* allocate function for frame: Box */
  let buttons = _alloc_Box() as root_buttons_BoxIF  ;
  /* define type for all properties */
  buttons._definePropertyType("axis", "e(Axis)") ;
  buttons._definePropertyType("run", "o(Button)") ;
  buttons._definePropertyType("quit", "o(Button)") ;
  buttons._definePropertyType("alignment", "e(Alignment)") ;
  buttons._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(buttons, ["axis","run","quit","alignment","distribution"]) ;
  /* assign user declared properties */
  buttons.axis = Axis.horizontal;
  {
    /* allocate function for frame: Button */
    let run = _alloc_Button() as root_buttons_run_ButtonIF  ;
    /* define type for all properties */
    run._definePropertyType("title", "s") ;
    run._definePropertyType("pressed", "f(v,[o(root_buttons_run_ButtonIF)])") ;
    run._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(run, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    run.title = "Run";
    run.pressed = function(self: root_buttons_run_ButtonIF): void {
            let urlp = openPanel("Select source file", FileType.file, ["jspkg"]) ;
            if(urlp != null){
    		  runThread(urlp, [], root.terminal.console) ;
            }
          };
    buttons.run = run ;
  }
  {
    /* allocate function for frame: Button */
    let quit = _alloc_Button() as root_buttons_quit_ButtonIF  ;
    /* define type for all properties */
    quit._definePropertyType("title", "s") ;
    quit._definePropertyType("pressed", "f(v,[o(root_buttons_quit_ButtonIF)])") ;
    quit._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(quit, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    quit.title = "Quit";
    quit.pressed = function(self: root_buttons_quit_ButtonIF): void {
            leaveView(0) ;
          };
    buttons.quit = quit ;
  }
  root.buttons = buttons ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
