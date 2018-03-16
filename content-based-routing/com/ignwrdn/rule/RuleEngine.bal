package com.ignwrdn.rule;

import ballerina.io;

public function route (string brand) (string context) {

    if (brand == "mbt") {
        io:println("Rule found for: " + brand);
        context = "/mbt/update";
        return;
    } else {
        io:println("Rule found for: " + brand);
        context = "/dlg/update";
        return;
    }
}

