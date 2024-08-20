interface SpriteIF extends FrameIF {
  addNode(p0 : string, p1 : string, p2 : number): void ;
  background : string ;
  isPaused : boolean ;
  isStarted(): boolean ;
  script : string ;
  start(): void ;
  nodes : SpriteNodeDeclIF[] ;
}
declare function _alloc_Sprite(): SpriteIF ;
