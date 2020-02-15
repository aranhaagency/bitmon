const BitmonContract = artifacts.require("BitmonContract");

module.exports = function(deployer) {
    deployer.deploy(BitmonContract);
};
