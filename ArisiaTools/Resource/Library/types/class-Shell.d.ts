interface ShellIF extends FrameIF {
  console : ConsoleIF ;
  run(p0 : URLIF): void ;
}
declare function _alloc_Shell(): ShellIF ;
