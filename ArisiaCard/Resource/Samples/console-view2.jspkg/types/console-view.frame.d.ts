interface ConsoleViewIF extends FrameIF {
  error(p0 : string): void ;
  height : number ;
  console : ConsoleIF ;
  width : number ;
}
interface root_consoles_blue_ConsoleViewIF extends ConsoleViewIF {
}
interface root_consoles_green_ConsoleViewIF extends ConsoleViewIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_consoles_BoxIF extends BoxIF {
  blue : root_consoles_blue_ConsoleViewIF ;
  green : root_consoles_green_ConsoleViewIF ;
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
interface root_buttons_BoxIF extends BoxIF {
  hello_button : root_buttons_hello_button_ButtonIF ;
  ok_button : root_buttons_ok_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  consoles : root_consoles_BoxIF ;
}
