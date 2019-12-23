// Please fix this file in order to properly deploy your smart contract.
const Employer = artifacts.require("./Employer.sol");

module.exports = function(deployer) {
  deployer.deploy(Employer, '220292','0x0000000000000000000000000000000000000000','John','Deakin');
};
