{
  list0: ListView {
    visibleRowCounts: number 4
    isEditable: boolean false
    main: init %{
      let items: string[] = [
        "january",
        "february",
        "march",
        "april",
        "may",
        "june",
        "july",
        "august",
        "september",
        "october",
        "november",
        "december",
      ] ;
      self.setItems(items) ;
    %}
    slct: void listner(item: root.list0.selectedItem) %{
      console.log("selected item = " + item) ;
    %}
    updt: void listner(item: root.list0.updated) %{
      console.log("updated: [" + self.items() + "]") ;
    %}
  }
  buttons: Box {
    axis: Axis horizontal
    edit_button: Button {
      title: string "Edit"
      pressed: event() %{
        if(root.list0.isEditable){
          console.log("editable: off") ;
          root.list0.isEditable = false ;
        } else {
          console.log("editable: on") ;
          root.list0.isEditable = true ;
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
}

