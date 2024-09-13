/// <reference path="ArisiaPlatform.d.ts" />
declare const validLowerCaseYesStrings: string[];
declare const validLowerCaseNoStrings: string[];
declare const validLowerCaseYesAndNoStrings: string[];
declare function getRandomCard(): number;
declare function newGameCards(): number[];
declare function getCardValue(card: number): string;
declare function main(argv: string[]): void;
declare function isValidYesNoString(str: string): boolean;
declare function isValidYesString(str: string): boolean;
declare function isValidNoString(str: string): boolean;
declare function spaces(numberOfSpaces: number): string;
