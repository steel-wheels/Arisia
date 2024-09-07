/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/game.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("title", "o(Label)") ;
root._definePropertyType("top", "o(Box)") ;
root._definePropertyType("return_button", "o(Button)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["title","top","return_button","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Label */
  let title = _alloc_Label() as root_title_LabelIF  ;
  /* define type for all properties */
  title._definePropertyType("text", "s") ;
  title._definePropertyType("number", "n") ;
  /* define getter/setter for all properties */
  _definePropertyIF(title, ["text","number"]) ;
  /* assign user declared properties */
  title.text = "Game";
  root.title = title ;
}
{
  /* allocate function for frame: Box */
  let top = _alloc_Box() as root_top_BoxIF  ;
  /* define type for all properties */
  top._definePropertyType("axis", "e(Axis)") ;
  top._definePropertyType("box0", "o(Box)") ;
  top._definePropertyType("alignment", "e(Alignment)") ;
  top._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(top, ["axis","box0","alignment","distribution"]) ;
  /* assign user declared properties */
  top.axis = Axis.vertical;
  {
    /* allocate function for frame: Box */
    let box0 = _alloc_Box() as root_top_box0_BoxIF  ;
    /* define type for all properties */
    box0._definePropertyType("axis", "e(Axis)") ;
    box0._definePropertyType("bfcIcon", "o(IconView)") ;
    box0._definePropertyType("alignment", "e(Alignment)") ;
    box0._definePropertyType("distribution", "e(Distribution)") ;
    /* define getter/setter for all properties */
    _definePropertyIF(box0, ["axis","bfcIcon","alignment","distribution"]) ;
    /* assign user declared properties */
    box0.axis = Axis.horizontal;
    {
      /* allocate function for frame: IconView */
      let bfcIcon = _alloc_IconView() as root_top_box0_bfcIcon_IconViewIF  ;
      /* define type for all properties */
      bfcIcon._definePropertyType("symbol", "e(Symbols)") ;
      bfcIcon._definePropertyType("title", "s") ;
      bfcIcon._definePropertyType("pressed", "f(v,[o(root_top_box0_bfcIcon_IconViewIF)])") ;
      /* define getter/setter for all properties */
      _definePropertyIF(bfcIcon, ["symbol","title","pressed"]) ;
      /* assign user declared properties */
      bfcIcon.symbol = Symbols.terminal;
      bfcIcon.title = "Battle Field Code";
      bfcIcon.pressed = function(self: root_top_box0_bfcIcon_IconViewIF): void {
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
              };
      box0.bfcIcon = bfcIcon ;
    }
    top.box0 = box0 ;
  }
  root.top = top ;
}
{
  /* allocate function for frame: Button */
  let return_button = _alloc_Button() as root_return_button_ButtonIF  ;
  /* define type for all properties */
  return_button._definePropertyType("title", "s") ;
  return_button._definePropertyType("pressed", "f(v,[o(root_return_button_ButtonIF)])") ;
  return_button._definePropertyType("isEnabled", "b") ;
  /* define getter/setter for all properties */
  _definePropertyIF(return_button, ["title","pressed","isEnabled"]) ;
  /* assign user declared properties */
  return_button.title = "Return";
  return_button.pressed = function(self: root_return_button_ButtonIF): void {
        leaveView(0) ;
      };
  root.return_button = return_button ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
