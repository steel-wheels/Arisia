"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/home.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("logo", "o(Image)");
root._definePropertyType("home", "o(Collection)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["alignment", "logo", "home", "axis", "distribution"]);
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
    logo.name = "arisia_icon";
    root.logo = logo;
}
{
    /* allocate function for frame: Collection */
    let home = _alloc_Collection();
    /* define type for all properties */
    home._definePropertyType("load", "f(a(i(IconIF)),[])");
    home._definePropertyType("pressed", "f(v,[o(root_home_CollectionIF),n])");
    home._definePropertyType("count", "n");
    /* define getter/setter for all properties */
    _definePropertyIF(home, ["load", "pressed", "count"]);
    /* assign user declared properties */
    home.load = function () {
        let self = root.home;
        console.log("load icons");
        let result = [
            Icon(0, Symbols.play, "Run"),
            Icon(1, Symbols.terminal, "Terminal"),
            Icon(2, Symbols.magnifyingglass, "Search"),
            Icon(3, Symbols.gearshape, "Preference"),
            Icon(4, Symbols.gamecontroller, "Game"),
            Icon(5, Symbols.paintbrush, "Paint"),
            Icon(6, Symbols.gamecontroller, "Calender"),
            Icon(7, Symbols.gamecontroller, "Misc")
        ];
        return result;
    };
    home.pressed = function (self, index) {
        switch (index) {
            case 0:
                {
                    /* Run */
                    let url = openPanel("Select application", FileType.file, ["jspkg"]);
                    if (url != null) {
                        if (FileManager.isReadable(url)) {
                            run(url, [], console);
                        }
                        else {
                            console.log("Not readable");
                        }
                    }
                }
                break;
            case 1:
                {
                    /* Terminal */
                    enterView("terminal", null);
                }
                break;
            case 2:
                {
                    /* Search */
                    let url = env.searchPackage("Search.jspkg");
                    if (url != null) {
                        run(url, [], console);
                    }
                    else {
                        console.log("Search.jspkg is not found");
                    }
                }
                break;
            case 3:
                {
                    /* Preference */
                    enterView("preference", null);
                }
                break;
            case 4:
                {
                    /* Game */
                    enterView("game", null);
                }
                break;
            case 5:
                {
                    /* Paint */
                    enterView("paint", null);
                }
                break;
            case 6:
                {
                    /* Calender */
                    console.log("select calender");
                }
                break;
            case 7:
                {
                    /* Misc */
                    console.log("select misc");
                }
                break;
        }
    };
    root.home = home;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
