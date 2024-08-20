{
  label: Label {
    text:   string     "Hello, World !!"
  }
  set_button: Button {
        title: string "Set"
        pressed: event() %{
		root.label.text = "Week: " + Week.Monday ;
        %}
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
  }
}

