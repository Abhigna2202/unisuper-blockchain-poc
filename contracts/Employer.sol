pragma solidity ^0.5.0;

import './helpers/SafeMath.sol';

contract Employer{
    using SafeMath for *;

    address public EmployerId;
    address payable public EmployerAddress;
    address public EmployerPayoutAddress;
    address public EmployeePayoutAddress;
    uint32 public EmployerCounter;
    string public EmployerDOB;

    mapping (string => address) EmployerContracts; // Map stores identifier string => contract address

    mapping (string => string) EmployerUsernames; // Map stores username string => identifier string

    constructor(string memory _emplrdob, address payable _emplrAddress, string memory _username, string memory _contractname) public {
        EmployerAddress = _emplrAddress;
        EmployerId = address(this);
        EmployerDOB = _emplrdob;
        EmployerCounter = 0;
        createIdentifier(_username,_contractname);
    }

    //Update the two maps with the respective values
    function createIdentifier(string memory _username, string memory _contractname) internal {
        string memory _identity = "employer_";
        bytes memory _identifier = abi.encodePacked(_identity,_username,"_",_contractname);
        EmployerContracts[string(_identifier)] = EmployerId;
        EmployerUsernames[_username] = string(_identifier);
    }

    // Functions Go Here
    //AddEmployee
    //DeleteEmployee
    //PayEmployeeFrequency
    //SetPayoutPercentage
    //ViewEmployee


}