pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import './helpers/SafeMath.sol';

contract Employer{
    using SafeMath for *;

    address public EmployerId;
    address payable public EmployerAddress;
    uint32 public EmployerCounter;
    string public EmployerDOB;
    string public EmployerUsername;

    struct EmployeeDetail{
        string employerUsername;
        uint32 employeePayAmount;
        string employeePayFrequency;
    }

    mapping (string => address) EmployerContracts; // Map stores identifier string => contract address.
    mapping (string => string) EmployerUsernames; // Map stores username string => identifier string.
    mapping (string => string[]) EmployerToEmployee; //Map stores employer name and list of his employees.
    mapping (string => EmployeeDetail) EmployeeToDetails; //EmployeeUserName to Employees details.

    constructor(string memory _emplrdob, address payable _emplrAddress, string memory _username, string memory _contractname) public {
        EmployerAddress = _emplrAddress;
        EmployerId = address(this);
        EmployerDOB = _emplrdob;
        EmployerCounter = 0;
        createIdentifier(_username,_contractname);
        EmployerUsername = _username;
    }

    function createIdentifier(string memory _username, string memory _contractname) internal {
        string memory _identity = "employer";
        bytes memory _identifier = abi.encodePacked(_identity,"_",_username,"_",_contractname);
        EmployerContracts[string(_identifier)] = EmployerId;
        EmployerUsernames[_username] = string(_identifier);
    }

    //AddEmployee
     function addEmployee(string memory _employeeUsername) public {
         EmployeeDetail storage e = EmployeeToDetails[_employeeUsername];
         e.employeePayAmount = 1;
         e.employeePayFrequency = 'Weekly';
         EmployerToEmployee[EmployerUsername].push(_employeeUsername);
         EmployerCounter++;
    }

    //DeleteEmployee
    function deleteEmployee(string memory _employeeUsername) public {
        for (uint i = 0; i < EmployerToEmployee[EmployerUsername].length; i++ )
        {
        if( keccak256(abi.encodePacked(EmployerToEmployee[EmployerUsername][i])) == keccak256(abi.encodePacked(_employeeUsername)))
        {
            EmployerToEmployee[EmployerUsername][i] = EmployerToEmployee[EmployerUsername][EmployerToEmployee[EmployerUsername].length-1];
            EmployerToEmployee[EmployerUsername].length--;
        }
        }
        delete EmployeeToDetails[_employeeUsername]; //deleting in EmployeeToDetails
        EmployerCounter--;
    }

    //Payout to Employee
    function setEmployPayAmount(string memory _employeeUsername, uint32 _amount ) public {
       EmployeeDetail storage e = EmployeeToDetails[_employeeUsername];
        e.employeePayAmount = _amount;
    }

    function setEmployPayFrequency(string memory _employeeUsername, string memory _payFrequency) public {
      EmployeeDetail storage e = EmployeeToDetails[_employeeUsername];
        e.employeePayFrequency = _payFrequency;
    }

    function viewEmployees() public view returns (string[] memory) {
        return EmployerToEmployee[EmployerUsername];
    }

    function getEmployeePayFrequency(string memory _employeeUserName) public view returns (string memory) {
        return EmployeeToDetails[_employeeUserName].employeePayFrequency;
    }

    function getEmployeePayAmount(string memory _employeeUserName) public view returns (uint32) {
        return EmployeeToDetails[_employeeUserName].employeePayAmount;
    }
}