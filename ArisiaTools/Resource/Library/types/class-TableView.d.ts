interface TableViewIF extends FrameIF {
  columnCount : number ;
  name : string ;
  rowCount : number ;
}
declare function _alloc_TableView(): TableViewIF ;
