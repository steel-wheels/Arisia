interface TextEditIF extends FrameIF {
  isEditable : boolean ;
  terminal : EscapeCodesIF ;
}
interface root_edit_TextEditIF extends TextEditIF {
  main(p0 : root_edit_TextEditIF): void ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_write_button_ButtonIF extends ButtonIF {
}
interface root_buttons_ok_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  ok_button : root_buttons_ok_button_ButtonIF ;
  write_button : root_buttons_write_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  edit : root_edit_TextEditIF ;
}
