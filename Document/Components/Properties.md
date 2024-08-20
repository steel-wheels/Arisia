# `Property` component

## Introduction
The record database.
The initial values are defined in the resource file.
They are copied into the application support directory as cache file.
This component loads/stores the values from/to the cache file.

About the data format, see [storage](../arisia-storage.md).

## Interface

This is the interface definition for TypeScript:
<pre>
interface PropertiesDataIF extends FrameIF {
  name : string ;
}
declare function _alloc_PropertiesData(): PropertiesDataIF ;

</pre>

## Example
### Record type definition
The record type is described by <code>interface</code> of TypeScript.
<pre>
interface TeamIF {
  green: number ;
  blue:  number ;
}


</pre>

### Initial data definition
The record data is defined by JSON format.
<pre>
{
  green: 1,
  blue:  2
}


</pre>

### Source code
<pre>
{
	label: Label {
		text:   string     "Properties"
	}
	prop_data: PropertiesData {
		name:   string	"prop_data"
	}
	box: Box {
		axis: Axis horizontal
		set_button: Button {
			title: string "Set"
			pressed: event() %{
				root.prop_data.properties.blue  = 3 ;
				root.prop_data.properties.green = 4 ;
				let sum = root.prop_data.properties.blue 
					    + root.prop_data.properties.green 
					    ;
				console.print("sum: " + sum + "\n") ;
			%}
		}
		ok_button: Button {
			title: string "OK"
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



