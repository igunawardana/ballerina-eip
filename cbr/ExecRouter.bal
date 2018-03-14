import ballerina.io;

public function main (string[] args) {
    io:println("Hello, World!");

    json jsn = {"id":1, "name":"isuru"};
    string x="a";
    error e;

    x = jsn.toString();

    io:println(x);
    io:println(e);
}
