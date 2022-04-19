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

//  This contract achieves the following goals:
//  1. DogsOfDallas is a contract that allows owners of dogs in the city of Dallas to register their dogs for a profile on the blockchain.
//  2. DogsOfDallas is a contract that allows owners of dogs in the city of Dallas to update their dogs' profiles on the blockchain.
//  3. DogsOfDallas is a contract that allows owners of dogs in the city of Dallas to delete their dogs' profiles on the blockchain.
//  4. DogsOfDallas is a contract that allows owners of dogs in the city of Dallas to view their dogs' profiles on the blockchain.
//  5. DogsOfDallas is a contract that allows owners of dogs in the city of Dallas to view the number of dogs registered on the blockchain.

// Lets start there
  struct Dog {
        uint id;
        string name;
        string birthdate;
        // Array of breeds as strings
        string[] breeds;
        // Array of owners as addresses
        address[] owners;
    }

    // Array of dogs
    Dog[] dogs;

    // Number of dogs
    uint dogs_count;

    // Number of dogs registered
    uint dogs_registered;

    // Number of dogs updated
    uint dogs_updated;

    // Number of dogs deleted
    uint dogs_deleted;

    // Number of dogs viewed
    uint dogs_viewed;
    
    function DogsOfDallas() {
        dogs_count = 0;
        dogs_registered = 0;
        dogs_updated = 0;
        dogs_deleted = 0;
        dogs_viewed = 0;
    }

    // This function allows owners of dogs in the city of Dallas to register their dogs for a profile on the blockchain.
    function registerDog(string _name, string _birthdate, string[] _breeds) public {
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

    // This function allows owners of dogs in the city of Dallas to update their dogs' profiles on the blockchain.
    function updateDog(uint _id, string _name, string _birthdate, string[] _breeds) public {
        dogs_updated++;
        dogs[_id].name = _name;
        dogs[_id].birthdate = _birthdate;
        dogs[_id].breeds = _breeds;
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