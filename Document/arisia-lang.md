# ArisiaScript specification

## Introduction
The ArisiaScript is the extension of TypeScript/JavaScript for event driven programming.
The program is described as the hierarchical frames.
The hierarchy presents the layout of the frames.
For exmaple, the next script presents two GUI buttons which allocated horizontally.

The arisia script compiler transpile the ArisiaScript into TypeScript.
About the transpiler, see the [development flow](./dev-flow.md) and [arisia script compiler](https://gitlab.com/steewheels/arisia/-/blob/main/ArisiaTools/Document/asc-man.md?ref_type=heads) named <code>asc</code>.

<pre>
{
  box: Box {
    axis:         Axis .horizontal
    left_button:  ButtonView {
        title: "Left Button"
    }
    right_button: ButtonView {
        title: "Right Button"
    }
  }
}
</pre>

You can design the control logic and the layout of GUI components at the same time without needless codes.


## Frame
The frame is a basic object which supports event driven programming.
The declaration is started by <code>{</code> and ended by <code>}</code>.
It contains multiple (zero or more) property declaration.
The <code>,</code> *is NOT* required between property declarations.
<pre>
{
        name : type value // property declaration
        ...
}
</pre>

|Name |Description |
|--- |--- |
|<code>name</code>  |Property name. It must be unique in a frame. |
|<code>type</code>  |Data type. For more details, see [type](#type).|
|<code>value</code> |Property value. See [value](#value). |

This is sample declaration of properties:
<pre>
{
	message: string "Hello, world !!"
	magic:   number 42
        frame0:  Frame {
		...
	}

}
</pre>

At the default setting,
the instance name of the top level frame is <code>root</code>.

## Type
The data type and their names are similar to TypeScript except the frame.

|Name           |Declaration    | Description           |
|---            |---            |---                    |
|boolean        |<code>boolean</code>      |<code>true</code> or <code>false</code>      |
|number         |<code>number</code>       |integer or floating point      |
|string         |<code>string</code>       |string                 |
|void           |<code>void</code>         |Present no data |
|enum           | enum-ident    |Enum type name         |
|array          | etype<code>[]</code>     |array                  |
|dictionary     | <code>[name: string]:</code> etype |dictionary with the string key |
|frame          |component-ident    |Type name of the frame |

The <code>etype</code> is type of element. The [Kiwi standard library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md) defines built-in enum types.

The <code>component-ident</code> is the name of the component. The [Arisia components](https://gitlab.com/steewheels/arisia/-/blob/main/Document/arisia-components.md) defines built-in components.

## Value
### Immediate value
|Type           |Declaration    | Description           |
|---            |---            |---                    |
|boolean        |<code>true</code>         |true or false          |
|number         |0, 2, -1.3 , 0x1 |Integer or floating point value. Supported base is 10 (decimal) and 16 (hex) |
|string         |\"STR\"      |The character sequence between \" and \".  |

### Enum value
The enum value must be declared as identifier.
The identifier must be a predefined member of the enum type.

For example, the <code>horizontal</code> is the member of [Axis](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Enum/Axis.md) enum type.

<pre>
{
  axis: Axis horizontal
}
</pre>

### Function value
#### Init function
The init function is called to initialize the frame.
This function is called only once after this frame is allocated.
The return value of the function will be ignored.

The order of calling init function is depend on the declaration order of them.
In the following example, the execution order will be:
1. frameB - init0
2. frameA - init0
3. frameC - init0
4. frameA - init1

<pre>
{
  frameA: Frame {
    frameB: Frame {
      main: init %{ console.log("frameB - init0") ; %}
    }
    main0: init %{ console.log("frameA - init0") ; %}
    frameC: Frame {
      main: init %{ console.log("frameC - init0") ; %}
    }
    main1: init %{ console.log("frameA - init1") ; %}
  }
}
</pre>

#### Event function
The event function is called by the frame to tell the event. For example, the button component calls <code>pressed</code> event when the button is pressed. The number and type of arguments will be defined by the frame.

This function does not have the return value.
Even if you use <code>return</code> statement in it's body, the return value will be ignored.
<pre>
{
  button0: Button {
    pressed: event(pressed: bool) %{
      console.log("button0 is pressed") ;
    %}
  }
}
</pre>

#### Listner function
The listner function is called when one of the parameter is changed.

In the following example, the listner function for property <code>sum0</code> listens the value of <code>root.a</code> and <code>root.b</code> and executed when of of them are changed.

The expression to point the object (such as <code>root.a</code>) is called as path expression. See [path expression](#path-expression) section.

<pre>
{
  a: number 0   // Listned value
  b: number 1   // Listned value
  sum0: number listner(a: root.a, b: root.b) %{
    return a + b ;
  %}
}
</pre>

#### Procedural function
The custom function in the frame.
You can access the variable <code>self</code> which has the reference of the owner frame of the procedural function.

<pre>
  label: Label {
    text:   string     "Hello, World !!"

    // Procedural function
    set_text: void func(txt: string) %{
      self.text = txt ;
    %}
  }
</pre>

### Immediately invoked function
The return value of the function will be the property value. The function is executed when the script is started:
<pre>
{
  a: number %{ return 1 + 2 ; %}
}
</pre>

### Array value
You can define array property. It is compatible with JavaScript array.
<pre>
{
  s: number[] [1, 2, 3, 4]
  init0: init %{
    console.print("length = " + root.s.length + "\n") ;
  %}
}
</pre>

### Dictionary value
You can define array property. It is compatible with JavaScript dictionary.
<pre>
{
  s: [key:string]:number {a:10, b:20}
  init0: init %{
    console.print("keys = " + Object.keys(root.s) + "\n") ;
  %}
}
</pre>

### Frame value

## Expression
### Path expression

## Comment
<pre>
        // comment
</pre>

## Reserved words
* boolean
* class
* event
* func
* init
* listner
* number
* root
* string
* void

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



