interface ConsoleIF {
  print(p0 : string): void ;
  error(p0 : string): void ;
  log(p0 : string): void ;
  scan(): string | null ;
}
declare function _alloc_Console(): ConsoleIF ;
