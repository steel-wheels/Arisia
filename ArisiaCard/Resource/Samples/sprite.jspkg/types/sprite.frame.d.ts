interface SpriteIF extends FrameIF {
  addNode(p0 : string, p1 : string, p2 : number): void ;
  background : string ;
  isPaused : boolean ;
  isStarted(): boolean ;
  script : string ;
  start(): void ;
  nodes : SpriteNodeDeclIF[] ;
}
interface root_sprite_SpriteIF extends SpriteIF {
  console : ConsoleIF ;
  main(p0 : root_sprite_SpriteIF): void ;
}
interface ConsoleViewIF extends FrameIF {
  error(p0 : string): void ;
  height : number ;
  console : ConsoleIF ;
  width : number ;
}
interface root_console_ConsoleViewIF extends ConsoleViewIF {
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
  console : root_console_ConsoleViewIF ;
  ok_button : root_ok_button_ButtonIF ;
  sprite : root_sprite_SpriteIF ;
}
