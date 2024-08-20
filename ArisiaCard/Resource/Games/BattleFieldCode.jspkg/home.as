{
	logo: Image {
		name: string "title"
	}
	teams: PropertiesData {
		name: string "team_properties"
	}
	controls: Box {
		axis: Axis horizontal
		blue: Box {
			axis: Axis vertical
			select: Box {
				axis: Axis horizontal
				button: Button {
					title: string "File"
					pressed: event() %{
						let url = openPanel("Select machine script",
							FileType.file, ["js"]) ;
						if(url != null){
							let name = url.lastPathComponent ;
							root.teams.properties.blue.script = url.path ;
							root.controls.blue.select.name.text = name ;
						}
					%}
				}
				name: TextField {
					isEditable: boolean false
					hasBackgroundColor: boolean true
				}
			}
			count: Stepper {
				initValue: number 1
				maxValue:  number 5
				minValue:  number 1
			    updated: event(val: number) %{
					console.log("blue: " + val) ;
					root.teams.properties.blue.count = val ;
				%}
			}
		}
    	green: Box {
			axis: Axis vertical
			select: Box {
				axis: Axis horizontal
				button: Button {
					title: string "File"
					pressed: event() %{
						let url = openPanel("Select machine script",
							FileType.file, ["js"]) ;
						if(url != null){
							let name = url.lastPathComponent ;
							root.teams.properties.green.script = url.path ;
							root.controls.green.select.name.text = name ;
						}
					%}
          		}
				name: TextField {
					isEditable: boolean false
					hasBackgroundColor: boolean true
				}
			}
  			count: Stepper {
				initValue: number 1
				maxValue:  number 5
				minValue:  number 1
			    updated: event(val: number) %{
					console.log("green: " + val) ;
					root.teams.properties.green.count = val ;
				%}
			}
		}
	}
	buttons: Box {
		axis: Axis horizontal
		run: Button {
			title: string "Run"
			pressed: event() %{
				enterView("field", null) ;
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

