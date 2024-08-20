# Arisia Storage

The arisia storage is non-volatile data for the application.
The arisia platfor supports following type of storages:
* Record storage
* Table storage

## Record
The "Record" contains multiple "key" and "value" pair.

### Record type
<pre>
interface record_t {
	key0:		number ;
	key1:		string ;
	...
} ;
</pre>
In usually, the definition is saved as the file <code>*.d.ts</code>.

### Record data
Define the initial value of the record.
<pre>
{
	key0:		1234,
	key1:		"one two three four"
}
</pre>
In usually, the definition is saved as the file <code>*.json</code>.

## Table
The "Table" contains the array of "Record" data.

### Table type
The type of table is the type of array of records.
<pre>
{
	records: record_t[] ;
}
</pre>

### Table data
#This is the initial value of the "Property".
In usually, the definition is saved as the file <code>*.json</code>.
<pre>
[
	{
	  key0:		1234,
	  key1:		"one two three four"
	},
	{
	  key0:		-2345,
	  key1:		"minus 2345"
	},
]
</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



