# `Sprite` component

## Introduction
The view to display scrite node objects.
[sample-view](./Images/sprite-macos.png)

## Interface
This is the interface definition for TypeScript:
<pre>
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

</pre>

## Sample script
<pre>
{
	sprite: Sprite {
		background: string "background"
		script: string "scene"
		console: ConsoleIF %{ return root.console.console ; %}
		nodes: SpriteNodeDeclIF[] [
			{
				material: SpriteMaterial image
				value:   string "car"
				script:  string "car"
				count:   number 2
			}
		]
		main: init %{
			self.start() ;
			self.console.print("Hello") ;
		%}
	}
	console: ConsoleView {
		width:  number 40
		height: number  5
	}
	ok_button: Button {
		title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
	}
}


</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



