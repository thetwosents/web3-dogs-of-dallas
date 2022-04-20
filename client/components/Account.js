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

      // Get which network we're connected to, and the contract ABI.
      const networkId = await web3.eth.net.getId();
      // If we don't have an address for this network, bail.
      if (!networkId) {
        console.error('You must deploy the contract to the detected network.');
        return;
      }

      console.log('NetworkID', networkId);
      // Get the network name from the web3.eth.net.getNetwork object.
      const networkData = await web3.eth.net.getNetworkType(); // main, ropsten, rinkeby, etc.
      console.log('Network', networkData);
      
      setAccount(accounts[0]);

      // Get the contract abi 
      axios.get(ContractABI).then(res => {
        const contract = new web3.eth.Contract(res.data.abi, ContractAddress);
        setContract(contract);
        setContractMethods(contract.methods);
      });
    }
    
    load();
   }, []);

   useEffect(() => {
    async function load() {
      if (contract && contractMethods) {
        console.log("Contract loaded");
        let count = await contract.methods.getDogsCount().call();

        console.log("Count: " + count);
      }
    }

    load();
    }, [contract, contractMethods]);

   return (
     <div>
       The active account you're using is: {account} <br />
       On the contract: {ContractAddress} <br />
       And the JSON ABI is served: <br />
        <pre>{JSON.stringify(ContractABI, null, 2)}</pre>
       {/* If contract methods, display them in ul */}
        {contractMethods &&
          <ul>
            {/* contractMethods is an object */}
            {Object.keys(contractMethods).map(key => {
              return <li key={key}>{key}</li>;
            })}
          </ul>
        }
     </div>
   );
}

export default App;

const wrapAsync = (fn) => {
  return async (...args) => {
    try {
      return await fn(...args);
    } catch (e) {
      console.error(e);
    }
  };
}