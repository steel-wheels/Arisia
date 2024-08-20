{
	homeIcon: IconView {
		symbol: string "house"
		title:  string "home"
		pressed: event() %{
			console.log("home") ;
		%}
	}
	ok_button: Button {
		title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
	}
}

