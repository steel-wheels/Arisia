interface ListViewIF extends FrameIF {
  isEditable : boolean ;
  items(): string[] ;
  setItems(p0 : string[]): void ;
  selectedItem : string | null ;
  updated : number ;
  visibleRowCounts : number ;
}
interface root_list0_ListViewIF extends ListViewIF {
  main(p0 : root_list0_ListViewIF): void ;
  slct : void ;
  updt : void ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_edit_button_ButtonIF extends ButtonIF {
}
interface root_buttons_quit_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  edit_button : root_buttons_edit_button_ButtonIF ;
  quit_button : root_buttons_quit_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  list0 : root_list0_ListViewIF ;
}
