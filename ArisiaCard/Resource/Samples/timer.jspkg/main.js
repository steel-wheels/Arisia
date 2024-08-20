"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(args) {
    console.log("Hello, world !!");
    let retval = enterView("timer", null);
    console.log("Result = " + retval);
}
