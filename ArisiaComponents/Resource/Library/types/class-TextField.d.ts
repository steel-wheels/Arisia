interface TextFieldIF extends FrameIF {
  isEditable : boolean ;
  text : string ;
  number : number ;
  hasBackgroundColor : boolean ;
}
declare function _alloc_TextField(): TextFieldIF ;
