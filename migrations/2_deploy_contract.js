const BitmonCore = artifacts.require("BitmonCore");

module.exports = function(deployer) {
    deployer.deploy(BitmonCore);
};
