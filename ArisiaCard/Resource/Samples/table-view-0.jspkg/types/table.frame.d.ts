interface TableViewIF extends FrameIF {
  columnCount : number ;
  name : string ;
  rowCount : number ;
}
interface root_table0_TableViewIF extends TableViewIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_quit_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  quit_button : root_quit_button_ButtonIF ;
  table0 : root_table0_TableViewIF ;
}
