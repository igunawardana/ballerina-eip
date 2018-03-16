package com.ignwrdn.srvc;

import ballerina.net.http;
import ballerina.io;

@http:configuration {basePath:"/ims-service", port:8891}
service<http> IMSService {

    @http:resourceConfig {
        methods:["POST"],
        path:"/dlg/update"}
    resource updateDLGInventory (http:Connection con, http:InRequest req) {
        io:println("Updating DLG inventory...!");
        http:OutResponse res = {};
        res.statusCode = 200;
        res.setJsonPayload({"brand":"Dialog", "operation":"update", "sucess":true});
        _ = con.respond(res);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/mbt/update"}
    resource updateMBTInventory (http:Connection con, http:InRequest req) {
        io:println("Updating MBT inventory...!");
        http:OutResponse res = {};
        res.statusCode = 200;
        res.setJsonPayload({"brand":"Mobitel", "operation":"update", "sucess":true});
        _ = con.respond(res);
    }
}
