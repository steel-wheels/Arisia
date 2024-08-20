/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/machine.d.ts"/>
/// <reference path="types/team.d.ts"/>
/// <reference path="types/home.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box() as root_BoxIF  ;
/* define type for all properties */
root._definePropertyType("logo", "o(Image)") ;
root._definePropertyType("teams", "o(PropertiesData)") ;
root._definePropertyType("controls", "o(Box)") ;
root._definePropertyType("buttons", "o(Box)") ;
root._definePropertyType("axis", "e(Axis)") ;
root._definePropertyType("alignment", "e(Alignment)") ;
root._definePropertyType("distribution", "e(Distribution)") ;
/* define getter/setter for all properties */
_definePropertyIF(root, ["logo","teams","controls","buttons","axis","alignment","distribution"]) ;
{
  /* allocate function for frame: Image */
  let logo = _alloc_Image() as root_logo_ImageIF  ;
  /* define type for all properties */
  logo._definePropertyType("name", "s") ;
  logo._definePropertyType("size", "f(s,[])") ;
  /* define getter/setter for all properties */
  _definePropertyIF(logo, ["name","size"]) ;
  /* assign user declared properties */
  logo.name = "title";
  root.logo = logo ;
}
{
  /* allocate function for frame: PropertiesData */
  let teams = _alloc_PropertiesData() as root_teams_PropertiesDataIF  ;
  /* define type for all properties */
  teams._definePropertyType("name", "s") ;
  teams._definePropertyType("properties", "i(PropIF)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(teams, ["name","properties"]) ;
  /* assign user declared properties */
  teams.name = "team_properties";
  root.teams = teams ;
}
{
  /* allocate function for frame: Box */
  let controls = _alloc_Box() as root_controls_BoxIF  ;
  /* define type for all properties */
  controls._definePropertyType("axis", "e(Axis)") ;
  controls._definePropertyType("blue", "o(Box)") ;
  controls._definePropertyType("green", "o(Box)") ;
  controls._definePropertyType("alignment", "e(Alignment)") ;
  controls._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(controls, ["axis","blue","green","alignment","distribution"]) ;
  /* assign user declared properties */
  controls.axis = Axis.horizontal;
  {
    /* allocate function for frame: Box */
    let blue = _alloc_Box() as root_controls_blue_BoxIF  ;
    /* define type for all properties */
    blue._definePropertyType("axis", "e(Axis)") ;
    blue._definePropertyType("select", "o(Box)") ;
    blue._definePropertyType("count", "o(Stepper)") ;
    blue._definePropertyType("alignment", "e(Alignment)") ;
    blue._definePropertyType("distribution", "e(Distribution)") ;
    /* define getter/setter for all properties */
    _definePropertyIF(blue, ["axis","select","count","alignment","distribution"]) ;
    /* assign user declared properties */
    blue.axis = Axis.vertical;
    {
      /* allocate function for frame: Box */
      let select = _alloc_Box() as root_controls_blue_select_BoxIF  ;
      /* define type for all properties */
      select._definePropertyType("axis", "e(Axis)") ;
      select._definePropertyType("button", "o(Button)") ;
      select._definePropertyType("name", "o(TextField)") ;
      select._definePropertyType("alignment", "e(Alignment)") ;
      select._definePropertyType("distribution", "e(Distribution)") ;
      /* define getter/setter for all properties */
      _definePropertyIF(select, ["axis","button","name","alignment","distribution"]) ;
      /* assign user declared properties */
      select.axis = Axis.horizontal;
      {
        /* allocate function for frame: Button */
        let button = _alloc_Button() as root_controls_blue_select_button_ButtonIF  ;
        /* define type for all properties */
        button._definePropertyType("title", "s") ;
        button._definePropertyType("pressed", "f(v,[o(root_controls_blue_select_button_ButtonIF)])") ;
        button._definePropertyType("isEnabled", "b") ;
        /* define getter/setter for all properties */
        _definePropertyIF(button, ["title","pressed","isEnabled"]) ;
        /* assign user declared properties */
        button.title = "File";
        button.pressed = function(self: root_controls_blue_select_button_ButtonIF): void {
        						let url = openPanel("Select machine script",
        							FileType.file, ["js"]) ;
        						if(url != null){
        							let name = url.lastPathComponent ;
        							root.teams.properties.blue.script = url.path ;
        							root.controls.blue.select.name.text = name ;
        						}
        					};
        select.button = button ;
      }
      {
        /* allocate function for frame: TextField */
        let name = _alloc_TextField() as root_controls_blue_select_name_TextFieldIF  ;
        /* define type for all properties */
        name._definePropertyType("isEditable", "b") ;
        name._definePropertyType("hasBackgroundColor", "b") ;
        name._definePropertyType("text", "s") ;
        name._definePropertyType("number", "n") ;
        /* define getter/setter for all properties */
        _definePropertyIF(name, ["isEditable","hasBackgroundColor","text","number"]) ;
        /* assign user declared properties */
        name.isEditable = false;
        name.hasBackgroundColor = true;
        select.name = name ;
      }
      blue.select = select ;
    }
    {
      /* allocate function for frame: Stepper */
      let count = _alloc_Stepper() as root_controls_blue_count_StepperIF  ;
      /* define type for all properties */
      count._definePropertyType("initValue", "n") ;
      count._definePropertyType("maxValue", "n") ;
      count._definePropertyType("minValue", "n") ;
      count._definePropertyType("updated", "f(v,[o(root_controls_blue_count_StepperIF),n])") ;
      count._definePropertyType("stepValue", "n") ;
      /* define getter/setter for all properties */
      _definePropertyIF(count, ["initValue","maxValue","minValue","updated","stepValue"]) ;
      /* assign user declared properties */
      count.initValue = 1;
      count.maxValue = 5;
      count.minValue = 1;
      count.updated = function(self: root_controls_blue_count_StepperIF, val: number): void {
      					console.log("blue: " + val) ;
      					root.teams.properties.blue.count = val ;
      				};
      blue.count = count ;
    }
    controls.blue = blue ;
  }
  {
    /* allocate function for frame: Box */
    let green = _alloc_Box() as root_controls_green_BoxIF  ;
    /* define type for all properties */
    green._definePropertyType("axis", "e(Axis)") ;
    green._definePropertyType("select", "o(Box)") ;
    green._definePropertyType("count", "o(Stepper)") ;
    green._definePropertyType("alignment", "e(Alignment)") ;
    green._definePropertyType("distribution", "e(Distribution)") ;
    /* define getter/setter for all properties */
    _definePropertyIF(green, ["axis","select","count","alignment","distribution"]) ;
    /* assign user declared properties */
    green.axis = Axis.vertical;
    {
      /* allocate function for frame: Box */
      let select = _alloc_Box() as root_controls_green_select_BoxIF  ;
      /* define type for all properties */
      select._definePropertyType("axis", "e(Axis)") ;
      select._definePropertyType("button", "o(Button)") ;
      select._definePropertyType("name", "o(TextField)") ;
      select._definePropertyType("alignment", "e(Alignment)") ;
      select._definePropertyType("distribution", "e(Distribution)") ;
      /* define getter/setter for all properties */
      _definePropertyIF(select, ["axis","button","name","alignment","distribution"]) ;
      /* assign user declared properties */
      select.axis = Axis.horizontal;
      {
        /* allocate function for frame: Button */
        let button = _alloc_Button() as root_controls_green_select_button_ButtonIF  ;
        /* define type for all properties */
        button._definePropertyType("title", "s") ;
        button._definePropertyType("pressed", "f(v,[o(root_controls_green_select_button_ButtonIF)])") ;
        button._definePropertyType("isEnabled", "b") ;
        /* define getter/setter for all properties */
        _definePropertyIF(button, ["title","pressed","isEnabled"]) ;
        /* assign user declared properties */
        button.title = "File";
        button.pressed = function(self: root_controls_green_select_button_ButtonIF): void {
        						let url = openPanel("Select machine script",
        							FileType.file, ["js"]) ;
        						if(url != null){
        							let name = url.lastPathComponent ;
        							root.teams.properties.green.script = url.path ;
        							root.controls.green.select.name.text = name ;
        						}
        					};
        select.button = button ;
      }
      {
        /* allocate function for frame: TextField */
        let name = _alloc_TextField() as root_controls_green_select_name_TextFieldIF  ;
        /* define type for all properties */
        name._definePropertyType("isEditable", "b") ;
        name._definePropertyType("hasBackgroundColor", "b") ;
        name._definePropertyType("text", "s") ;
        name._definePropertyType("number", "n") ;
        /* define getter/setter for all properties */
        _definePropertyIF(name, ["isEditable","hasBackgroundColor","text","number"]) ;
        /* assign user declared properties */
        name.isEditable = false;
        name.hasBackgroundColor = true;
        select.name = name ;
      }
      green.select = select ;
    }
    {
      /* allocate function for frame: Stepper */
      let count = _alloc_Stepper() as root_controls_green_count_StepperIF  ;
      /* define type for all properties */
      count._definePropertyType("initValue", "n") ;
      count._definePropertyType("maxValue", "n") ;
      count._definePropertyType("minValue", "n") ;
      count._definePropertyType("updated", "f(v,[o(root_controls_green_count_StepperIF),n])") ;
      count._definePropertyType("stepValue", "n") ;
      /* define getter/setter for all properties */
      _definePropertyIF(count, ["initValue","maxValue","minValue","updated","stepValue"]) ;
      /* assign user declared properties */
      count.initValue = 1;
      count.maxValue = 5;
      count.minValue = 1;
      count.updated = function(self: root_controls_green_count_StepperIF, val: number): void {
      					console.log("green: " + val) ;
      					root.teams.properties.green.count = val ;
      				};
      green.count = count ;
    }
    controls.green = green ;
  }
  root.controls = controls ;
}
{
  /* allocate function for frame: Box */
  let buttons = _alloc_Box() as root_buttons_BoxIF  ;
  /* define type for all properties */
  buttons._definePropertyType("axis", "e(Axis)") ;
  buttons._definePropertyType("run", "o(Button)") ;
  buttons._definePropertyType("quit", "o(Button)") ;
  buttons._definePropertyType("alignment", "e(Alignment)") ;
  buttons._definePropertyType("distribution", "e(Distribution)") ;
  /* define getter/setter for all properties */
  _definePropertyIF(buttons, ["axis","run","quit","alignment","distribution"]) ;
  /* assign user declared properties */
  buttons.axis = Axis.horizontal;
  {
    /* allocate function for frame: Button */
    let run = _alloc_Button() as root_buttons_run_ButtonIF  ;
    /* define type for all properties */
    run._definePropertyType("title", "s") ;
    run._definePropertyType("pressed", "f(v,[o(root_buttons_run_ButtonIF)])") ;
    run._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(run, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    run.title = "Run";
    run.pressed = function(self: root_buttons_run_ButtonIF): void {
    				enterView("field", null) ;
    			};
    buttons.run = run ;
  }
  {
    /* allocate function for frame: Button */
    let quit = _alloc_Button() as root_buttons_quit_ButtonIF  ;
    /* define type for all properties */
    quit._definePropertyType("title", "s") ;
    quit._definePropertyType("pressed", "f(v,[o(root_buttons_quit_ButtonIF)])") ;
    quit._definePropertyType("isEnabled", "b") ;
    /* define getter/setter for all properties */
    _definePropertyIF(quit, ["title","pressed","isEnabled"]) ;
    /* assign user declared properties */
    quit.title = "Quit";
    quit.pressed = function(self: root_buttons_quit_ButtonIF): void {
    				leaveView(0) ;
    			};
    buttons.quit = quit ;
  }
  root.buttons = buttons ;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root) ;
/* This value will be return value of evaluateScript() */
root ;
