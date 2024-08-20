interface CollectionIF extends FrameIF {
  count : number ;
  load(): IconIF[] ;
  pressed(p0 : CollectionIF, p1 : number): void ;
}
interface root_home_CollectionIF extends CollectionIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_ok_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  home : root_home_CollectionIF ;
  ok_button : root_ok_button_ButtonIF ;
}
