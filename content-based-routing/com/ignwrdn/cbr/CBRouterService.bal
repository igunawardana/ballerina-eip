package com.ignwrdn.cbr;

import ballerina.net.http;
import ballerina.io;
import com.ignwrdn.rule;

@http:configuration {basePath:"/ims", port:8890}
service<http> inventoryUpdate {

    @http:resourceConfig {
        methods:["POST"],
        path:"/update"
    }
    resource inventoryUpdateResource (http:Connection con, http:InRequest req) {
        endpoint<http:HttpClient> imsEndpoint {
            create http:HttpClient("http://localhost:8891/ims-service", {});
        }

        json request = req.getJsonPayload();

        string brand;
        error castErr;

        try {
            brand, castErr = (string)request["brand"];
        } catch (error e) {
            e.message = "Request error. No brand found";
            io:println(e);
            throw e;
        }

        io:println("Brand: " + brand);

        http:InResponse imsResp;
        http:HttpConnectorError conErr;

        http:OutResponse res = {};

        imsResp, conErr = imsEndpoint.post(rule:route(brand), {});

        if (conErr == null) {
            io:println("Backend call success..!");
            io:println(imsResp);
            _ = con.forward(imsResp);
        } else {
            io:print("Error in connecting to backend");
            io:println(conErr);
            res.statusCode = 500;
            res.setStringPayload(conErr.message);
            _ = con.respond(res);
        }

    }

}
