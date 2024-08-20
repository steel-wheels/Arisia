{
  consoles: Box {
    axis: Axis horizontal
    blue: ConsoleView {
      width:  number 20
      height: number 15
    }
    green: ConsoleView {
     width:  number 20
     height: number 15
    }
  }
  buttons: Box {
    axis: Axis horizontal
    hello_button: Button {
        title: string "Hello"
        pressed: event() %{
          root.consoles.blue.console.print("Hello from blue\n") ;
          root.consoles.green.console.print("Hello from green\n") ;
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

