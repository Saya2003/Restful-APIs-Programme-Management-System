import ballerina/http;
import ballerina/io;

type Programme record {
    readonly string programmeCode;
    string nqfLevel;
    string faculty;
    string department;
    string title;
    string registrationDate;
};

public function main() returns error? {
    while true {
        io:println("Choose an option:");
        io:println("1. Add Programme");
        io:println("2. Get All Programmes");
        io:println("3. Get One Programme");
        io:println("4. Get Programmes by Faculty");
        io:println("5. Delete Programme");
        io:println("6. Get Programmes Due for Review");
        io:println("7. Update Programme");
        io:println("8. Exit");

        string choice = io:readln("Enter your choice: ");

        match choice {
            "1" => {
                check addProgramme();
            }
            "2" => {
                check getAllProgrammes();
            }
            "3" => {
                check getOneProgramme();
            }
            "4" => {
                check getProgrammesByFaculty();
            }
            "5" => {
                check deleteProgramme();
            }
            "6" => {
                check getProgrammesDueForReview();
            }
            "7" => {
                check updateProgramme();
            }
            "8" => {
                io:println("Exiting...");
                break;
            }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }
    }
    return;
}

function addProgramme() returns error? {
    Programme programme = {
        programmeCode: io:readln("Enter Programme Code: "),
        nqfLevel: io:readln("Enter NQF Level: "),
        faculty: io:readln("Enter Faculty: "),
        department: io:readln("Enter Department: "),
        title: io:readln("Enter Title: "),
        registrationDate: io:readln("Enter Registration Date: ")
    };

    http:Client clientEP = check new ("http://localhost:8080");

    http:Response response = check clientEP->post("/programmes", programme);
    io:println(check response.getTextPayload());
    return;
}

function getAllProgrammes() returns error? {
    http:Client clientEP = check new ("http://localhost:8080");

    http:Response response = check clientEP->get("/programmes");
    io:println(check response.getJsonPayload());
    return;
}

function getOneProgramme() returns error? {
    string programmeCode = io:readln("Enter Programme Code: ");

    http:Client clientEP = check new ("http://localhost:8080");

    string path = string `/programmes/${programmeCode}`;
    http:Response response = check clientEP->get(path);
    io:println(check response.getJsonPayload());
    return;
}

function getProgrammesByFaculty() returns error? {
    string faculty = io:readln("Enter Faculty: ");

    http:Client clientEP = check new ("http://localhost:8080");

    string path = string `/programmes/faculty/${faculty}`;
    http:Response response = check clientEP->get(path);
    io:println(check response.getJsonPayload());
    return;
}

function deleteProgramme() returns error? {
    string programmeCode = io:readln("Enter Programme Code: ");

    http:Client clientEP = check new ("http://localhost:8080");

    string path = string `/programmes/${programmeCode}`;
    http:Response response = check clientEP->delete(path);
    io:println(check response.getTextPayload());
    return;
}

function getProgrammesDueForReview() returns error? {
    http:Client clientEP = check new ("http://localhost:8080");

    http:Response response = check clientEP->get("/programmes/dueForReview");
    io:println(check response.getJsonPayload());
    return;
}

function updateProgramme() returns error? {
    Programme updatedProgramme = {
        programmeCode: io:readln("Enter Programme Code: "),
        nqfLevel: io:readln("Enter NQF Level: "),
        faculty: io:readln("Enter Faculty: "),
        department: io:readln("Enter Department: "),
        title: io:readln("Enter Title: "),
        registrationDate: io:readln("Enter Registration Date: ")
    };

    http:Client clientEP = check new ("http://localhost:8080");

    string path = string `/programmes/${updatedProgramme.programmeCode}`;
    http:Response response = check clientEP->put(path, updatedProgramme);
    io:println(check response.getTextPayload());
    return;
}
