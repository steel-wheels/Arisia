{
	title: Label {
		text: string  "Paint"
	}
	return_button: Button {
		title: string "Return"
		pressed: event() %{
			leaveView(0) ;
		%}
	}
}

