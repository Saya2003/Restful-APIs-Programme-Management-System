import ballerina/http;

type Programme record {
    readonly string programmeCode;
    string nqfLevel;
    string faculty;
    string department;
    string title;
    string registrationDate;
};

table<Programme> key(programmeCode) programmes = table [];

service / on new http:Listener(8080) {

    resource function post programmes(http:Caller caller, http:Request req) returns error? {
        var payload = req.getJsonPayload();
        if (payload is json) {
            var newProgramme = payload.cloneWithType(Programme);
            if (newProgramme is Programme) {
                var existingProgramme = programmes[newProgramme.programmeCode];
                if (existingProgramme is ()) {
                    programmes.add(newProgramme);
                    check caller->respond("Programme successfully added.");
                } else {
                    check caller->respond("Programme already exists.");
                }
            } else {
                check caller->respond("Invalid programme data.");
            }
        } else {
            check caller->respond("Invalid JSON payload.");
        }
    }

    resource function get programmes(http:Caller caller, http:Request req) returns error? {
        Programme[] programmeList = from Programme p in programmes select p;
        check caller->respond(programmeList);
    }

    resource function get programmes/[string programmeCode](http:Caller caller, http:Request req) returns error? {
        var result = programmes.get(programmeCode);
        if (result is Programme) {
            check caller->respond(result);
        } else {
            
        }
    }

    resource function get programmes/faculty/[string faculty](http:Caller caller, http:Request req) returns error? {
        Programme[] filteredProgrammes = from Programme p in programmes where p.faculty == faculty select p;
        if (filteredProgrammes.length() > 0) {
            check caller->respond(filteredProgrammes);
        } else {
            check caller->respond("No programmes found for given faculty.");
        }
    }

    resource function delete programmes/[string programmeCode](http:Caller caller, http:Request req) returns error? {
        var result = programmes.remove(programmeCode);
        if (result is Programme) {
            check caller->respond("Programme deleted successfully: " + programmeCode);
        } else {
            
        }
    }

    resource function get programmes/dueForReview(http:Caller caller, http:Request req) returns error? {
        Programme[] dueForReview = from Programme p in programmes where true select p; // Placeholder condition
        check caller->respond(dueForReview);
    }

    resource function put programmes/[string programmeCode](http:Caller caller, http:Request req) returns error? {
        var payload = req.getJsonPayload();
        if (payload is json) {
            var updatedProgramme = payload.cloneWithType(Programme);
            if (updatedProgramme is Programme) {
                var existingProgramme = programmes.remove(programmeCode);
                if (existingProgramme is Programme) {
                    programmes.add(updatedProgramme);
                    check caller->respond("Programme successfully updated.");
                } else {
                    
                }
            } else {
                check caller->respond("Invalid programme data.");
            }
        } else {
            check caller->respond("Invalid JSON payload.");
        }
    }
}
