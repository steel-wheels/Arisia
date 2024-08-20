interface SiteRecordIF {
  category : string ;
  name : string ;
  url : string ;
}
interface TableIF {
  recordCount : number ;
  fieldName(p0 : number): string ;
  fieldNames(): string[] ;
  remove(p0 : number): boolean ;
}
interface site_list_TableIF extends TableIF {
  newRecord(): SiteRecordIF ;
  record(p0 : number): SiteRecordIF | null ;
  records(): SiteRecordIF[] ;
  current : SiteRecordIF | null ;
  append(p0 : SiteRecordIF): void ;
  select(p0 : string, p1 : any): SiteRecordIF[] ;
}
interface TableDataIF extends FrameIF {
  name : string ;
}
interface root_site_list_TableDataIF extends TableDataIF {
  table : site_list_TableIF ;
}
interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_search_label_LabelIF extends LabelIF {
}
interface TextFieldIF extends FrameIF {
  isEditable : boolean ;
  text : string ;
  number : number ;
  hasBackgroundColor : boolean ;
}
interface root_keyword_TextFieldIF extends TextFieldIF {
}
interface PopupMenuIF extends FrameIF {
  current : MenuItemIF | null ;
  set(p0 : MenuItemIF[]): void ;
  selected(p0 : PopupMenuIF, p1 : MenuItemIF): void ;
}
interface root_site_box_type_PopupMenuIF extends PopupMenuIF {
  main(p0 : root_site_box_type_PopupMenuIF): void ;
}
interface root_site_box_site_PopupMenuIF extends PopupMenuIF {
  main(p0 : root_site_box_site_PopupMenuIF): void ;
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_site_box_BoxIF extends BoxIF {
  site : root_site_box_site_PopupMenuIF ;
  type : root_site_box_type_PopupMenuIF ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_search_button_ButtonIF extends ButtonIF {
}
interface root_buttons_quit_button_ButtonIF extends ButtonIF {
}
interface root_buttons_BoxIF extends BoxIF {
  quit_button : root_buttons_quit_button_ButtonIF ;
  search_button : root_buttons_search_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  keyword : root_keyword_TextFieldIF ;
  search_label : root_search_label_LabelIF ;
  site_box : root_site_box_BoxIF ;
  site_list : root_site_list_TableDataIF ;
}
