interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_title_LabelIF extends LabelIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_return_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  return_button : root_return_button_ButtonIF ;
  title : root_title_LabelIF ;
}
