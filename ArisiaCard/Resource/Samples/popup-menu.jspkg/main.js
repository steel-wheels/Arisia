"use strict";
/*
 * main.js
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
function main(args) {
    console.log("Hello, world !!");
    let retval = enterView("popup", null);
    console.log("Result = " + retval);
}
