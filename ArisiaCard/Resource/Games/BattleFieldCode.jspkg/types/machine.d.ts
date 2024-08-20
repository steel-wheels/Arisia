/// <reference path="ArisiaPlatform.d.ts" />
declare class MachineNode extends SpriteNode {
    private mFuel;
    constructor(core: SpriteNodeIF, field: SpriteFieldIF);
    isAlive(): boolean;
}
