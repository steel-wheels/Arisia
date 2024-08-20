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
        let urlp = openPanel("Select source file", FileType.file, ["js"]) ;
        if(urlp != null){
          root.shell.run(urlp!) ;
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

