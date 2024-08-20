/**
 * Transpiler.ts
 */

/// <reference path="types/KiwiLibrary.d.ts"/>

function _definePropertyIF(frame: FrameIF, names: string[]) {
        /* define properties */
        for(let name of names) {
                Object.defineProperty(frame, name, {
                        get()    { return this._value(name) ;   },
                        set(val) { this._setValue(name, val) ;  }
                }) ;
        }
}

