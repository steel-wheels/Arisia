# `Panel` functions

## Introduction
Use the panel to select the file to be opened or saved.

## Interface

This is the interface definition for TypeScript:
<pre>
/// <reference path="ArisiaLibrary.d.ts" />
/// <reference path="Builtin.d.ts" />
declare function openPanel(title: string, type: FileType, exts: string[]): URLIF | null;
declare function savePanel(title: string): URLIF | null;

</pre>

See [FileType](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Enum/FileType.md) and [URLIF](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Class/URL.md).

## Example
sample script: [panel.jspkg](https://gitlab.com/steewheels/arisia/-/blob/main/ArisiaCard/Resource/Samples/panel.jspkg)

<pre>
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


</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



