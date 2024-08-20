interface SiteRecordIF {
  name : string ;
  url : string ;
}
interface TableViewIF extends FrameIF {
  columnCount : number ;
  name : string ;
  rowCount : number ;
}
interface root_table_TableViewIF extends TableViewIF {
  records(): SiteRecordIF[] ;
  clicked(p0 : root_table_TableViewIF, p1 : boolean, p2 : SiteRecordIF, p3 : string): void ;
  table : root_table_TableViewIF ;
}
interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_edit_box_name_label_LabelIF extends LabelIF {
}
interface TextFieldIF extends FrameIF {
  entered(p0 : TextFieldIF, p1 : string): void ;
  isEditable : boolean ;
  text : string ;
  number : number ;
  hasBackgroundColor : boolean ;
}
interface root_edit_box_name_field_TextFieldIF extends TextFieldIF {
}
interface root_edit_box_site_label_LabelIF extends LabelIF {
}
interface root_edit_box_site_field_TextFieldIF extends TextFieldIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_edit_box_BoxIF extends BoxIF {
  name_label : root_edit_box_name_label_LabelIF ;
  name_field : root_edit_box_name_field_TextFieldIF ;
  site_label : root_edit_box_site_label_LabelIF ;
  site_field : root_edit_box_site_field_TextFieldIF ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_quit_button_ButtonIF extends ButtonIF {
}
interface root_BoxIF extends BoxIF {
  table : root_table_TableViewIF ;
  edit_box : root_edit_box_BoxIF ;
  quit_button : root_quit_button_ButtonIF ;
}
