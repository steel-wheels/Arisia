/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/search-lib.d.ts"/>
/// <reference path="data/site-list.d.ts"/>
/// <reference path="types/search.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("site_list", "o(TableData)") ;
root._definePropertyType("search_label", "o(Label)") ;
root._definePropertyType("keyword", "o(TextField)") ;
root._definePropertyType("site_box", "o(Box)") ;
root._definePropertyType("buttons", "o(Box)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["site_list","search_label","keyword","site_box","buttons","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: TableData */
  let site_list = _alloc_TableData() as root_site_list_TableDataIF  ;
  /* define type for all properties */
  site_list._definePropertyType("name", "s") ;
  site_list._definePropertyType("table", "i(site_list_TableIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(site_list, ["name","table"]) ;
  /* assign user declared properties */
  site_list.name = "site_list";
  root.site_list = site_list ;
}
{
  /* allocate function for frame: Label */
  let search_label = _alloc_Label() as root_search_label_LabelIF  ;
  /* define type for all properties */
  search_label._definePropertyType("text", "s") ;
  search_label._definePropertyType("number", "n") ;
  /* define getter/setter for all properties */
  _definePropertyIF(search_label, ["text","number"]) ;
  /* assign user declared properties */
  search_label.text = "Search";
  root.search_label = search_label ;
}
{
  /* allocate function for frame: TextField */
  let keyword = _alloc_TextField() as root_keyword_TextFieldIF  ;
  /* define type for all properties */
  keyword._definePropertyType("isEditable", "b") ;
  keyword._definePropertyType("text", "s") ;
  keyword._definePropertyType("number", "n") ;
  keyword._definePropertyType("hasBackgroundColor", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(keyword, ["isEditable","text","number","hasBackgroundColor"]) ;
  /* assign user declared properties */
  keyword.isEditable = true;
  root.keyword = keyword ;
}
{
  /* allocate function for frame: Box */
  let site_box = _alloc_Box() as root_site_box_BoxIF  ;
  /* define type for all properties */
  site_box._definePropertyType("axis", "e(Axis)") ;
  site_box._definePropertyType("type", "o(PopupMenu)") ;
  site_box._definePropertyType("site", "o(PopupMenu)") ;
  site_box._definePropertyType("alignment", "e(Alignment)") ;
  site_box._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(site_box, ["axis","type","site","alignment","distribution"]) ;
  /* assign user declared properties */
  site_box.axis = Axis.horizontal;
  {
    /* allocate function for frame: PopupMenu */
    let type = _alloc_PopupMenu() as root_site_box_type_PopupMenuIF  ;
    /* define type for all properties */
    type._definePropertyType("main", "f(v,[o(root_site_box_type_PopupMenuIF)])") ;
    type._definePropertyType("current", "l(i(MenuItemIF))") ;
    type._definePropertyType("set", "f(v,[a(i(MenuItemIF))])") ;
    type._definePropertyType("selected", "f(v,[i(PopupMenuIF),i(MenuItemIF)])") ;
    /* define getter/setter for all properties */
    _definePropertyIF(type, ["main","current","set","selected"]) ;
    /* assign user declared properties */
    type.main = function(self: root_site_box_type_PopupMenuIF): void {
    					let items: MenuItemIF[] = [
    						MenuItem("related:", 0),
    						MenuItem("site:", 0)
    					] ;
    					self.set(items) ;
    				};
    site_box.type = type ;
  }
  {
    /* allocate function for frame: PopupMenu */
    let site = _alloc_PopupMenu() as root_site_box_site_PopupMenuIF  ;
    /* define type for all properties */
    site._definePropertyType("main", "f(v,[o(root_site_box_site_PopupMenuIF)])") ;
    site._definePropertyType("current", "l(i(MenuItemIF))") ;
    site._definePropertyType("set", "f(v,[a(i(MenuItemIF))])") ;
    site._definePropertyType("selected", "f(v,[i(PopupMenuIF),i(MenuItemIF)])") ;
    /* define getter/setter for all properties */
    _definePropertyIF(site, ["main","current","set","selected"]) ;
    /* assign user declared properties */
    site.main = function(self: root_site_box_site_PopupMenuIF): void {
    					let items = collectSiteNames(root.site_list.table) ;
    					self.set(items) ;
    				};
    site_box.site = site ;
  }
  root.site_box = site_box ;
}
{
  /* allocate function for frame: Box */
  let buttons = _alloc_Box() as root_buttons_BoxIF  ;
  /* define type for all properties */
  buttons._definePropertyType("axis", "e(Axis)") ;
  buttons._definePropertyType("search_button", "o(Button)") ;
  buttons._definePropertyType("quit_button", "o(Button)") ;
  buttons._definePropertyType("alignment", "e(Alignment)") ;
  buttons._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(buttons, ["axis","search_button","quit_button","alignment","distribution"]) ;
  /* assign user declared properties */
  buttons.axis = Axis.horizontal;
  {
    /* allocate function for frame: Button */
    let search_button = _alloc_Button() as root_buttons_search_button_ButtonIF  ;
    /* define type for all properties */
    search_button._definePropertyType("title", "s") ;
    search_button._definePropertyType("pressed", "f(v,[o(root_buttons_search_button_ButtonIF)])") ;
    search_button._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(search_button, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    search_button.title = "Search";
    search_button.pressed = function(self: root_buttons_search_button_ButtonIF): void {
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
    			};
    buttons.search_button = search_button ;
  }
  {
    /* allocate function for frame: Button */
    let quit_button = _alloc_Button() as root_buttons_quit_button_ButtonIF  ;
    /* define type for all properties */
    quit_button._definePropertyType("title", "s") ;
    quit_button._definePropertyType("pressed", "f(v,[o(root_buttons_quit_button_ButtonIF)])") ;
    quit_button._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(quit_button, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    quit_button.title = "Quit";
    quit_button.pressed = function(self: root_buttons_quit_button_ButtonIF): void {
    				leaveView(0) ;
    			};
    buttons.quit_button = quit_button ;
  }
  root.buttons = buttons ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* execute initializer methods for frame type */
root.site_box.type.main(root.site_box.type) ;
/* execute initializer methods for frame site */
root.site_box.site.main(root.site_box.site) ;
/* This value will be return value of evaluateScript() */
root ;
