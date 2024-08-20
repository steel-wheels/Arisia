interface ConsoleViewIF extends FrameIF {
  error(p0 : string): void ;
  height : number ;
  console : ConsoleIF ;
  width : number ;
}
declare function _alloc_ConsoleView(): ConsoleViewIF ;
