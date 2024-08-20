"use strict";
/*
 * main.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(args) {
    console.log("Hello, world !!");
    let retval = enterView("console_view", null);
    console.log("Result = " + retval);
}
