/// <reference path="ArisiaPlatform.d.ts" />
declare class CarNode extends SpriteNode {
    init(): void;
    isAlive(): boolean;
    update(curtime: number): void;
}
declare function main(node: SpriteNodeIF, field: SpriteFieldIF): void;
