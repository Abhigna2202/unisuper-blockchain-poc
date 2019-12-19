pragma solidity ^0.5.0;

import './helpers/SafeMath.sol';
import './Employee.sol';
import './Account.sol';
import './Employer.sol';

contract UniSuperLedger {
    using SafeMath for *;

    mapping (string => address) AccountMap;
    string[] EmployeeId;
    modifier uniqueUser (string memory _username){
        require(AccountMap[_username] == address(0), "Username already taken !");
    _;
    }

    function createEmployeeId(string memory _dob,
                              address payable _addressEmployee,
                              string memory _username,
                              string memory _contractname) public uniqueUser(_username){
        Employee tempEmp = new Employee(_dob, _addressEmployee, _contractname, _username);
        AccountMap[_username] = address(tempEmp);
        EmployeeId.push(_username);
    }

    function getEmployeeContractAddress(string memory _username) public view returns( address eAddress) {
        return AccountMap[_username];
    }
    function createEmployerId(string memory _dob,
                              address payable _addressEmployer,
                              string memory _username,
                              string memory _contractname) public uniqueUser(_username){
        Employer tempEmplr = new Employer(_dob, _addressEmployer, _contractname, _username);
        AccountMap[_username] = address(tempEmplr);
    }
    function getEmployerContractAddress(string memory _username) public view returns( address eAddress) {
        return AccountMap[_username];
    }
 }
