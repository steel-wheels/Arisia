interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_title_LabelIF extends LabelIF {
}
interface RadioButtonsIF extends FrameIF {
  currentIndex : number ;
  columnNum : number ;
  labels : string[] ;
  setEnable(p0 : string, p1 : boolean): void ;
}
interface root_mode_RadioButtonsIF extends RadioButtonsIF {
}
interface root_install_LabelIF extends LabelIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_install_button_ButtonIF extends ButtonIF {
}
interface root_buttons_ok_button_ButtonIF extends ButtonIF {
}
interface root_buttons_cancel_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  cancel_button : root_buttons_cancel_button_ButtonIF ;
  ok_button : root_buttons_ok_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  install : root_install_LabelIF ;
  install_button : root_install_button_ButtonIF ;
  mode : root_mode_RadioButtonsIF ;
  title : root_title_LabelIF ;
}
