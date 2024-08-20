interface StepperIF extends FrameIF {
  initValue : number ;
  maxValue : number ;
  minValue : number ;
  stepValue : number ;
  updated(p0 : StepperIF, p1 : number): void ;
}
interface root_stepper_StepperIF extends StepperIF {
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
  ok_button : root_ok_button_ButtonIF ;
  stepper : root_stepper_StepperIF ;
}
