interface ImageIF extends FrameIF {
  size(): string ;
}
interface root_logo_ImageIF extends ImageIF {
  name : string ;
}
interface PropIF {
  green : TeamIF ;
  blue : TeamIF ;
}
interface PropertiesDataIF extends FrameIF {
  name : string ;
}
interface root_teams_PropertiesDataIF extends PropertiesDataIF {
  properties : PropIF ;
}
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
}
interface ConsoleViewIF extends FrameIF {
  error(p0 : string): void ;
  height : number ;
  console : ConsoleIF ;
  width : number ;
}
interface root_console_ConsoleViewIF extends ConsoleViewIF {
  main(p0 : root_console_ConsoleViewIF): void ;
}
interface ButtonIF extends FrameIF {
  pressed(p0 : ButtonIF): void ;
  isEnabled : boolean ;
  title : string ;
}
interface root_buttons_start_ButtonIF extends ButtonIF {
}
interface root_buttons_quit_ButtonIF extends ButtonIF {
}
interface BoxIF extends FrameIF {
  axis : Axis ;
  alignment : Alignment ;
  distribution : Distribution ;
}
interface root_buttons_BoxIF extends BoxIF {
  quit : root_buttons_quit_ButtonIF ;
  start : root_buttons_start_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
  console : root_console_ConsoleViewIF ;
  logo : root_logo_ImageIF ;
  sprite : root_sprite_SpriteIF ;
  teams : root_teams_PropertiesDataIF ;
}
