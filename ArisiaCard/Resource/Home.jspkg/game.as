{
  title: Label {
    text: string  "Game"
  }
  top: Box {
    axis: Axis vertical
    box0: Box {
      axis: Axis horizontal
      bfcIcon: IconView {
        symbol: Symbols terminal
        title:  string "Battle Field Code"
        pressed: event() %{
  	  /* execute ./Games/BattleFieldCode.jspkg */
          let resdir = FileManager.resourceDirectory ;
	  let bfcdir = resdir.appending("Games/BattleFieldCode.jspkg") ;
	  if(FileManager.fileExists(bfcdir)) {
            runThread(bfcdir, [], console) ;
	  } else {
	    console.log("Files is NOT exist " + bfcdir.path) ;
	  }
/*
	  console.log("this dir: " + packurl.path) ;
  					FileType.file, ["jspkg"]) ;
          if(url != null){
  	    if(FileManager.isReadable(url)){
  	      run(url, [], console) ;
  	    } else {
                console.log("Not readable") ;
  	    }
          }
*/
        %}
      }
    }
  }
  return_button: Button {
    title: string "Return"
    pressed: event() %{
      leaveView(0) ;
    %}
  }
}

