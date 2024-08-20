"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/machine.d.ts"/>
/// <reference path="types/team.d.ts"/>
/// <reference path="types/field.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("logo", "o(Image)");
root._definePropertyType("teams", "o(PropertiesData)");
root._definePropertyType("sprite", "o(Sprite)");
root._definePropertyType("console", "o(ConsoleView)");
root._definePropertyType("buttons", "o(Box)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["alignment", "logo", "teams", "sprite", "console", "buttons", "axis", "distribution"]);
/* assign user declared properties */
root.alignment = Alignment.center;
{
    /* allocate function for frame: Image */
    let logo = _alloc_Image();
    /* define type for all properties */
    logo._definePropertyType("name", "s");
    logo._definePropertyType("size", "f(s,[])");
    /* define getter/setter for all properties */
    _definePropertyIF(logo, ["name", "size"]);
    /* assign user declared properties */
    logo.name = "title";
    root.logo = logo;
}
{
    /* allocate function for frame: PropertiesData */
    let teams = _alloc_PropertiesData();
    /* define type for all properties */
    teams._definePropertyType("name", "s");
    teams._definePropertyType("properties", "i(PropIF)");
    /* define getter/setter for all properties */
    _definePropertyIF(teams, ["name", "properties"]);
    /* assign user declared properties */
    teams.name = "team_properties";
    root.teams = teams;
}
{
    /* allocate function for frame: Sprite */
    let sprite = _alloc_Sprite();
    /* define type for all properties */
    sprite._definePropertyType("background", "s");
    sprite._definePropertyType("script", "s");
    sprite._definePropertyType("nodes", "a(y)");
    sprite._definePropertyType("console", "i(ConsoleIF)");
    sprite._definePropertyType("addNode", "f(v,[s,s,n])");
    sprite._definePropertyType("isPaused", "b");
    sprite._definePropertyType("isStarted", "f(b,[])");
    sprite._definePropertyType("start", "f(v,[])");
    /* define getter/setter for all properties */
    _definePropertyIF(sprite, ["background", "script", "nodes", "console", "addNode", "isPaused", "isStarted", "start"]);
    /* assign user declared properties */
    sprite.background = "background";
    sprite.script = "scene";
    sprite.nodes = [];
    root.sprite = sprite;
}
{
    /* allocate function for frame: ConsoleView */
    let console = _alloc_ConsoleView();
    /* define type for all properties */
    console._definePropertyType("width", "n");
    console._definePropertyType("height", "n");
    console._definePropertyType("main", "f(v,[o(root_console_ConsoleViewIF)])");
    console._definePropertyType("error", "f(v,[s])");
    console._definePropertyType("console", "i(ConsoleIF)");
    /* define getter/setter for all properties */
    _definePropertyIF(console, ["width", "height", "main", "error", "console"]);
    /* assign user declared properties */
    console.width = 40;
    console.height = 5;
    console.main = function (self) {
        self.console.print("Hello\n");
    };
    root.console = console;
}
{
    /* allocate function for frame: Box */
    let buttons = _alloc_Box();
    /* define type for all properties */
    buttons._definePropertyType("axis", "e(Axis)");
    buttons._definePropertyType("start", "o(Button)");
    buttons._definePropertyType("quit", "o(Button)");
    buttons._definePropertyType("alignment", "e(Alignment)");
    buttons._definePropertyType("distribution", "e(Distribution)");
    /* define getter/setter for all properties */
    _definePropertyIF(buttons, ["axis", "start", "quit", "alignment", "distribution"]);
    /* assign user declared properties */
    buttons.axis = Axis.horizontal;
    {
        /* allocate function for frame: Button */
        let start = _alloc_Button();
        /* define type for all properties */
        start._definePropertyType("title", "f(s,[o(root_buttons_start_ButtonIF),b])");
        start._definePropertyType("pressed", "f(v,[o(root_buttons_start_ButtonIF)])");
        start._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(start, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        start.pressed = function (self) {
            if (root.sprite.isPaused) {
                /* Pause On  -> Off */
                if (root.sprite.isStarted()) {
                    root.sprite.isPaused = false;
                }
                else {
                    console.log("start");
                    let blue = root.teams.properties.blue;
                    let green = root.teams.properties.green;
                    root.sprite.addNode("car", blue.script, blue.count);
                    root.sprite.addNode("car", green.script, green.count);
                    root.sprite.start();
                }
            }
            else {
                /* Pause Off -> On  */
                root.sprite.isPaused = true;
            }
        };
        buttons.start = start;
    }
    {
        /* allocate function for frame: Button */
        let quit = _alloc_Button();
        /* define type for all properties */
        quit._definePropertyType("title", "s");
        quit._definePropertyType("pressed", "f(v,[o(root_buttons_quit_ButtonIF)])");
        quit._definePropertyType("isEnabled", "b");
        /* define getter/setter for all properties */
        _definePropertyIF(quit, ["title", "pressed", "isEnabled"]);
        /* assign user declared properties */
        quit.title = "Quit";
        quit.pressed = function (self) {
            leaveView(0);
        };
        buttons.quit = quit;
    }
    root.buttons = buttons;
}
/* Define listner functions */
let _lfunc_root_buttons_start_title = function (self, paused) {
    return paused ? "Start" : "Stop";
};
/* add observers for listner function */
root.sprite._addObserver("isPaused", function () {
    let self = root.buttons.start;
    let paused = root.sprite.isPaused;
    root.buttons.start.title = _lfunc_root_buttons_start_title(self, paused);
});
/* Setup the component */
_setup_component(root);
/* call listner methods to initialize it's property value for frame start */
root.buttons.start.title = _lfunc_root_buttons_start_title(root.buttons.start, root.sprite.isPaused);
root.sprite.console = (function () {
    return root.console.console;
})();
/* execute initializer methods for frame console */
root.console.main(root.console);
/* This value will be return value of evaluateScript() */
root;
