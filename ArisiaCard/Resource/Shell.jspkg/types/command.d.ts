/**
 * @file command.ts
 */
/// <reference path="ArisiaPlatform.d.ts" />
declare enum CommandType {
    run = "run"
}
declare class Command {
    commandType: CommandType;
    arguments: string[];
    constructor(ctype: CommandType, args: string[]);
    dump(): void;
}
declare class CommandLineParser {
    constructor();
    parse(cmdline: string): Command | null;
}
