interface PopupMenuIF extends FrameIF {
  current : MenuItemIF | null ;
  set(p0 : MenuItemIF[]): void ;
  selected(p0 : PopupMenuIF, p1 : MenuItemIF): void ;
}
declare function _alloc_PopupMenu(): PopupMenuIF ;
