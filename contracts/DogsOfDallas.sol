// SPDX-License-Identifier: MIT
/// @author Jon Senterfitt
pragma solidity >=0.4.22 <0.9.0;

contract DogsOfDallas {
    // Variables
    uint public numDogs;

    // Dog struct
    struct Dog {
        uint id;
        string name;
        address owner;
        string breed;
    }

    // Dogs array
    Dog[] public dogs;

    // Constructor
    constructor() {
        numDogs = 0;
    }

    // Functions

    // Add dog with the given name, owner, and breed
    function addDog(string memory _name, string memory _breed) public returns (uint) {
        Dog memory dog = Dog({
            id: numDogs,
            name: _name,
            owner: msg.sender,
            breed: _breed
        });
        dogs.push(dog);
        numDogs++;
        return dog.id;
    }

    function getDog(uint _id) public view returns (Dog memory) {
        // Return dog
        return dogs[_id];
    }
}
