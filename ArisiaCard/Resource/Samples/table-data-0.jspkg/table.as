{
	table0: TableData {
		name:    string "table0"
	}
	calc_button: Button {
		title: string "Calc"
 		pressed: event() %{
			let table = root.table0.table ;
			console.print("count: " + table.recordCount + "\n") ;
			let cnt = table.recordCount ;
			for(let i=0 ; i<cnt ; i++){
				let rec = table.record(i) ;
				if(rec != null){
					console.print("" + i + ": c0 = " + rec.c0 + "\n") ;
	    			console.print("" + i + ": c1 = " + rec.c1 + "\n") ;
	    			console.print("" + i + ": c2 = " + rec.c2 + "\n") ;
        		} else {
	    			console.print("" + i + ": record not found\n") ;
				}
			}
		%}
	}
	quit_button: Button {
		title: string "Quit"
		pressed: event() %{
			//console.print("c0:    " + root.table0.record(0).c0 + "\n") ;
			leaveView(1) ;
		%}
	}
}

