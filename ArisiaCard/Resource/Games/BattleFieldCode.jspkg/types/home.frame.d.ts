interface ImageIF extends FrameIF {
  size(): string ;
}
interface root_logo_ImageIF extends ImageIF {
  name : string ;
}
interface PropIF {
  green : TeamIF ;
  blue : TeamIF ;
}
interface PropertiesDataIF extends FrameIF {
  name : string ;
}
interface root_teams_PropertiesDataIF extends PropertiesDataIF {
  properties : PropIF ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_controls_blue_select_button_ButtonIF extends ButtonIF {
}
interface TextFieldIF extends FrameIF {
  isEditable : boolean ;
  text : string ;
  number : number ;
  hasBackgroundColor : boolean ;
}
interface root_controls_blue_select_name_TextFieldIF extends TextFieldIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_controls_blue_select_BoxIF extends BoxIF {
  button : root_controls_blue_select_button_ButtonIF ;
  name : root_controls_blue_select_name_TextFieldIF ;
}
interface StepperIF extends FrameIF {
  initValue : number ;
  maxValue : number ;
  minValue : number ;
  stepValue : number ;
  updated(p0 : StepperIF, p1 : number): void ;
}
interface root_controls_blue_count_StepperIF extends StepperIF {
}
interface root_controls_blue_BoxIF extends BoxIF {
  count : root_controls_blue_count_StepperIF ;
  select : root_controls_blue_select_BoxIF ;
}
interface root_controls_green_select_button_ButtonIF extends ButtonIF {
}
interface root_controls_green_select_name_TextFieldIF extends TextFieldIF {
}
interface root_controls_green_select_BoxIF extends BoxIF {
  button : root_controls_green_select_button_ButtonIF ;
  name : root_controls_green_select_name_TextFieldIF ;
}
interface root_controls_green_count_StepperIF extends StepperIF {
}
interface root_controls_green_BoxIF extends BoxIF {
  count : root_controls_green_count_StepperIF ;
  select : root_controls_green_select_BoxIF ;
}
interface root_controls_BoxIF extends BoxIF {
  blue : root_controls_blue_BoxIF ;
  green : root_controls_green_BoxIF ;
}
interface root_buttons_run_ButtonIF extends ButtonIF {
}
interface root_buttons_quit_ButtonIF extends ButtonIF {
}
interface root_buttons_BoxIF extends BoxIF {
  quit : root_buttons_quit_ButtonIF ;
  run : root_buttons_run_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  controls : root_controls_BoxIF ;
  logo : root_logo_ImageIF ;
  teams : root_teams_PropertiesDataIF ;
}
