{
  buttons: Box {
    axis: Axis vertical
    load_button: Button {
      title: string "Load"
      pressed: event() %{
        let url = openPanel("Select file to load", FileType.file, ["js"]) ;
        if(url != null){
          console.log("load file from " + url.path) ;
        }
      %}
    }
    save_button: Button {
      title: string "Save"
      pressed: event() %{
        let url = savePanel("Select file to load") ;
        if(url != null){
          console.log("save file to " + url.path) ;
        }
      %}
    }
    quit_button: Button {
      title: string "Quit"
      pressed: event() %{
        leaveView(0) ;
      %}
    }
  }
}

