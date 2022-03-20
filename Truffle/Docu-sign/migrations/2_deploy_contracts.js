//var Adoption = artifacts.require("Adoption");
var UserSign = artifacts.require("UserSign");

module.exports = function(deployer) {
  //deployer.deploy(Adoption);
  deployer.deploy(UserSign);
};