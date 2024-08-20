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

