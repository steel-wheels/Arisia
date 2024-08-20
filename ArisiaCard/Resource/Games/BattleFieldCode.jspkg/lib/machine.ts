/*
 * machine.ts
 */

/// <reference path="../types/ArisiaPlatform.d.ts"/>

class MachineNode extends SpriteNode
{
    	private mFuel:	number ;

	constructor(core: SpriteNodeIF, field: SpriteFieldIF){
		super(core, field) ;
	    	this.mFuel = 100.0 ;
	}

	isAlive(): boolean {
		if(super.isAlive() && (this.mFuel > 0.0)){
		    return true ;
	 	} else {
		    return false ;
		}
	}
} 

