interface TimerIF extends FrameIF {
  interval : number ;
  start(): void ;
  stop(): void ;
  addHandler(p0 : (p0 : number) => boolean): boolean ;
}
declare function _alloc_Timer(): TimerIF ;
