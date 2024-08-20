interface CheckBoxIF extends FrameIF {
  label : string ;
  status : boolean ;
}
interface root_checks_CheckBoxIF extends CheckBoxIF {
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
  checks : root_checks_CheckBoxIF ;
  checker : void ;
  ok_button : root_ok_button_ButtonIF ;
}
