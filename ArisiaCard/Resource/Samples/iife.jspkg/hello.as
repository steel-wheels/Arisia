{
  label: Label {
    text: string "Hello, World !!"
    a: number 1
    b: number 2
    c: number %{ return root.label.a + root.label.b ; %}
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
  }
}

