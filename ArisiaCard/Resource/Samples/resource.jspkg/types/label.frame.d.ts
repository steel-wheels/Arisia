interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_label_LabelIF extends LabelIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_set_button_ButtonIF extends ButtonIF {
}
interface root_ok_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  label : root_label_LabelIF ;
  ok_button : root_ok_button_ButtonIF ;
  set_button : root_set_button_ButtonIF ;
}
