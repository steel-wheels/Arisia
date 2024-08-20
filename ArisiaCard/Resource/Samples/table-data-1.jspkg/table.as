{
	table0: TableData {
		name:    string "table0"
	}
	calc_button: Button {
    	title: string "Calc"
		pressed: event() %{
			console.print("count: " + root.table0.recordCount + "\n") ;
			let table = root.table0.table ;
			for(let i=0 ; i < table.recordCount ; i++){
				let rec = table.record(i) ;
				if(rec != null){
					console.print(i + ": style=" + rec.style + "\n") ;
				}
			}
		%}
	}
	quit_button: Button {
		title: string "Quit"
		pressed: event() %{
			leaveView(1) ;
		%}
	}
}

