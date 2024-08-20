interface PopupMenuIF extends FrameIF {
  current : MenuItemIF | null ;
  set(p0 : MenuItemIF[]): void ;
  selected(p0 : PopupMenuIF, p1 : MenuItemIF): void ;
}
interface root_menu_PopupMenuIF extends PopupMenuIF {
  main(p0 : root_menu_PopupMenuIF): void ;
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
  menu : root_menu_PopupMenuIF ;
  ok_button : root_ok_button_ButtonIF ;
}
