{
	site_list: TableData {
		name:    string "site_list"
	}
	search_label: Label {
		text: string "Search"
    }
	keyword: TextField {
		isEditable:	boolean true
	}
    site_box: Box {
			axis: Axis horizontal
			type: PopupMenu {
				main: init %{
					let items: MenuItemIF[] = [
						MenuItem("related:", 0),
						MenuItem("site:", 0)
					] ;
					self.set(items) ;
				%}
			}
			site: PopupMenu {
				main: init %{
					let items = collectSiteNames(root.site_list.table) ;
					self.set(items) ;
				%}
			}
    }
	buttons: Box {
		axis: Axis horizontal
		search_button: Button {
			title: string "Search"
			pressed: event() %{
				let launcher = new GoogleLauncher(root.site_list.table) ;
				/* set keyword */
				launcher.set_keyword(root.keyword.text) ;
				/* set site type */
				let typeitem = root.site_box.type.current ;
				if(typeitem != null){
					launcher.set_site_type(typeitem.title) ;
				}
				/* set site */
				let siteitem = root.site_box.site.current ;
				if(siteitem != null){
					let site = siteitem.title ;
					if(site != "none"){
							launcher.set_site(site) ;
					}
				}
				launcher.launch() ;
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

