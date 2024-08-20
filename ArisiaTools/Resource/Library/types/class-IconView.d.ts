interface IconViewIF extends FrameIF {
  pressed(p0 : FrameIF): void ;
  symbol : string ;
  title : string ;
}
declare function _alloc_IconView(): IconViewIF ;
