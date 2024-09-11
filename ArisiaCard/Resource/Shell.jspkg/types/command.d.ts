/**
 * @file command.ts
 */
/// <reference path="ArisiaPlatform.d.ts" />
declare enum CommandType {
    ls = "ls"
}
declare class Command {
    commandType: CommandType;
    arguments: string[];
    constructor(ctype: CommandType, args: string[]);
    execute(): void;
    lsCommand(): void;
    dump(): void;
}
declare class CommandLineParser {
    constructor();
    parse(cmdline: string): Command | null;
}
