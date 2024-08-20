# Application development flow

The command line tools are used for application software development for Arisia Platform.

## Required tools
* [apkg](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaTools/Document/apkg-man.md): Arisia Package generator
* [adecl](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaTools/Document/adecl-man.md): Built-in type definition generator
* [asc](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaTools/Document/asc-man.md): Arisia Script Compiler
* tsc: TypeScript transpiler. You can download the TypeScript transpler from [www.typescriptlang.org](https://www.typescriptlang.org).

## Development flow
### Step 1: Prepare input files
The files for application is put in JavaScript package (The directory named <code>*.jspkg</code>). The developer prepare following files:
* [manifest.json.in](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiEngine/Document/manifest.md): Define the contents of the package
* Source files (TypeScript or ArisiaScript)
* Resource files such as image, icon, ...

This is a sample manifest file:
<pre>
{
	application: "main.ts"
	views: {
		hello: "hello.as"
	}
}


</pre>

You can find the sample implementation at [Sample directory](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples).

### Step 2: Execute <code>apkg</code> command
Execute the <code>apkg</code> with JavaScript package directory.
<pre>
% ~/tools/bin/apkg hello.jspkg
</pre>

The command read some input files and generate some output files:

#### Input files
* [manifest.json.in](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiEngine/Document/manifest.md): Define the contents of the package
* source scripts, resource data that they are registered in the <code>manifest.json.in</code> file.

#### Output file
* <code>manifest.json</code>: The converted manifest file. It will be read by Arisia platform application.
* <code>Makefile</code>: The makefile to translate and build the application.
* <code>types/ArisiaComponent.d.ts</code>: The built in type declarations in the Ariasia platform application.
* <code>types/*.frame.d.ts</code>: The type declaration which is required to compiler user scripts.

### Step 3: Execute <code>make</code> command
Execute the <code>make</code> command in the package directory.

<pre>
% make clean ; make
</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



