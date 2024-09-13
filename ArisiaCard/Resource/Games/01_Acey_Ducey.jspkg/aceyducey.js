"use strict";
// ACEYDUCEY
//
// Converted from JavaScript to TypeScript by Steel Wheels Project
// Reference: https://github.com/coding-horror/basic-computer-games
//            01_AceyDucey
//
/// <reference path="types/ArisiaPlatform.d.ts"/>
// UTILITY VARIABLES
// By default:
// — Browsers have a window object
// — Node.js does not
// Checking for an undefined window object is a loose check
// to enable browser and Node.js support
//const isRunningInBrowser = typeof window !== 'undefined';
// To easily validate input strings with utility functions
const validLowerCaseYesStrings = ['yes', 'y'];
const validLowerCaseNoStrings = ['no', 'n'];
const validLowerCaseYesAndNoStrings = [
    ...validLowerCaseYesStrings,
    ...validLowerCaseNoStrings,
];
// UTILITY VARIABLES
// Function to get a random number (card) 2-14 (ACE is 14)
function getRandomCard() {
    // In our game, the value of ACE is greater than face cards;
    // instead of having the value of ACE be 1, we’ll have it be 14.
    // So, we want to shift the range of random numbers from 1-13 to 2-14
    let min = 2;
    let max = 14;
    // Return random integer between two values, inclusive
    return Math.floor(Math.random() * (max - min + 1) + min);
}
function newGameCards() {
    let cardOne = getRandomCard();
    let cardTwo = getRandomCard();
    let cardThree = getRandomCard();
    // We want:
    // 1. cardOne and cardTwo to be different cards
    // 2. cardOne to be lower than cardTwo
    // So, while cardOne is greater than or equal too cardTwo
    // we will continue to generate random cards.
    while (cardOne >= cardTwo) {
        cardOne = getRandomCard();
        cardTwo = getRandomCard();
    }
    return [cardOne, cardTwo, cardThree];
}
// Function to get card value
function getCardValue(card) {
    let result = "?";
    if (2 <= card && card <= 10) {
        result = String(card);
    }
    else {
        switch (card) {
            case 11:
                result = "JACK";
                break;
            case 12:
                result = "QUEEN";
                break;
            case 13:
                result = "KIND";
                break;
            case 14:
                result = "ACE";
                break;
        }
    }
    return result;
}
function main(argv) {
    console.print(spaces(26) + 'ACEY DUCEY CARD GAME');
    console.print(spaces(15) + 'CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY\n\n');
    console.print('ACEY-DUCEY IS PLAYED IN THE FOLLOWING MANNER\n');
    console.print('THE DEALER (COMPUTER) DEALS TWO CARDS FACE UP\n');
    console.print('YOU HAVE AN OPTION TO BET OR NOT BET DEPENDING\n');
    console.print('ON WHETHER OR NOT YOU FEEL THE CARD WILL HAVE\n');
    console.print('A VALUE BETWEEN THE FIRST TWO.\n');
    console.print("IF YOU DO NOT WANT TO BET, INPUT '0'\n");
    let bet = 0;
    let availableDollars = 100;
    // Loop game forever
    while (true) {
        let [cardOne, cardTwo, cardThree] = newGameCards();
        console.print(`YOU NOW HAVE ${availableDollars} DOLLARS.\n`);
        console.print('HERE ARE YOUR NEXT TWO CARDS:\n');
        console.print(getCardValue(cardOne) + "\n");
        console.print(getCardValue(cardTwo) + "\n");
        console.print('\n');
        // Loop until receiving a valid bet
        let validBet = false;
        while (!validBet) {
            console.print('\nWHAT IS YOUR BET? ');
            bet = parseInt(readline(), 10);
            let minimumRequiredBet = 0;
            if (bet >= minimumRequiredBet) {
                if (bet > availableDollars) {
                    console.print('SORRY, MY FRIEND, BUT YOU BET TOO MUCH.\n');
                    console.print(`YOU HAVE ONLY ${availableDollars} DOLLARS TO BET.\n`);
                }
                else {
                    validBet = true;
                }
            }
        }
        if (bet == 0) {
            // User chose not to bet.
            console.print('CHICKEN!!\n');
            console.print('\n');
            // Don't draw a third card, draw a new set of 2 cards.
            continue;
        }
        console.print('\n\nHERE IS THE CARD WE DREW: ');
        console.print(getCardValue(cardThree));
        // Determine if player won or lost
        if (cardThree > cardOne && cardThree < cardTwo) {
            console.print('YOU WIN!!!\n');
            availableDollars = availableDollars + bet;
        }
        else {
            console.print('SORRY, YOU LOSE\n');
            if (bet >= availableDollars) {
                console.print('\n');
                console.print('\n');
                console.print('SORRY, FRIEND, BUT YOU BLEW YOUR WAD.\n');
                console.print('\n');
                console.print('\n');
                console.print('TRY AGAIN (YES OR NO)\n');
                let tryAgainInput = readline();
                console.print('\n');
                console.print('\n');
                if (isValidYesString(tryAgainInput)) {
                    availableDollars = 100;
                }
                else {
                    console.print('O.K., HOPE YOU HAD FUN!\n');
                    break;
                }
            }
            else {
                availableDollars = availableDollars - bet;
            }
        }
    }
}
// UTILITY FUNCTIONS
function isValidYesNoString(str) {
    return validLowerCaseYesAndNoStrings.includes(str.toLowerCase());
}
function isValidYesString(str) {
    return validLowerCaseYesStrings.includes(str.toLowerCase());
}
function isValidNoString(str) {
    return validLowerCaseNoStrings.includes(str.toLowerCase());
}
function spaces(numberOfSpaces) {
    return ' '.repeat(numberOfSpaces);
}
// UTILITY FUNCTIONS
