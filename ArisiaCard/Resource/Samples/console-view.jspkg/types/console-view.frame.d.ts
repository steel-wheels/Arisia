interface ConsoleViewIF extends FrameIF {
  error(p0 : string): void ;
  height : number ;
  console : ConsoleIF ;
  width : number ;
}
interface root_console_ConsoleViewIF extends ConsoleViewIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_hello_button_ButtonIF extends ButtonIF {
}
interface root_buttons_ok_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  hello_button : root_buttons_hello_button_ButtonIF ;
  ok_button : root_buttons_ok_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  console : root_console_ConsoleViewIF ;
}
