{
  terminal: Terminal {
  }
  shell: Shell {
    main: init %{
      self.console = root.terminal.console ;
    %}
  }
  buttons: Box {
    axis: Axis horizontal
    run: Button {
      title: string "Run"
      pressed: event() %{
        let urlp = openPanel("Select source file", FileType.file, ["jspkg"]) ;
        if(urlp != null){
		  runThread(urlp, [], root.terminal.console) ;
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

