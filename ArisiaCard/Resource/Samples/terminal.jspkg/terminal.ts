/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/terminal.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("terminal", "o(Terminal)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["terminal","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Terminal */
  let terminal = _alloc_Terminal() as root_terminal_TerminalIF  ;
  /* define type for all properties */
  terminal._definePropertyType("main", "f(v,[o(root_terminal_TerminalIF)])") ;
  terminal._definePropertyType("console", "i(ConsoleIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(terminal, ["main","console"]) ;
  /* assign user declared properties */
  terminal.main = function(self: root_terminal_TerminalIF): void {
        let strcode0 = EscapeSequences.string("Hello, world !!") ;
        self.console.print(strcode0.toString()) ;
        //let insspc0 = EscapeSequences.insertSpaces(3) ;
        //self.console.print(insspc0.toString()) ;
        let strcode1 = EscapeSequences.string("Good morning !!") ;
        self.console.print(strcode1.toString()) ;
        //let back0 = EscapeSequences.cursorBackward(10) ;
        //self.console.print(back0.toString()) ;
        //let insspc1 = EscapeSequences.insertSpaces(8) ;
        //self.console.print(insspc1.toString()) ;
        //let strcode2 = EscapeSequences.string("evening/") ;
        //self.console.print(strcode2.toString()) ;
      };
  root.terminal = terminal ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* execute initializer methods for frame terminal */
root.terminal.main(root.terminal) ;
/* This value will be return value of evaluateScript() */
root ;
