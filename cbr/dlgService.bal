import ballerina.net.http;
import ballerina.io;

@http:configuration {basePath:"/dlg", port:8991}
service<http> dlgService {

    @http:resourceConfig {
        methods:["POST"],
        path:"/update"}
    resource updateInventory (http:Connection con, http:InRequest req) {
        io:println("Updating DLG inventory...!");
        http:OutResponse res = {};
        res.statusCode = 200;
        res.setJsonPayload({"operation":"update", "brand":"Mobitel", "status":true});
        _ = con.respond(res);
    }
}