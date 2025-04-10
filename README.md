# Restful-APIs-Programme-Management-System
This question involves developing a Restful API to manage the Programme Development and Review workflow within the Programme Development Unit at Namibia University of Science and Technology (NUST). A programme consists of multiple courses and is defined by the following attributes:

- **Programme attributes**:  
  Programme code, NQF Level of Qualification, Faculty name, Department name, Programme/Qualification Title, Registration Date, and a list of courses.  
  Each course has a course name, course code, and NQF level.

The API must include the following functionalities:
1. Add a new programme.
2. Retrieve a list of all programmes.
3. Update a programme’s information using the programme code.
4. Retrieve details of a specific programme by programme code.
5. Delete a programme using the programme code.
6. Retrieve all programmes due for review.
7. Retrieve all programmes that belong to a specific faculty.

**Note**: The programme code serves as a unique identifier for each programme.

#### Deliverables:
- **Service Implementation**:
  - Add a new programme. (10 marks)
  - Retrieve a list of all programmes. (5 marks)
  - Update an existing programme’s information using the programme code. (5 marks)
  - Retrieve details of a programme by programme code. (5 marks)
  - Delete a programme by programme code. (5 marks)
  - Retrieve programmes due for review. (5 marks)
  - Retrieve all programmes in a specific faculty. (5 marks)
  
- **Client Implementation**:  
  Implement a client in Ballerina that interacts with the API. (10 marks)
