import ballerina/http;
import ballerina/time;

// In-memory storage for programmes
map<Programme> programmes = {};

// Listener on localhost:8080
listener http:Listener ep0 = new (8080, config = {host: "localhost"});

service /programme on ep0 {
    // Add a new programme
    resource function post addProgramme(@http:Payload Programme payload) returns string|error {
        programmes[payload.programmeCode ?: ""] = payload;
        return "Programme added successfully";
    }
    
    // Retrieve all programmes
    resource function get allProgrammes() returns json|error {
        return programmes.toJson();
    }
    
    // Retrieve a programme by code
    resource function get programme/[string programmeCode]() returns Programme|error {
        if programmes.hasKey(programmeCode) {
            return programmes[programmeCode] ?: {};
        }
        return error("Programme not found");
    }
    
    // Update a programme by code
    resource function put programme/updateProgramme/[string programmeCode](@http:Payload Programme payload) returns string|error {
        if programmes.hasKey(programmeCode) {
            programmes[programmeCode] = payload;
            return "Programme updated successfully";
        }
        return error("Programme not found");
    }
    
    // Delete a programme by code
    resource function delete programme/deleteProgramme/[string programmeCode]() returns string|error {
        if programmes.hasKey(programmeCode) {
            _ = programmes.remove(programmeCode);
            return "Programme deleted successfully";
        }
        return error("Programme not found");
    }
    
    // Retrieve all programmes due for review
    resource function get programmesDueForReview() returns json|error {
        map<Programme> dueForReview = {};
        time:Utc currentDate = time:utcNow();
        
        foreach var [code, prog] in programmes.entries() {
            if prog.registrationDate is string {
                time:Utc|error regDate = time:utcFromString(prog.registrationDate ?: "");
                if regDate is time:Utc {
                    time:Seconds fiveYears = 5 * 365 * 24 * 60 * 60; // 5 years in seconds
                    time:Utc reviewDate = time:utcAddSeconds(regDate, fiveYears);
                    if (currentDate > reviewDate) {
                        dueForReview[code] = prog;
                    }
                }
            }
        }
        
        return dueForReview.toJson();
    }
    
    // Retrieve all programmes by faculty
    resource function get programmesByFaculty/[string faculty]() returns json|error {
        map<Programme> facultyProgrammes = {};
        
        foreach var [code, prog] in programmes.entries() {
            if prog.faculty == faculty {
                facultyProgrammes[code] = prog;
            }
        }
        
        return facultyProgrammes.toJson();
    }
};