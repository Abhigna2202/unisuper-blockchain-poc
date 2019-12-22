pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import './helpers/SafeMath.sol';

contract Employer{
    using SafeMath for *;

    address public EmployerId;
    address payable public EmployerAddress;
    address public EmployerPayoutAddress;
    address public EmployeePayoutAddress;
    uint32 public EmployerCounter;
    string public EmployerDOB;
    string public Identifier;
    string public EmployerUsername;

    mapping (string => address) EmployerIdentifierToContractMap; // Map stores identifier string => contract address
    mapping (string => string) EmployerUsernameToIdentifierMap; // Map stores username string => identifier string

    struct EmployeeDetail{
        string employerUsername;
        uint32 employeePayAmount;
        string employeePayFrequency;

    }
    mapping (string => string[]) EmployerToEmployeesMap;
    mapping (string => EmployeeDetail) EmployeeUserNameToDetailsMap; //EmployeeUserName to Employees details

    string[] public employees;
    
    constructor(string memory _emplrdob, address payable _emplrAddress, string memory _username, string memory _contractname) public {
        EmployerAddress = _emplrAddress;
        EmployerId = address(this);
        EmployerDOB = _emplrdob;
        EmployerCounter = 0;
        createIdentifier(_username,_contractname);
        EmployerUsername = _username;
    }

    //Update the two maps with the respective values
    //a thought if this function to be private or public
    function createIdentifier(string memory _username, string memory _contractname) private {
        string memory _identity = "employer_";
        bytes memory _identifier = abi.encodePacked(_identity,"_",_username,"_",_contractname);
        EmployerIdentifierToContractMap[string(_identifier)] = EmployerId;
        EmployerUsernameToIdentifierMap[_username] = string(_identifier);
        Identifier = string(_identifier);
    }

    //AddEmployee

     function addEmployee(string memory _employeeUsername) public {
         EmployeeDetail storage e = EmployeeUserNameToDetailsMap[_employeeUsername];
         e.employeePayAmount = 1;
         e.employeePayFrequency = 'Weekly';
         EmployerToEmployeesMap[EmployerUsername].push(_employeeUsername);
         EmployerCounter++;
    }

    //DeleteEmployee
    function deleteEmployee(string memory _employeeUsername) public {
        for (uint i = 0; i < EmployerToEmployeesMap[EmployerUsername].length; i++ )
        {
        if( keccak256(abi.encodePacked(EmployerToEmployeesMap[EmployerUsername][i])) == keccak256(abi.encodePacked(_employeeUsername)))
        {
            EmployerToEmployeesMap[EmployerUsername][i] = EmployerToEmployeesMap[EmployerUsername][EmployerToEmployeesMap[EmployerUsername].length-1];
            EmployerToEmployeesMap[EmployerUsername].length--;
        }
        }
        delete EmployeeUserNameToDetailsMap[_employeeUsername];
        EmployerCounter--;
    }

    //Payout to EMployee
    function setEmployPayAmount(string memory _employeeUsername, uint32 _amount ) public {
       EmployeeDetail storage e = EmployeeUserNameToDetailsMap[_employeeUsername];
        e.employeePayAmount = _amount;
    }
    
    function setEmployPayFrequency(string memory _employeeUsername, string memory _payFrequency) public {
      EmployeeDetail storage e = EmployeeUserNameToDetailsMap[_employeeUsername];
        e.employeePayFrequency = _payFrequency;
    }

    function viewEmployees() public view returns (string[] memory) {
        return EmployerToEmployeesMap[EmployerUsername];
    }

    function getEmployeePayFrequency(string memory _employeeUserName) public view returns (string memory) {
        return EmployeeUserNameToDetailsMap[_employeeUserName].employeePayFrequency;
    }

    function getEmployeePayAmount(string memory _employeeUserName) public view returns (uint32) {
        return EmployeeUserNameToDetailsMap[_employeeUserName].employeePayAmount;
    }
}