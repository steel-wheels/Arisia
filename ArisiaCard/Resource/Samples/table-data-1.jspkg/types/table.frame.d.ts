interface SampleRecordIF {
  style : Style ;
  count : number ;
}
interface TableIF {
  recordCount : number ;
  fieldName(p0 : number): string ;
  fieldNames(): string[] ;
  select(p0 : any, p1 : string): boolean ;
  remove(p0 : number): boolean ;
}
interface table0_TableIF extends TableIF {
  newRecord(): SampleRecordIF ;
  record(p0 : number): SampleRecordIF | null ;
  records(): SampleRecordIF[] ;
  current : SampleRecordIF | null ;
  search(p0 : any, p1 : string): SampleRecordIF[] ;
  append(p0 : SampleRecordIF): void ;
}
interface TableDataIF extends FrameIF {
  name : string ;
  recordCount : number ;
}
interface root_table0_TableDataIF extends TableDataIF {
  table : table0_TableIF ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_calc_button_ButtonIF extends ButtonIF {
}
interface root_quit_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  calc_button : root_calc_button_ButtonIF ;
  quit_button : root_quit_button_ButtonIF ;
  table0 : root_table0_TableDataIF ;
}
