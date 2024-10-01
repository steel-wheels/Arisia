/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/sprite.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("sprite", "o(Sprite)") ;
root._definePropertyType("console", "o(ConsoleView)") ;
root._definePropertyType("ok_button", "o(Button)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["sprite","console","ok_button","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Sprite */
  let sprite = _alloc_Sprite() as root_sprite_SpriteIF  ;
  /* define type for all properties */
  sprite._definePropertyType("background", "s") ;
  sprite._definePropertyType("script", "s") ;
  sprite._definePropertyType("console", "i(ConsoleIF)") ;
  sprite._definePropertyType("nodes", "a(d(e(SpriteMaterial)))") ;
  sprite._definePropertyType("main", "f(v,[o(root_sprite_SpriteIF)])") ;
  sprite._definePropertyType("addNode", "f(v,[s,s,n])") ;
  sprite._definePropertyType("isPaused", "b") ;
  sprite._definePropertyType("isStarted", "f(b,[])") ;
  sprite._definePropertyType("start", "f(v,[])") ;
  /* define getter/setter for all properties */
  _definePropertyIF(sprite, ["background","script","console","nodes","main","addNode","isPaused","isStarted","start"]) ;
  /* assign user declared properties */
  sprite.background = "background";
  sprite.script = "scene";
  sprite.nodes = [{count:2, material:SpriteMaterial.image, script:"car", value:"car"}];
  sprite.main = function(self: root_sprite_SpriteIF): void {
  			self.start() ;
  			self.console.print("Hello") ;
  		};
  root.sprite = sprite ;
}
{
  /* allocate function for frame: ConsoleView */
  let console = _alloc_ConsoleView() as root_console_ConsoleViewIF  ;
  /* define type for all properties */
  console._definePropertyType("width", "n") ;
  console._definePropertyType("height", "n") ;
  console._definePropertyType("error", "f(v,[s])") ;
  console._definePropertyType("console", "i(ConsoleIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(console, ["width","height","error","console"]) ;
  /* assign user declared properties */
  console.width = 40;
  console.height = 5;
  root.console = console ;
}
{
  /* allocate function for frame: Button */
  let ok_button = _alloc_Button() as root_ok_button_ButtonIF  ;
  /* define type for all properties */
  ok_button._definePropertyType("title", "s") ;
  ok_button._definePropertyType("pressed", "f(v,[o(root_ok_button_ButtonIF)])") ;
  ok_button._definePropertyType("isEnabled", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(ok_button, ["title","pressed","isEnabled"]) ;
  /* assign user declared properties */
  ok_button.title = "OK";
  ok_button.pressed = function(self: root_ok_button_ButtonIF): void {
  	    	leaveView(0) ;
          };
  root.ok_button = ok_button ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
root.sprite.console = (function() {
 return root.console.console ; 
})() ;
/* execute initializer methods for frame sprite */
root.sprite.main(root.sprite) ;
/* This value will be return value of evaluateScript() */
root ;
