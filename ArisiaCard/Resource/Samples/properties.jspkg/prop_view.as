{
	label: Label {
		text:   string     "Properties"
	}
	prop_data: PropertiesData {
		name:   string	"prop_data"
	}
	box: Box {
		axis: Axis horizontal
		set_button: Button {
			title: string "Set"
			pressed: event() %{
				root.prop_data.properties.blue  = 3 ;
				root.prop_data.properties.green = 4 ;
				let sum = root.prop_data.properties.blue 
					    + root.prop_data.properties.green 
					    ;
				console.print("sum: " + sum + "\n") ;
			%}
		}
		ok_button: Button {
			title: string "OK"
			pressed: event() %{
				leaveView(0) ;
			%}
		}
	}
}

