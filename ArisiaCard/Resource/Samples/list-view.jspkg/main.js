"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(args) {
    console.log("Hello, world !!");
    let retval = enterView("list", null);
    console.log("Result = " + retval);
}
