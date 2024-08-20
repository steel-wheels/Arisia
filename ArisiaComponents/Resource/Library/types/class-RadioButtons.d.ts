interface RadioButtonsIF extends FrameIF {
  currentIndex : number ;
  columnNum : number ;
  labels : string[] ;
  setEnable(p0 : string, p1 : boolean): void ;
}
declare function _alloc_RadioButtons(): RadioButtonsIF ;
