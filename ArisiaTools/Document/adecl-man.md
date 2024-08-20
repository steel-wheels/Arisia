# <code>adecl</code> command

## Name
<code>adecl</code> - Generate type declaration file named <code>ArisiaPlatform.d.ts</code>)

## Synopsys
<pre>
adecl [options]
</pre>

## Description
The <code>adecl</code> command generates type declaration for the built-in classes, functions and types.

It contains built-in types which is defined in:
* [KiwiKibrary](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiLibrary)
* [ArisiaLibrary](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaLibrary)
* [ArisiaComponent](https://github.com/steelwheels/Arisia/tree/main/ArisiaComponents)

### Options
#### `-h`, `--help`
Output help message and quit the command.

#### `--version`
Output the version information and quit the command.

### <code>-i</code>, <code>--isolate</code>
When this option is given, type declaration files are generated for each classes. The file name is <code>class-CLASSNAME.d.tf</code>.

When this option is NOT give, the file name will be <code>ArisiaPlatform.d.ts</code>. It contains declarations of all classes.

# Reference
* [ArisiaTools](https://github.com/steelwheels/Arisia/tree/main/ArisiaTools): The framework which contains this command.
* [Arisia Programming Environment](https://github.com/steelwheels/Arisia/blob/main/README.md): The main page for Arisia Programming Environment.


