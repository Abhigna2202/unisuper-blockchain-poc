pragma solidity ^0.5.0;

import './helpers/SafeMath.sol';
import './Account.sol';

contract Employee {
    using SafeMath for *;

    enum AccountStatusType {
        closed,
        open
    }
    enum AccountAccumulationType {
        Accumulation1,
        Accumulation2,
        DefinedBenefitDivision,
        PersonalAccount,
        Pension
    }

    address payable public EmployeeId;
    address public SpouseId;
    address payable public EmployeeAddress;
    address public PayoutAddress;
    uint32 public Counter;
    string public DOB;

    mapping (string => address) EmployeeContracts; // Map stores identifier string => contract address

    mapping (string => string) EmployeeUsernames; // Map stores username string => identifier string
    mapping (address => Account) Accounts;
    Account[] arrayOfAccounts;
    event LogCreateNewAccount(Account loggedAccount);

    constructor(string memory dob, address payable _empAddress, string memory _contractname,string memory _username) public {
        EmployeeAddress = _empAddress;
        EmployeeId = address(this);
        DOB = dob;
        Counter = 0;
        createIdentifier(_username,_contractname); // call to create identifier()
    }

//Modifier for owner access permission
    modifier onlyOwner (address _address){
        require(msg.sender == _address, "Invalid Authentication");
    _;
    }

    function setPayoutAddress(address payoutAddress) public onlyOwner(EmployeeAddress){
        PayoutAddress = payoutAddress;
    }

    function addSpouse(address payable spouseId) public onlyOwner(EmployeeAddress){
        require(SpouseId == address(0), "employee already has a spouse registered");
        SpouseId = spouseId;
    }

    function removeSpouse(address payable spouseId) public onlyOwner(EmployeeAddress){
        require(SpouseId != address(0), "employee does not have a spouse registered");
        if(SpouseId == spouseId) {
            SpouseId = address(0);
        }
    }

    function changePayoutAddress(address payable payoutAddress) public onlyOwner(EmployeeAddress){
        PayoutAddress = payoutAddress;
    }

    function createNewAccount() public onlyOwner(EmployeeAddress){
        Account tempAccountStore = new Account(EmployeeId, Account.AccountAccumulationType.Accumulation1);
        Accounts[address(tempAccountStore)] = tempAccountStore;
        arrayOfAccounts.push(tempAccountStore);
    }

    function deleteAccount(address accountAddress) public onlyOwner(EmployeeAddress){
        require(address(Accounts[accountAddress]) != address(0), 'Account has not been created');
        Accounts[accountAddress].closeAccount();
    }


    function transferFundsBetweenAccounts(address payable payTo, address payable payFrom, uint amount) public onlyOwner(EmployeeAddress){
        if(Accounts[payTo].AccountStatus() == Account.AccountStatusType.open){
            Accounts[payFrom].transferFunds(payTo, amount);
        }
    }

    function payVoluntaryContribution(address payable accountAddress, uint amount) public onlyOwner(EmployeeAddress){
        if (msg.sender == EmployeeId && address(this).balance > amount) {
            accountAddress.transfer(amount);
        }


        // Add administrative abilities and behaviours

    }

    // Creating testable code

    function getArrayOfAccounts() public view  returns (Account[] memory) {
        return arrayOfAccounts;
    }

    function checkAccountClosed(address accountAddress) public view returns (bool) {
        return Accounts[accountAddress].AccountStatus() == Account.AccountStatusType.closed;
    }

    function () external payable {}


    function createIdentifier(string memory _username, string memory _contractname) internal{
        string memory _identity = "employee_";
        bytes memory _identifier = abi.encodePacked(_identity,_username,"_",_contractname);
        EmployeeContracts[string(_identifier)] = EmployeeId;
        EmployeeUsernames[_username] = string(_identifier);
    }
}