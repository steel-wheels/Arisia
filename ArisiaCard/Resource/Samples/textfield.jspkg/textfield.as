{
	edit: TextField {
		isEditable: boolean true
		hasBackgroundColor: boolean true
		text: string "hello"
	}
	ok_button: Button {
		title: string "OK"
		pressed: event() %{
			console.log("textfield: " + root.edit.text) ;
			leaveView(0) ;
		%}
	}
}

