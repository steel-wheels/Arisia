/**
 * @file command.ts
 */

/// <reference path="../types/ArisiaPlatform.d.ts"/>

enum CommandType {
	run	= "run"
}

class Command
{
	commandType:	CommandType
	arguments:	string[] ;

	constructor(ctype: CommandType, args: string[]){
		this.commandType = ctype ;
		this.arguments   = args ;
	}

	dump(){
		console.print(this.commandType + ":" + 
			      this.arguments.join(" ") + "\n") ;
	}
}

class CommandLineParser
{
	constructor(){
	}

	parse(cmdline: string): Command | null {
		let words = cmdline.trim().split(/[ 	]+/) ;
		if(words.length == 0){
			return null ;
		}

		let cmdname = words[0] ;
		let args    = words.slice(1) ;

		let result: Command | null ;
		switch(cmdname){
		  case CommandType.run: {
			/* run command */
			result = new Command(CommandType.run, args) ;
		  } break ;
		  default: {
			console.log("Unknown command: " + words[0] + "\n") ;
			result = null ;
		  } break ;
		}
		return result ;
	}
}

