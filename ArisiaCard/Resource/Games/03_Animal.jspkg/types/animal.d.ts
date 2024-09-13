/// <reference path="ArisiaPlatform.d.ts" />
declare class Animal {
    question: string;
    yes_answer: string;
    no_answer: string;
    constructor(q: string, y: string, n: string);
}
declare function main(argv: string[]): void;
declare function show_animals(animals: Animal[]): void;
declare function tab(space: number): string;
