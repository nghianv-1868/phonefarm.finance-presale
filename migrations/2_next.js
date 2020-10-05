const PhoneToken = artifacts.require('PhoneToken');
const PreSale = artifacts.require('PreSale');

module.exports = async function (deployer) {
  try {
    let PhoneAddress = await deployer.deploy(PhoneToken);
    await deployer.deploy(PreSale, PhoneAddress);
  } catch (error) {
    console.log(error);
  }
  return;
};
