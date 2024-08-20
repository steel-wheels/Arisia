# `PopupMenu` component

## Introduction
The popup menu which is used to select one from the multiple items.

## Interface

This is the interface definition for TypeScript:
<pre>
interface PopupMenuIF extends FrameIF {
  current : MenuItemIF | null ;
  set(p0 : MenuItemIF[]): void ;
  selected(p0 : PopupMenuIF, p1 : MenuItemIF): void ;
}
declare function _alloc_PopupMenu(): PopupMenuIF ;

</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



