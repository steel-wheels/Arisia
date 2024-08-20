# `Collection` component

## Introduction
Display multiple images. You cange callback by clicking the image.

## Interface

This is the interface definition for TypeScript:
<pre>
interface CollectionIF extends FrameIF {
  count : number ;
  load(): IconIF[] ;
  pressed(p0 : CollectionIF, p1 : number): void ;
}
declare function _alloc_Collection(): CollectionIF ;

</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



