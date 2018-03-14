import ballerina.net.http;
import ballerina.io;

@http:configuration {basePath:"/mbt", port:8992}
service<http> dlgService {

    @http:resourceConfig {
        methods:["POST"],
        path:"/update"}
    resource updateInventory (http:Connection con, http:InRequest req) {
        io:println("Updating MBTL inventory...!");
        http:OutResponse res = {};
        res.statusCode = 200;
        res.setJsonPayload({"operation":"update", "brand":"Mobitel", "status":true});
        _ = con.respond(res);
    }

}