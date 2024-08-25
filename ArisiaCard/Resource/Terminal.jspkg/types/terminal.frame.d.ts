interface TerminalIF extends FrameIF {
  console : ConsoleIF ;
}
interface root_terminal_TerminalIF extends TerminalIF {
}
interface ShellIF extends FrameIF {
  console : ConsoleIF ;
  run(p0 : URLIF): void ;
}
interface root_shell_ShellIF extends ShellIF {
  main(p0 : root_shell_ShellIF): void ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_run_ButtonIF extends ButtonIF {
}
interface root_buttons_quit_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  quit : root_buttons_quit_ButtonIF ;
  run : root_buttons_run_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  shell : root_shell_ShellIF ;
  terminal : root_terminal_TerminalIF ;
}
