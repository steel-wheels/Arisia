interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_title_LabelIF extends LabelIF {
}
interface IconViewIF extends FrameIF {
  pressed(p0 : FrameIF): void ;
  symbol : string ;
  title : string ;
}
interface root_top_box0_bfcIcon_IconViewIF extends IconViewIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_top_box0_BoxIF extends BoxIF {
  bfcIcon : root_top_box0_bfcIcon_IconViewIF ;
}
interface root_top_BoxIF extends BoxIF {
  box0 : root_top_box0_BoxIF ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_return_button_ButtonIF extends ButtonIF {
}
interface root_BoxIF extends BoxIF {
  return_button : root_return_button_ButtonIF ;
  title : root_title_LabelIF ;
  top : root_top_BoxIF ;
}
