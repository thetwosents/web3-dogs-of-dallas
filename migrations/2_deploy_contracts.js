// A deployment for the contracts
const DogsOfDallas = artifacts.require("DogsOfDallas");

module.exports = function(_deployer) {
    _deployer.deploy(Adoption);
  };