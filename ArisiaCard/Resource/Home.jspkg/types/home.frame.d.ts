interface ImageIF extends FrameIF {
  size(): string ;
}
interface root_logo_ImageIF extends ImageIF {
  name : string ;
}
interface CollectionIF extends FrameIF {
  count : number ;
  load(): IconIF[] ;
  pressed(p0 : CollectionIF, p1 : number): void ;
}
interface root_home_CollectionIF extends CollectionIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  home : root_home_CollectionIF ;
  logo : root_logo_ImageIF ;
}
