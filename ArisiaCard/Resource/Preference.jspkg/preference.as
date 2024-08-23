{
  label: Label {
    text: string "Preference"
  }
  version: Label {
    text: string "Version: "
    main: init %{
		self.text = "Version: " + Preference.system.version ;
    %}
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
  }
}

