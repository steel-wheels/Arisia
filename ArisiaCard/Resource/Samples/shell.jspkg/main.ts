/*
 * main.js
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(args: string[])
{
	console.log("Hello, world !!") ;
	let retval = enterView("terminal", null) ;
	console.log("Result = " + retval) ;
}

