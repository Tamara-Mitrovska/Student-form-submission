import ballerina/http;
import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/jsonutils;

type Student record {|
    string nameWithInitial;
    string fullName;
    string religion;
    string ethnicity;
    string dateOfBirth;
    string grade;
    string gender;
    string address;
|};


// JDBC Client for H2 database.
jdbc:Client testDB = new ({
    url: "jdbc:h2:file:./students/student-data",
    username: "test",
    password: "test"
});

// Function to handle the return value of the `update` remote function.
function handleUpdate(jdbc:UpdateResult|error returned, string message) {
    if (returned is jdbc:UpdateResult) {
        io:println(message + " status: ", returned.updatedRowCount);
    } else {
        io:println(message + " failed: ", <string>returned.detail()?.message);
    }
}
//Insert student information into a table
function insertStudentInfo(string field1, string field2, string field3, string field4, string field5, string field6, string field7, string field8) {
    var ret = testDB->update("CREATE TABLE STUDENT_FORM (nameWithInitial VARCHAR(30), fullName VARCHAR(30), religion VARCHAR(30), ethnicity VARCHAR(30), dateOfBirth VARCHAR(30), grade VARCHAR(30), gender VARCHAR(30), address VARCHAR(30))");
    handleUpdate(ret, "Create STUDENT_FORM table");
    ret = testDB->update("INSERT INTO STUDENT_FORM (nameWithInitial, fullName, religion, ethnicity, dateOfBirth, grade, gender, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", field1, field2, field3, field4, field5, field6, field7, field8);
    handleUpdate(ret, "Insert data to STUDENT_FORM table");    
}

//Retrieve information form table
function retrieveData() returns json {
    var database = testDB->select("SELECT * FROM STUDENT_FORM", Student);
    if (database is table<Student>){
        io:println("\nConvert the table into json");
        json jsonConversionRet = jsonutils:fromTable(database);
        io:print("JSON: ");
        io:println(io:sprintf("%s", jsonConversionRet));
        // map<json> data = <map<json>> jsonConversionRet;
        return jsonConversionRet;
}}


@http:ServiceConfig {
    basePath: "/students"
    }

service studentService on new http:Listener(9090) {


    @http:ResourceConfig {
        methods:["POST"],
        path: "/info",
        cors: {
            allowOrigins: ["*"]
        }
    }

    resource function studentSubmission(http:Caller caller, http:Request request) {
        var data = request.getJsonPayload();
        io:println(data);
        if (data is json){
            map<json> mp = <map<json>> data;
            string field1 = mp["nameWithInitial"].toString();
            string field2 = mp["fullName"].toString();
            string field3 = mp["religion"].toString();
            string field4 = mp["ethnicity"].toString();
            string field5 = mp["dateOfBirth"].toString();
            string field6 = mp["grade"].toString();
            string field7 = mp["gender"].toString();
            string field8 = mp["address"].toString();
            Student student = {nameWithInitial:field1, fullName:field2, religion:field3, ethnicity:field4, dateOfBirth:field5, grade:field6, gender:field7, address:field8};
            io:println(student);
            insertStudentInfo(student.nameWithInitial, student.fullName, student.religion, student.ethnicity, student.dateOfBirth, student.grade, student.gender, student.address);
            json info = retrieveData();
            io:println(info);
            var res = caller->respond("ok");
            }
        else{
                var res = caller->respond("Error: invalid input");
            }             
    }
  
}

