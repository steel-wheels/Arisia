{
  checks: CheckBox {
    label:  string     "Check-0"
    status: boolean		false
  }
  checker: void listner(stat: root.checks.status) %{
	console.log("status = " + stat) ;
  %}
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
	    	leaveView(0) ;
        %}
  }
}

