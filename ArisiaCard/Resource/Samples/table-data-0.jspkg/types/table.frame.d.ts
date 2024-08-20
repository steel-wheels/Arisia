interface SampleRecordIF {
  c0 : number ;
  c1 : number ;
  c2 : number ;
}
interface TableIF {
  recordCount : number ;
  fieldName(p0 : number): string ;
  fieldNames(): string[] ;
  remove(p0 : number): boolean ;
}
interface table0_TableIF extends TableIF {
  newRecord(): SampleRecordIF ;
  record(p0 : number): SampleRecordIF | null ;
  records(): SampleRecordIF[] ;
  current : SampleRecordIF | null ;
  append(p0 : SampleRecordIF): void ;
  select(p0 : string, p1 : any): SampleRecordIF[] ;
}
interface TableDataIF extends FrameIF {
  name : string ;
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
