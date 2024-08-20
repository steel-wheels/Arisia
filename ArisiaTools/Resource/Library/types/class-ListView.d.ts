interface ListViewIF extends FrameIF {
  isEditable : boolean ;
  items(): string[] ;
  setItems(p0 : string[]): void ;
  selectedItem : string | null ;
  updated : number ;
  visibleRowCounts : number ;
}
declare function _alloc_ListView(): ListViewIF ;
