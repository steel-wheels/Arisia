/*
 * main.js
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

function main(args: string[])
{
	console.log("Hello, world !!") ;
	let retval = enterView("prop_view", null) ;
	console.log("Result = " + retval) ;
}

