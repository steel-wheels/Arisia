{
	home: Collection { 
		load: IconIF[] func() %{
			console.log("load icons") ;
			let result: IconIF[] = [
				Icon(0, Symbols.play,   			"Run"),
				Icon(1, Symbols.terminal, 			"Terminal"),
				Icon(2, Symbols.magnifyingglass,	"Search"),
				Icon(3, Symbols.gearshape,		 	"Preference"),
				Icon(4, Symbols.gamecontroller, 	"Game"),
				Icon(5, Symbols.paintbrush, 		"Pait"),
				Icon(6, Symbols.gamecontroller, 	"Calender"),
				Icon(7, Symbols.gamecontroller, 	"Misc")
			] ;
			return result ;
		%}
	    pressed: event(index: number) %{
			console.log("pressed: " + index) ;
	    %}
	}
	ok_button: Button {
		title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
	}
}

