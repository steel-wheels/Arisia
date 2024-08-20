# apkg
Arisia Pakcage Generator

## Name
<code>apkg</code> - Arisia package generator

## Synopsys
<code>apkg [options] package-directory</code>

## Description
The <code>apk</code> command generate application package to be compiled and executed as an application on [ArisiaPlatforn](https://gitlab.com/steewheels/arisia/-/blob/main/README.md).

The command reads <code>manifest.json.in</code> file and generate multiple files (such as <code>manifest.json</code> and <code>Makefile</code>) to compile the application source scripts.

The sample package [hello.jspkg](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples/hello.jspkg) has following <code>manifest.json.in</code>.
It has the information of source files which is written by the application programmer. 
<pre>
{
  application: "main.ts"
  views: {
    hello: "hello.as"
  }
}
</pre>

The <code>apkg</code> command generates <code>manifest.json.in</code> from the above file. It contains the name of trasplied file from the source and additional files fot the transpiler. 
<pre>
{
  application: "main.js",
  definitions: [
      "types/hello.td"
    ],
  views: {
      hello: "hello.js"
    }
}
</pre>

The command <strong>does not</cstring> generate these files but it generate <code>Makefile</code> to generate them.


### Options
#### `-h`, `--help`
Output help message and quit the command.

#### `--version`
Output the version information and quit the command.

#### `--verbose`
Set the verbose mode ON. The kind and number of log messages are increased to tell the more precise progress.

## Input file
### <code>manifest.json</code>

The manifest.in

You have to prepare <code>manifest.json.in</code> under
<code>*.jspkg</code> directory.

The <code>mkjspkg</code> command read this file and generate <code>manifest.json</code>, <code>Makefile.inc</code>, some source file (<code>*.ts*</code>) and some type declaration files (<code>*.d.ts</code>).

# Reference
* [ArisiaTools](https://github.com/steelwheels/Arisia/tree/main/ArisiaTools): The framework which contains this command.
* [Arisia Programming Environment](https://github.com/steelwheels/Arisia/blob/main/README.md): The main page for Arisia Programming Environment.



