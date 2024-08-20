# `Timer` component

## Introduction
The Timer component is used for repetitive operation which 
has fixed interval time.

## Interface

This is the interface definition for TypeScript:
<pre>
interface TimerIF extends FrameIF {
  interval : number ;
  start(): void ;
  stop(): void ;
  addHandler(p0 : (p0 : number) => boolean): boolean ;
}
declare function _alloc_Timer(): TimerIF ;

</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



