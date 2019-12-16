pragma solidity ^0.5.0;

import './helpers/SafeMath.sol';

contract Employers{
    using SafeMath for *;

    address public EmployerId;
    address payable public EmployerAddress;
    address public EmployerPayoutAddress;
    address public EmployeePayoutAddress;
    uint32 public EmployeeCounter;
    string public EmployerDOB;

    mapping (string => address) EmployerIdentifierToContractMap; // Map stores identifier string => contract address

    mapping (string => string) EmployerUsernameToIdentifierMap; // Map stores username string => identifier string
    
    constructor(string memory _emplrdob, address payable _emplrAddress, string memory _username, string memory _contractname) public {
        EmployerAddress = _emplrAddress;
        EmployerId = address(this);
        EmployerDOB = _emplrdob;
        EmployeeCounter = 0;
        createIdentifier(_username,_contractname);
    }

    //Update teh two maps with the respective values
    //a thought if this function to be private or public
    function createIdentifier(string memory _username, string memory _contractname) private {
        string memory _identity = "employer_";
        bytes memory _identifier = abi.encodePacked(_identity,"_",_username,"_",_contractname);
        EmployerIdentifierToContractMap[string(_identifier)] = EmployerId;
        EmployerUsernameToIdentifierMap[_username] = string(_identifier);
    }

    // functions go here
    //AddEmployee
    //DeleteEmployee
    //PayEmployeeFrequency
    //SetPayoutPercentage
    //ViewEmployee


}