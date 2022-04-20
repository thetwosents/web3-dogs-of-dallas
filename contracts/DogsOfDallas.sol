// SPDX-License-Identifier: MIT
/// @author Jon Senterfitt
pragma solidity >=0.4.22 <0.9.0;

contract DogsOfDallas {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  struct Dog {
        uint id;
        string name;
        string birthdate;
        // Array of breeds as strings
        string[] breeds;
        // Array of owners as addresses
        address[] owners;
    }

    Dog[] dogs;
    uint dogs_count;
    uint dogs_registered;
    uint dogs_updated;
    uint dogs_deleted;
    uint dogs_viewed;
    
    function DogsOfDallasConstruct() public {
        dogs_count = 0;
        dogs_registered = 0;
        dogs_updated = 0;
        dogs_deleted = 0;
        dogs_viewed = 0;
    }

    // Add a new dog to the registry
    function registerDog(string memory _name, string memory _birthdate, string[] memory _breeds) public {
        dogs_registered++;
        dogs_count++;
        dogs.push(Dog({
            id: dogs_count,
            name: _name,
            birthdate: _birthdate,
            breeds: _breeds,
            owners: new address[](0)
        }));
    }

    // Update a dog by owner address and dog id
    function updateDog(address _owner, uint _dog_id, string memory _name, string memory _birthdate, string[] memory _breeds) public {
        dogs_updated++;
        Dog memory dog = dogs[_dog_id - 1];
        require(dog.owners[0] == _owner, "Only the owner of a dog can update it");
        dog.name = _name;
        dog.birthdate = _birthdate;
        dog.breeds = _breeds;
    }

    // Delete a dog by owner address and dog id
    function deleteDog(address _owner, uint _dog_id) public {
        dogs_deleted++;
        Dog memory dog = dogs[_dog_id - 1];
        require(dog.owners[0] == _owner, "Only the owner of a dog can delete it");
    }

    // View a dog by owner address and dog id
    function viewDog(uint _dog_id) public view returns (string memory _name, string memory _birthdate, string[] memory _breeds) {

        // Check if the dog exists
        Dog memory dog = dogs[_dog_id - 1]; 
        require(dog.id == _dog_id, "Dog does not exist");

        _name = dog.name;
        _birthdate = dog.birthdate;
        _breeds = dog.breeds;
    }

    // Get a list of dogs
    function getDogs() public view returns (Dog[] memory _dogs) {
        // dogs_viewed++;
        _dogs = dogs;
    }

    // This function allows owners of dogs in the city of Dallas to view the number of dogs registered on the blockchain.
    function getDogsRegistered() public view returns (uint) {
        return dogs_registered;
    }

    // This function allows owners of dogs in the city of Dallas to view the number of dogs updated on the blockchain.
    function getDogsUpdated() public view returns (uint) {
        return dogs_updated;
    }

    // This function allows owners of dogs in the city of Dallas to view the number of dogs deleted on the blockchain.
    function getDogsDeleted() public view returns (uint) {
        return dogs_deleted;
    }

    // This function allows owners of dogs in the city of Dallas to view the number of dogs viewed on the blockchain.
    function getDogsViewed() public view returns (uint) {
        return dogs_viewed;
    }

    // This function allows owners of dogs in the city of Dallas to view the number of dogs on the blockchain.
    function getDogsCount() public view returns (uint) {
        return dogs_count;
    }
    
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  
}