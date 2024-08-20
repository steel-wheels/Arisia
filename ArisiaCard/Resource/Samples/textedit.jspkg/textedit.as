{
  edit: TextEdit {
    isEditable: boolean true
    main: init %{
	let term = root.edit.terminal ;
	term.string("Hello, from init.") ;
	term.execute() ;
    %}
  }
  buttons: Box {
    axis: Axis horizontal
    write_button: Button {
        title: string "Write"
        pressed: event() %{
	  let term = root.edit.terminal ;
          term.string("Hello, ") ;
	  term.foregroundColor(Colors.yellow) ;
	  term.backgroundColor(Colors.black) ;
          term.string("Good morning") ;
	  term.setFontStyle(FontStyle.monospace) ;
          term.string("Good evening") ;
          term.execute() ;
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

