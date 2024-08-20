interface TimerIF extends FrameIF {
  interval : number ;
  start(): void ;
  stop(): void ;
  addHandler(p0 : (p0 : number) => boolean): boolean ;
}
interface root_timer_TimerIF extends TimerIF {
  main(p0 : root_timer_TimerIF): void ;
}
interface LabelIF extends FrameIF {
  text : string ;
  number : number ;
}
interface root_label_LabelIF extends LabelIF {
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_ok_button_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_BoxIF extends BoxIF {
  label : root_label_LabelIF ;
  ok_button : root_ok_button_ButtonIF ;
  timer : root_timer_TimerIF ;
}
