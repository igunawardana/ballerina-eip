import ballerina.net.http;
import ballerina.io;

@http:configuration {basePath:"/ims", port:8890}
service<http> inventoryUpdate {

    @http:resourceConfig {
        methods:["POST"],
        path:"/update"
    }
    resource inventoryUpdateResource (http:Connection con, http:InRequest req) {
        endpoint<http:HttpClient> imsMbtEndpoint {
            create http:HttpClient("http://localhost:8992", {});
        }

        endpoint<http:HttpClient> imsDlgEndpoint {
            create http:HttpClient("http://localhost:8991", {});
        }

        json request = req.getJsonPayload();

        string brand;
        error castErr;
        brand, castErr = (string)request["brand"];

        if (castErr == null) {
            io:println("Brand value: " + brand);
        } else {
            io:println("Couldn't read the brand: ");
            io:println(castErr);
        }
        http:InResponse imsResp;
        http:HttpConnectorError conErr;

        http:OutResponse res = {};

        if (brand == "mbt") {
            imsResp, conErr = imsMbtEndpoint.post("/mbt/update", {});
        } else {
            imsResp, conErr = imsDlgEndpoint.post("/dlg/update", {});
        }

        if (conErr == null) {
            io:println("Backend call success..!");
            io:println(imsResp);
            _ = con.forward(imsResp);
        } else {
            io:print("Error connecting to backend. ");
            io:println(conErr);
            res.statusCode = 500;
            res.setStringPayload(conErr.message);
            _ = con.respond(res);
        }

    }

}