{
  label: Label {
    text: string "Hello, World !!"
    main: init %{
		console.log("Display alert") ;
		alert(AlertType.informational,
			  "Alert message",
			  ["OK", "Cancel"]) ;
    %}
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
  }
}

