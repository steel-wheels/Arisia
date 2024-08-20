/// <reference path="ArisiaPlatform.d.ts" />
/// <reference path="machine.d.ts" />
declare class CarNode extends MachineNode {
    init(): void;
    update(curtime: number): void;
}
declare function main(node: SpriteNodeIF, field: SpriteFieldIF): void;
