const TestDogsOfDallas = artifacts.require("DogsOfDallas");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("TestDogsOfDallas", function (/* accounts */) {
  it("should assert true", async function () {
    await TestDogsOfDallas.deployed();
    return assert.isTrue(true);
  });

  // Test the addDog function
  it("should add a dog", async function () {
    const dogsOfDallas = await TestDogsOfDallas.deployed();
    const txResult = await dogsOfDallas.addDog("Fido","Husky");
    const dogCount = await dogsOfDallas.numDogs();
    assert.equal(dogCount, 1);
  });

  // Test the getDog function
  it("should get a dog", async function () {
    const dogsOfDallas = await TestDogsOfDallas.deployed();
    const txResult = await dogsOfDallas.addDog("Fido","Husky");
    const dog = await dogsOfDallas.getDog(0);
    assert.equal(dog.name, "Fido");
  });
  

});