/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/terminal.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("terminal", "o(Terminal)") ;
root._definePropertyType("shell", "o(Shell)") ;
root._definePropertyType("buttons", "o(Box)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["terminal","shell","buttons","axis","alignment","distribution"]) ;
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
  /* allocate function for frame: Shell */
  let shell = _alloc_Shell() as root_shell_ShellIF  ;
  /* define type for all properties */
  shell._definePropertyType("main", "f(v,[o(root_shell_ShellIF)])") ;
  shell._definePropertyType("console", "i(ConsoleIF)") ;
  shell._definePropertyType("run", "f(v,[i(URLIF)])") ;
  /* define getter/setter for all properties */
  _definePropertyIF(shell, ["main","console","run"]) ;
  /* assign user declared properties */
  shell.main = function(self: root_shell_ShellIF): void {
        self.console = root.terminal.console ;
      };
  root.shell = shell ;
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
            let urlp = openPanel("Select source file", FileType.file,
    			["js", "jspkg"]) ;
            if(urlp != null){
              root.shell.run(urlp!) ;
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
/* execute initializer methods for frame shell */
root.shell.main(root.shell) ;
/* This value will be return value of evaluateScript() */
root ;
