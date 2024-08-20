"use strict";
/*
 * scene.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
class SampleScene extends SpriteScene {
    update(time) {
    }
}
function main(scene, field) {
    let newscene = new SampleScene(scene, field);
    newscene.run();
}
