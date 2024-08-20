"use strict";
/*
 * machine.ts
 */
/// <reference path="../types/ArisiaPlatform.d.ts"/>
class MachineNode extends SpriteNode {
    constructor(core, field) {
        super(core, field);
        this.mFuel = 100.0;
    }
    isAlive() {
        if (super.isAlive() && (this.mFuel > 0.0)) {
            return true;
        }
        else {
            return false;
        }
    }
}
