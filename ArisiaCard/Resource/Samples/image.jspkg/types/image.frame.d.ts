interface ImageIF extends FrameIF {
  size(): string ;
}
interface root_img0_ImageIF extends ImageIF {
  name : string ;
  scale : number ;
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
  img0 : root_img0_ImageIF ;
  ok_button : root_ok_button_ButtonIF ;
}
