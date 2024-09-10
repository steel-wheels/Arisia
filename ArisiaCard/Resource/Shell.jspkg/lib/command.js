"use strict";
/**
 * @file command.ts
 */
/// <reference path="../types/ArisiaPlatform.d.ts"/>
var CommandType;
(function (CommandType) {
    CommandType["run"] = "run";
})(CommandType || (CommandType = {}));
class Command {
    constructor(ctype, args) {
        this.commandType = ctype;
        this.arguments = args;
    }
    dump() {
        console.print(this.commandType + ":" +
            this.arguments.join(" ") + "\n");
    }
}
class CommandLineParser {
    constructor() {
    }
    parse(cmdline) {
        let words = cmdline.trim().split(/[ 	]+/);
        if (words.length == 0) {
            return null;
        }
        let cmdname = words[0];
        let args = words.slice(1);
        let result;
        switch (cmdname) {
            case CommandType.run:
                {
                    /* run command */
                    result = new Command(CommandType.run, args);
                }
                break;
            default:
                {
                    console.log("Unknown command: " + words[0] + "\n");
                    result = null;
                }
                break;
        }
        return result;
    }
}
