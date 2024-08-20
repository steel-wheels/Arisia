interface RadioButtonsIF extends FrameIF {
  currentIndex : number ;
  columnNum : number ;
  labels : string[] ;
  setEnable(p0 : string, p1 : boolean): void ;
}
interface root_buttons_RadioButtonsIF extends RadioButtonsIF {
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
  buttons : root_buttons_RadioButtonsIF ;
  index_listner : number ;
  ok_button : root_ok_button_ButtonIF ;
}
