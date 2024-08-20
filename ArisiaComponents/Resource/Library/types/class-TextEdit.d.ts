interface TextEditIF extends FrameIF {
  isEditable : boolean ;
  terminal : EscapeCodesIF ;
}
declare function _alloc_TextEdit(): TextEditIF ;
