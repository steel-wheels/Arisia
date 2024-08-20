{
	table: TableView {
		name:    string "site_list"
	}
	edit_box: Box {
		axis:  Axis  vertical
		name_label: Label { text: string "name" }
		name_field: TextField {
			isEditable: boolean		true
		}
		site_label: Label { text: string "site" }
		site_field: TextField {
			isEditable: boolean		true
		}
	}
	quit_button: Button {
		title: string "Quit"
		pressed: event() %{
			leaveView(1) ;
		%}
	}
}

