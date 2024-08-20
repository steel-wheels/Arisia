"use strict";
/*
 * lib0.ts
 */
/// <reference path="types/ArisiaPlatform.d.ts"/>
class CarNode extends SpriteNode {
    init() {
        let w = this.field.size.width;
        let h = this.field.size.height;
        console.log("car" + this.nodeId + ": w=" + w + ", h=" + h);
        switch (this.material) {
            case SpriteMaterial.image:
                if (this.nodeId == 0) {
                    this.actions.setPosition(Point(w * 0.70, h * 0.70));
                    this.actions.setVelocity(Vector(-w * 0.10, -h * 0.10));
                }
                else {
                    this.actions.setPosition(Point(w * 0.20, h * 0.20));
                    this.actions.setVelocity(Vector(w * 0.05, h * 0.05));
                }
                break;
            default:
                console.log("unknown matrial: "
                    + this.material);
                break;
        }
    }
    isAlive() {
        return super.isAlive();
    }
    update(curtime) {
        let w = this.field.size.width;
        let h = this.field.size.height;
        let x = this.position.x;
        let y = this.position.y;
        let dx = this.velocity.dx;
        let dy = this.velocity.dy;
        if (x <= w * 0.1) {
            if (dx < 0.0) {
                dx = -dx;
            }
        }
        else if (w * 0.9 < x) {
            if (dx > 0.0) {
                dx = -dx;
            }
        }
        if (y <= h * 0.1) {
            if (dy < 0.0) {
                dy = -dy;
            }
        }
        else if (h * 0.9 < y) {
            if (dy > 0.0) {
                dy = -dy;
            }
        }
        let radar = new SpriteRadar(this, this.field);
        let nearnode = radar.nearestNode();
        if (nearnode != null) {
            let dist = radar.distanceFromNode(nearnode);
            console.log("distance: " + dist);
        }
        this.actions.setVelocity(Vector(dx, dy));
    }
}
function main(node, field) {
    let newnode = new CarNode(node, field);
    newnode.run();
}
