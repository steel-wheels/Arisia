# `openPanel` function
````
var url = openPanel(title: string, type: FileType, extensions: string[]): URLIF | null ;
````
## Parameters
|Name     |Type     |Description              |
|:---     |:---     |:---                     |
|title    |string   |Title of the panel       |
|type     |[FileType](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Enum/FileType.md) |File type: directory or file |
|extensions |string[] | Array of file extensions |

## Return value
|Type     |Description              |
|:---     |:---                     |
|URL      |Selected file or directory |
|null     |Use does not select the file or directory  |

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [ArisaLibrary Framework](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaLibrary)

