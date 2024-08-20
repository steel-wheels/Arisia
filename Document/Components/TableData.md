# `TableData` component

## Introduction
The TableData component manages the database which contains
multiple data records.

## Interface

This is the interface definition for TypeScript:
<pre>
interface TableDataIF extends FrameIF {
  name : string ;
}
declare function _alloc_TableData(): TableDataIF ;

</pre>

## Example
You can find the sample script at
[table-data-0.jspkg](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples/table-data-0.jspkg) .

### Type definition
<pre>
interface SampleRecordIF {
  c0: number ;
  c1: number ;
  c2: number ;
}


</pre>

### Initial data definition
<pre>
[
    {
      c0:   0,
      c1:   1,
      c2:   2
    },
    {
      c0:  10,
      c1:  11,
      c2:  12
    },
    {
      c0:  20,
      c1:  21,
      c2:  22
    }
]


</pre>

### IScript
<pre>
{
	table0: TableData {
		name:    string "table0"
	}
	calc_button: Button {
		title: string "Calc"
 		pressed: event() %{
			let table = root.table0.table ;
			console.print("count: " + table.recordCount + "\n") ;
			let cnt = table.recordCount ;
			for(let i=0 ; i<cnt ; i++){
				let rec = table.record(i) ;
				if(rec != null){
					console.print("" + i + ": c0 = " + rec.c0 + "\n") ;
	    			console.print("" + i + ": c1 = " + rec.c1 + "\n") ;
	    			console.print("" + i + ": c2 = " + rec.c2 + "\n") ;
        		} else {
	    			console.print("" + i + ": record not found\n") ;
				}
			}
		%}
	}
	quit_button: Button {
		title: string "Quit"
		pressed: event() %{
			//console.print("c0:    " + root.table0.record(0).c0 + "\n") ;
			leaveView(1) ;
		%}
	}
}


</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



