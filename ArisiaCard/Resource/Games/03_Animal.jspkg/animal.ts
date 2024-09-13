// ANIMAL
//
// Converted from BASIC to Javascript by Oscar Toledo G. (nanochess)
// Converted from JavaScript to TypeScript by Steel Wheels Project
// Reference: https://github.com/coding-horror/basic-computer-games
//            03_Animal
//

/// <reference path="types/ArisiaPlatform.d.ts"/>

class Animal {
	question:	string ;
	yes_answer:	string ;
	no_answer:	string ;

	constructor(q:string, y:string, n:string){
		this.question	= q ;
		this.yes_answer	= y ;
		this.no_answer	= n ;
	}
}

function main(argv: string[])
{
	console.print(tab(32) + "ANIMAL\n");
	console.print(tab(15) + "CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY\n");
	console.print("\n");
	console.print("\n");
	console.print("\n");
	console.print("PLAY 'GUESS THE ANIMAL'\n");
	console.print("\n");
	console.print("THINK OF AN ANIMAL AND THE COMPUTER WILL TRY TO GUESS IT.\n");
	console.print("\n");

	let animals:Animal[] = [] ;
	animals.push(new Animal("DOES IT SWIM", "FISH", "BIRD")) ;

	while (true) {
		while (true) {
		    console.print("ARE YOU THINKING OF AN ANIMAL [LIST | Y]? ");
		    let str = readline() ;
		    if (str == "LIST")
			show_animals(animals);
		    if (str[0] == "Y")
			break;
		}

		for(const animal of animals){
			while(true){
				console.print(animal.question + " [Y/N]? ");
				let c = readline() ;
				if(c[0] == "Y"){
					console.print("IS IT A "
					  + animal.yes_answer + "\n") ;
					break ;
				} else if(c[0] == "N"){
					console.print("IS IT A "
					  + animal.no_answer + "\n") ;
					break ;
				}
			}
		}

		console.print("DO YOU CONTINUE THIS GAME [Y/N]: ") ;
		let docont = readline() ;
		if(docont[0] == "N"){
			break ;
		}

		console.print("DO YOU DEFINE NEW ANIMALS ? [Y/N]: ") ;
		let dodef = readline() ;
		if(dodef[0] == "Y"){
			console.print("PLEASE TYPE IN A QUESTION THAT WOULD DISTINGUISH A: ");
			let ques = readline() ;

			console.print("TYPE ANSWER FOR YES: ") ;
			let yans = readline() ;

			console.print("TYPE ANSWER FOR NO: ") ;
			let nans = readline() ;

			animals.push(new Animal(ques, yans, nans)) ;
		}
	}
}

function show_animals(animals: Animal[])
{    
	console.print("\n");
	console.print("ANIMALS I ALREADY KNOW ARE:\n");
	for(const animal of animals){
		console.print(animal.yes_answer + "\n") ;
		console.print(animal.no_answer  + "\n") ;
	}
}

function tab(space: number): string
{
    let str = "";
    while (space-- > 0)
        str += " ";
    return str;
}

/*
// ANIMAL
//
// Converted from BASIC to Javascript by Oscar Toledo G. (nanochess)
//

function print(str)
{
    document.getElementById("output").appendChild(document.createTextNode(str));
}

function input()
{
    var input_element;
    var input_str;

    return new Promise(function (resolve) {
                       input_element = document.createElement("INPUT");

                       print("? ");
                       input_element.setAttribute("type", "text");
                       input_element.setAttribute("length", "50");
                       document.getElementById("output").appendChild(input_element);
                       input_element.focus();
                       input_str = undefined;
                       input_element.addEventListener("keydown", function (event) {
                                                      if (event.keyCode == 13) {
                                                        input_str = input_element.value;
                                                        document.getElementById("output").removeChild(input_element);
                                                        print(input_str);
                                                        print("\n");
                                                        resolve(input_str);
                                                      }
                                                      });
                       });
}

function tab(space)
{
    var str = "";
    while (space-- > 0)
        str += " ";
    return str;
}

print(tab(32) + "ANIMAL\n");
print(tab(15) + "CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY\n");
print("\n");
print("\n");
print("\n");
print("PLAY 'GUESS THE ANIMAL'\n");
print("\n");
print("THINK OF AN ANIMAL AND THE COMPUTER WILL TRY TO GUESS IT.\n");
print("\n");

var k;
var n;
var str;
var q;
var z;
var c;
var t;

var animals = [
               "\\QDOES IT SWIM\\Y1\\N2\\",
               "\\AFISH",
               "\\ABIRD",
               ];

n = animals.length;

function show_animals() {
    var x;

    print("\n");
    print("ANIMALS I ALREADY KNOW ARE:\n");
    str = "";
    x = 0;
    for (var i = 0; i < n; i++) {
        if (animals[i].substr(0, 2) == "\\A") {
            while (str.length < 15 * x)
                str += " ";
            for (var z = 2; z < animals[i].length; z++) {
                if (animals[i][z] == "\\")
                    break;
                str += animals[i][z];
            }
            x++;
            if (x == 4) {
                x = 0;
                print(str + "\n");
                str = "";
            }
        }
    }
    if (str != "")
        print(str + "\n");
}

// Main control section
async function main()
{
    while (1) {
        while (1) {
            print("ARE YOU THINKING OF AN ANIMAL");
            str = await input();
            if (str == "LIST")
                show_animals();
            if (str[0] == "Y")
                break;
        }

        k = 0;
        do {
            // Subroutine to print questions
            q = animals[k];
            while (1) {
                str = "";
                for (z = 2; z < q.length; z++) {
                    if (q[z] == "\\")
                        break;
                    str += q[z];
                }
                print(str);
                c = await input();
                if (c[0] == "Y" || c[0] == "N")
                    break;
            }
            t = "\\" + c[0];
            x = q.indexOf(t);
            k = parseInt(q.substr(x + 2));
        } while (animals[k].substr(0,2) == "\\Q") ;

        print("IS IT A " + animals[k].substr(2));
        a = await input();
        if (a[0] == "Y") {
            print("WHY NOT TRY ANOTHER ANIMAL?\n");
            continue;
        }
        print("THE ANIMAL YOU WERE THINKING OF WAS A ");
        v = await input();
        print("PLEASE TYPE IN A QUESTION THAT WOULD DISTINGUISH A\n");
        print(v + " FROM A " + animals[k].substr(2) + "\n");
        x = await input();
        while (1) {
            print("FOR A " + v + " THE ANSWER WOULD BE ");
            a = await input();
            a = a.substr(0, 1);
            if (a == "Y" || a == "N")
                break;
        }
        if (a == "Y")
            b = "N";
        if (a == "N")
            b = "Y";
        z1 = animals.length;
        animals[z1] = animals[k];
        animals[z1 + 1] = "\\A" + v;
        animals[k] = "\\Q" + x + "\\" + a + (z1 + 1) + "\\" + b + z1 + "\\";
    }
}

main();
*/
