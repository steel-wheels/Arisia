{
  menu: PopupMenu {
    main: init %{
      let menus: MenuItemIF[] = [
		MenuItem("apple",	0),
		MenuItem("banana",	1),
		MenuItem("cherry",	2)
      ] ;
      self.set(menus) ;
    %}
    selected: event(item: MenuItemIF) %{
		console.log("selected_item: " + item.title) ;
    %}
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
			let item = root.menu.current ;
			if(item != null){
				console.log("current: " + item.title) ;
			}
	    	leaveView(0) ;
        %}
  }
}

