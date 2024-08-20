{
  console: ConsoleView {
  }
  buttons: Box {
    axis: Axis horizontal
    hello_button: Button {
        title: string "Hello"
        pressed: event() %{
			let cons = root.console.console ;
			cons.print("Hello.\n") ;
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

