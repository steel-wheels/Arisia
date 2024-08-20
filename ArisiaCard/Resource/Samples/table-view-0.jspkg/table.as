{
  table0: TableView {
    name:    string "table0"
  }
//   cakc_button: Button {
//     title: string "Calc"
//     pressed: event() %{
//       console.print("count: " + root.table0.recordCount + "\n") ;
//       let cnt = root.table0.recordCount ;
//       for(let i=0 ; i<cnt ; i++){
//         let rec = root.table0.record(i) ;
// 	if(rec != null){
// 	    console.print("" + i + ": c0 = " + rec.c0 + "\n") ;
// 	    console.print("" + i + ": c1 = " + rec.c1 + "\n") ;
// 	    console.print("" + i + ": c2 = " + rec.c2 + "\n") ;
//         } else {
// 	    console.print("" + i + ": record not found\n") ;
//         }
//      }
//     %}
//   }
  quit_button: Button {
    title: string "Quit"
    pressed: event() %{
      //console.print("c0:    " + root.table0.record(0).c0 + "\n") ;
      leaveView(1) ;
    %}
  }
}

