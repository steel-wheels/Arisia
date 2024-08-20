{
	alignment: Alignment center
	logo: Image {
		name:  string  "title"
	}
	teams: PropertiesData {
		name: string "team_properties"
	}
	sprite: Sprite {
		background: string "background"
		script: string "scene"
		nodes: SpriteNodeDeclIF[] []
		console: ConsoleIF %{ return root.console.console ; %}
	}
	console: ConsoleView {
		width:  number 40
		height: number  5
		main: init %{
			self.console.print("Hello\n") ;
		%}
	}
	buttons: Box {
		axis: Axis horizontal
		start: Button {
			title: string listner(paused: root.sprite.isPaused) %{
				return paused ? "Start" : "Stop" ;
			%}
			pressed: event() %{
				if(root.sprite.isPaused){
					/* Pause On  -> Off */
					if(root.sprite.isStarted()){
						root.sprite.isPaused = false ;
					} else {
						console.log("start") ;
						let blue  = root.teams.properties.blue ;
						let green = root.teams.properties.green ;
						root.sprite.addNode(
							"car",
							blue.script,
							blue.count
						) ;
						root.sprite.addNode(
							"car",
							green.script,
							green.count
						) ;
						root.sprite.start() ;
					}
				} else {
					/* Pause Off -> On  */
					root.sprite.isPaused = true ;
				}

			%}
		}
		quit: Button {
			title: string "Quit"
			pressed: event() %{
				leaveView(0) ;
			%}
		}
	}
}

