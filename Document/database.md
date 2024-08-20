# Database

## Introduction
This document describes about database programming on the Arisia Platform.
The Arisia Platoform supports *record based database system*.
The database is presented as an array of record object.

## File
### File location
Two files are required to implement the database:
* Type declaration file (<code>*.d.ts</code>)
* Data definition (<code>*.json</code>)

The location of these files are defined in the <code>tables</code> category in the
[manifest file](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiEngine/Document/manifest.md).

In the below example, the <code>record.d.ts</code> is the name of the type declaration file
and the <code>table.json</code> is the name of the data definition file.
<pre>
{
  application: "main.ts"
  views: {
	table: "table.as"
  }
  tables: {
    table0: {
      type: "record.d.ts"
      data: "table.json"
    }
  }
}


</pre>

Now, these files must be put in the <code>*.jspkg</code> directory.
They can not be shared beyond the applications.

#### Type declaration file
The <code>interface</code> declaration presents the interface of the record:
<pre>
interface SampleRecordIF {
  c0: number ;
  c1: number ;
  c2: number ;
}


</pre>

#### Data definition file
The file is defines initial value of the database.
The format is JSON.
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

#### Cache file
The <code>Data cache file</code> is the copy of the data definition file. The application read and modify the data cache file instead of the data definition file.

The cache file is created and updated by following method:
* If the cache data file is not exist, it is genetated by make copy of the data definition file.

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)


