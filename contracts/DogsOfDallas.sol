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
    
    function DogsOfDallas() {
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

    // This function allows owners of dogs in the city of Dallas to delete their dogs' profiles on the blockchain.
    function deleteDog(uint _id) public {
        dogs_deleted++;
        dogs[_id].id = 0;
        dogs[_id].name = "";
        dogs[_id].birthdate = "";
        dogs[_id].breeds = new string[](0);
        dogs[_id].owners = new address[](0);
    }

    // This function allows owners of dogs in the city of Dallas to view their dogs' profiles on the blockchain.
    function viewDog(uint _id) public view returns (uint, string, string, string[], address[]) {
        dogs_viewed++;
        return (dogs[_id].id, dogs[_id].name, dogs[_id].birthdate, dogs[_id].breeds, dogs[_id].owners);
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