# `ListView` component

## Introduction
Text table

## Interface

This is the interface definition for TypeScript:
<pre>
interface ListViewIF extends FrameIF {
  isEditable : boolean ;
  items(): string[] ;
  setItems(p0 : string[]): void ;
  selectedItem : string | null ;
  updated : number ;
  visibleRowCounts : number ;
}
declare function _alloc_ListView(): ListViewIF ;

</pre>

## Example
You can find the sample script at
[table-view-0.jspkg](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples/list-view.jspkg) .

<pre>
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


</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



