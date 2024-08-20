# <code>asc</code> command

## Name
<code>asc</code> - Arisia Script Compiler

## Synopsys
<pre>
asc [options] arisia-script-file
</pre>

## Description
The <code>asc</code> command is Arisia Script Compiler. It compile [ArisiaScript](https://github.com/steelwheels/Arisia/blob/main/Document/arisia-lang.md) file and output the [JavaScript](https://en.wikipedia.org/wiki/JavaScript), [TypeScript](https://en.wikipedia.org/wiki/TypeScript) or [type declaration File (*.d.ts)](https://en.wikipedia.org/wiki/TypeScript) for it. The [manifest file](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiEngine/Document/Document/manifest.md) is also read to get custom data type definition from it.

### Options
#### <code>-h</code>, <code>--help</code>
Output help message and quit the command.

#### <code>-I</code>, <code>--import</code> *file-of-*.d.ts*
Add <code>.d.ts</code> file to import. If you give <code>-I types/A.d.ts</code> option, the output sript contains:
<pre>
/// <reference path="types/A.d.ts" />
</pre>

#### <code>--version</code>
Output the version information and quit the command.

#### <code>-f</code>, <code>--format</code> *format*:
The format of output file. Select one format from <code>TypeScript</code> or <code>TypeDeclaration</code>.

### <code>-p</code>, <code>--package</code> *package-directory*
The package directory which contains the source script. See <strong>file section</strong>.

### <code>-t</code>, <code>--target</code> *target*
The kind of target application. Select one target from <code>terminal</code>
or <code>window</code>. The default target is <code>terminal</code>.
This information is used the class of root frame.

# Files
## Input files
* <code>user_script.as</code>: Source arisia script file given by command line argument.
* <code>manifest.json.in</code>: You can define the path of the package directory by <code>--package</code> option. The manifest file must be located under the directory. If you do not give the option, it assumed to be exist at the same directory with user script.

## Output files
* <code>user_script.frame.d.ts</code>: The type declaration which is used in the user script. This file is used to compile the <code>user_script.ts</code> file by TypeScript compiler.
* <code>user_script.d.ts</code>: The type script file which is generated from arisia script.

# Related documents
* [ArisiaTools](https://github.com/steelwheels/Arisia/tree/main/ArisiaTools): The framework which contains this command.
* [Arisia Programming Environment](https://github.com/steelwheels/Arisia/blob/main/README.md): The main page for Arisia Programming Environment.

# Reference
* [ArisiaTools](https://github.com/steelwheels/Arisia/tree/main/ArisiaTools): The framework which contains this command.
* [Arisia Programming Environment](https://github.com/steelwheels/Arisia/blob/main/README.md): The main page for Arisia Programming Environment.


