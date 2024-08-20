interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_title_LabelIF extends LabelIF {
}
interface root_search_label_LabelIF extends LabelIF {
}
interface TextFieldIF extends FrameIF {
  entered(p0 : TextFieldIF, p1 : string): void ;
  isEditable : boolean ;
  text : string ;
  number : number ;
  hasBackgroundColor : boolean ;
}
interface root_search_text_TextFieldIF extends TextFieldIF {
}
interface root_category_label_LabelIF extends LabelIF {
}
interface RadioButtonsIF extends FrameIF {
  currentIndex : number ;
  columnNum : number ;
  labels : string[] ;
  setEnable(p0 : string, p1 : boolean): void ;
}
interface root_category_butttons_RadioButtonsIF extends RadioButtonsIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_search_button_ButtonIF extends ButtonIF {
}
interface root_buttons_return_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  search_button : root_buttons_search_button_ButtonIF ;
  return_button : root_buttons_return_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  title : root_title_LabelIF ;
  search_label : root_search_label_LabelIF ;
  search_text : root_search_text_TextFieldIF ;
  category_label : root_category_label_LabelIF ;
  category_butttons : root_category_butttons_RadioButtonsIF ;
  buttons : root_buttons_BoxIF ;
}
