import { useEffect, useState } from 'react';
import axios from 'axios';
import Web3 from 'web3';

const ContractABI = "http://localhost:3001/contracts/DogsOfDallas.json"; // From stackoverflow: https://ethereum.stackexchange.com/questions/80671/error-you-must-provide-the-json-interface-of-the-contract-when-instantiating-a
const ContractAddress = "0x150428aF26C65bC27D14DDb96B1970131C2dE9E2";

function App() {
  const [account, setAccount] = useState(); // state variable to set account.
  const [contract, setContract] = useState(); // state variable to set contract.
  const [contractMethods, setContractMethods] = useState(); // state variable to set contract methods.
  
  useEffect(() => {
    async function load() {
      const web3 = new Web3(Web3.givenProvider || 'http://localhost:7545');
      const accounts = await web3.eth.requestAccounts();
      setAccount(accounts[0]);

      // Get which network we're connected to, and the contract ABI.
      const networkId = await web3.eth.net.getId();
      if (!networkId) {
        console.error('You must deploy the contract to the detected network.');
        return;
      }
      const networkData = await web3.eth.net.getNetworkType(); // main, ropsten, rinkeby, etc.      

      // Get the contract abi 
      axios.get(ContractABI).then(res => {
        const contract = new web3.eth.Contract(res.data.abi, ContractAddress);
        setContract(contract);
        // Filter out methods that begin with 0x.
        const contractMethods = Object.keys(contract.methods).filter(method => !method.startsWith('0x'));
        setContractMethods(contractMethods);
      });
    }
    
    load();
   }, []);

   useEffect(() => {
    async function load() {
      if (contract && contractMethods) {
        console.log("Contract loaded");

        // Get the current owner of the contract.
        const owner = await contract.methods.owner().call();
        console.log(`Contract owner: ${owner}`);

      }
    }

    load();
    }, [contract, contractMethods]);

    const handleMethod = (method) => {
      console.log(method);
      try {
        contract.methods[method]().call().then(console.log);
      } catch (e) {
        console.error(e);
      }
    }

   return (
     <div>
       The active account you're using is: {account} <br />
       On the contract: {ContractAddress} <br />
       And the JSON ABI is served: <br />
        <pre>{JSON.stringify(ContractABI, null, 2)}</pre>
       {/* If contract methods, display them in ul */}
       {/* Add a dog by button */}
    <div>
      <AddDogForm 
        account={account}
        contract={contract}
      />
      {/* List the dogs */}

    </div>


        {contractMethods &&
          <ul>
            {contractMethods.map(method => (
              <li key={method}>
                <button onClick={() => handleMethod(method)}>{method}</button>
              </li>
            ))}
          </ul>
        }
     </div>
   );
}

export default App;

const AddDogForm = ({
  contract,
  account
}) => {
  const [name, setName] = useState();
  const [birthdate, setBirthdate] = useState();
  const [breeds, setBreeds] = useState([]);

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log(contract);
    console.log(account);
    contract.methods.registerDog(name, birthdate, breeds).send({from: account});
  }

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Name:
        <input type="text" value={name} onChange={e => setName(e.target.value)} />
      </label>
      <label>
        Birthdate:
        <input type="text" value={birthdate} onChange={e => setBirthdate(e.target.value)} />
      </label>
      <label>
        Breeds:
        {/* Should be a comma separated list of breeds turned into an array */}
        <input type="text" value={breeds} onChange={e => setBreeds(e.target.value.split(','))} />
      </label>
      <input type="submit" value="Submit" />
    </form>
  );
}