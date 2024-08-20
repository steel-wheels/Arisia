interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_label_LabelIF extends LabelIF {
}
interface TeamIF {
  green : number ;
  blue : number ;
}
interface PropertiesDataIF extends FrameIF {
  name : string ;
}
interface root_prop_data_PropertiesDataIF extends PropertiesDataIF {
  properties : TeamIF ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_box_set_button_ButtonIF extends ButtonIF {
}
interface root_box_ok_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_box_BoxIF extends BoxIF {
  ok_button : root_box_ok_button_ButtonIF ;
  set_button : root_box_set_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  box : root_box_BoxIF ;
  label : root_label_LabelIF ;
  prop_data : root_prop_data_PropertiesDataIF ;
}
