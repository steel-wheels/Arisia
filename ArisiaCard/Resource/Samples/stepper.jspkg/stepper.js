"use strict";
/// <reference path="types/ArisiaPlatform.d.ts"/>
/// <reference path="types/stepper.frame.d.ts"/>
/* allocate function for frame: Box */
let root = _alloc_Box();
/* define type for all properties */
root._definePropertyType("stepper", "o(Stepper)");
root._definePropertyType("ok_button", "o(Button)");
root._definePropertyType("axis", "e(Axis)");
root._definePropertyType("alignment", "e(Alignment)");
root._definePropertyType("distribution", "e(Distribution)");
/* define getter/setter for all properties */
_definePropertyIF(root, ["stepper", "ok_button", "axis", "alignment", "distribution"]);
{
    /* allocate function for frame: Stepper */
    let stepper = _alloc_Stepper();
    /* define type for all properties */
    stepper._definePropertyType("minValue", "n");
    stepper._definePropertyType("maxValue", "n");
    stepper._definePropertyType("stepValue", "n");
    stepper._definePropertyType("initValue", "n");
    stepper._definePropertyType("updated", "f(v,[o(root_stepper_StepperIF),n])");
    /* define getter/setter for all properties */
    _definePropertyIF(stepper, ["minValue", "maxValue", "stepValue", "initValue", "updated"]);
    /* assign user declared properties */
    stepper.minValue = -10;
    stepper.maxValue = 10;
    stepper.stepValue = 1;
    stepper.initValue = 0;
    stepper.updated = function (self, val) {
        console.log("current value: " + val);
    };
    root.stepper = stepper;
}
{
    /* allocate function for frame: Button */
    let ok_button = _alloc_Button();
    /* define type for all properties */
    ok_button._definePropertyType("title", "s");
    ok_button._definePropertyType("pressed", "f(v,[o(root_ok_button_ButtonIF)])");
    ok_button._definePropertyType("isEnabled", "b");
    /* define getter/setter for all properties */
    _definePropertyIF(ok_button, ["title", "pressed", "isEnabled"]);
    /* assign user declared properties */
    ok_button.title = "OK";
    ok_button.pressed = function (self) {
        leaveView(0);
    };
    root.ok_button = ok_button;
}
/* Define listner functions */
/* Setup the component */
_setup_component(root);
/* This value will be return value of evaluateScript() */
root;
