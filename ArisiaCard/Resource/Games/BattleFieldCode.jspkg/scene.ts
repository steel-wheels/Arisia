/*
 * scene.ts
 */

/// <reference path="types/ArisiaPlatform.d.ts"/>

class SampleScene extends SpriteScene
{
	override update(time: number) {
	}
}

function main(scene: SpriteSceneIF, field: SpriteFieldIF){
	let newscene = new SampleScene(scene, field) ;
	newscene.run() ;
}

