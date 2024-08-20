interface TerminalIF extends FrameIF {
  console : ConsoleIF ;
}
interface root_terminal_TerminalIF extends TerminalIF {
  main(p0 : root_terminal_TerminalIF): void ;
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  terminal : root_terminal_TerminalIF ;
}
