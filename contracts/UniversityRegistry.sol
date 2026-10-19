// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UniversityRegistry {
    address public owner;

    mapping(address => bool) public lecturers; // why we use bool? why even to store false addresses?

    // infor for one object
    struct Student {
        string name;
        uint256 age;
        string major;
        bool exists;
    }

    // dict
    mapping(uint256 => Student) public students; 

    constructor() {
        owner = msg.sender; // deployer is assigned to owner
    }

    // change/check the behavior of functions
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyLecturer() {
        require(lecturers[msg.sender] || msg.sender == owner);
        _;
    }

    // communicate with frontend
    // emit keyword to trigger the log

    event LecturerAdded(address indexed lecturerAddress); // lecturerAddress human-readable label
    event StudentRegistered(uint256 indexed studentId, string name); // string name slot to carry text data when the event is emitted, returns student id + name

    function addLecturer(address _lecturerAddress) external onlyOwner {
        lecturers[_lecturerAddress] = true;
        emit LecturerAdded(_lecturerAddress);
    }

    // _ convention for function inputs
    // updating the mapping inside function

    function addStudent(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _major
    ) external onlyLecturer {
        
        students[_id] = Student({
            name: _name,
            age: _age,
            major: _major,
            exists: true
        });
        
        emit StudentRegistered(_id, _name);
    }

    }