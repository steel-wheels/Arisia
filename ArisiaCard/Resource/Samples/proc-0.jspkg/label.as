{
  label: Label {
    text:   string     "Hello, World !!"

    set_text: void func(txt: string) %{
      self.text = txt ;
    %}
  }
  set_button: Button {
        title: string "Set"
        pressed: event() %{
          root.label.set_text("Goodmorning !!") ;
        %}
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
  }
}

