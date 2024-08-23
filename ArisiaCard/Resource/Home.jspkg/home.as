{
	alignment: Alignment center
	logo: Image {
		name:  string  "arisia_icon"
	}
	home: Collection { 
		load: IconIF[] func() %{
			console.log("load icons") ;
			let result: IconIF[] = [
				Icon(0, Symbols.play,   			"Run"),
				Icon(1, Symbols.terminal, 			"Terminal"),
				Icon(2, Symbols.magnifyingglass,	"Search"),
				Icon(3, Symbols.gearshape,		 	"Preference"),
				Icon(4, Symbols.gamecontroller, 	"Game"),
				Icon(5, Symbols.paintbrush, 		"Paint"),
				Icon(6, Symbols.gamecontroller, 	"Calender"),
				Icon(7, Symbols.gamecontroller, 	"Misc")
			] ;
			return result ;
		%}
	    pressed: event(index: number) %{
			switch(index){
			  case 0: {
				/* Run */
				let url = openPanel("Select application",
						FileType.file, ["jspkg"]) ;
				if(url != null){
					if(FileManager.isReadable(url)){
						run(url, [], console) ;
					} else {
						console.log("Not readable") ;
					}
				}
			  } break ;
			  case 1: {
				/* Terminal */
				enterView("terminal", null) ;
			  } break ;
			  case 2: {
				/* Search */
				let url = env.searchPackage("Search.jspkg") ;
				if(url != null){
					run(url, [], console) ;
				} else {
					console.log("Search.jspkg is not found") ;
				}
			  } break ;
			  case 3: {
				/* Preference */
				let url = env.searchPackage("Preference.jspkg") ;
				if(url != null){
					run(url, [], console) ;
				} else {
					console.log("Preference.jspkg is not found") ;
				}
			  } break ;
			  case 4: {
				/* Game */
				enterView("game", null) ;
			  } break ;
			  case 5: {
				/* Paint */
				enterView("paint", null) ;
			  } break ;
			  case 6: {
				/* Calender */
				console.log("select calender") ;
			  } break ;
			  case 7: {
				/* Misc */
				console.log("select misc") ;
			  } break ;
			}
	    %}
	}
}

