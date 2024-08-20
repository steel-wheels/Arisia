interface CollectionIF extends FrameIF {
  count : number ;
  load(): IconIF[] ;
  pressed(p0 : CollectionIF, p1 : number): void ;
}
declare function _alloc_Collection(): CollectionIF ;
