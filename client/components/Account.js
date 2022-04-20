import { useEffect, useState } from 'react';
import axios from 'axios';
import Web3 from 'web3';

const ContractABI = "http://localhost:3001/contracts/DogsOfDallas.json"; // From stackoverflow: https://ethereum.stackexchange.com/questions/80671/error-you-must-provide-the-json-interface-of-the-contract-when-instantiating-a
const ContractAddress = "0x150428aF26C65bC27D14DDb96B1970131C2dE9E2";

function App() {
  const [account, setAccount] = useState(); // state variable to set account.
  const [contract, setContract] = useState(); // state variable to set contract.

  useEffect(() => {
    async function load() {
      const web3 = new Web3(Web3.givenProvider || 'http://localhost:7545');
      const accounts = await web3.eth.requestAccounts();
      setAccount(accounts[0]);   

      // Get the contract abi 
      axios.get(ContractABI).then(res => {
        const contract = new web3.eth.Contract(res.data.abi, ContractAddress);
        setContract(contract);
      });
    }

    load();
  }, []);

  useEffect(() => {
    async function load() {
      if (contract) {
        console.log("Contract loaded");

        // Get the current owner of the contract.
        const owner = await contract.methods.owner().call();
        console.log(`Contract owner: ${owner}`);

      }
    }

    load();
  }, [contract]);

  return (
    <div>
      The active account you're using is: {account} <br />
      On the contract: {ContractAddress} <br />
      And the JSON ABI is served: <br />
      <pre>{JSON.stringify(ContractABI, null, 2)}</pre>
      
    </div>
  );
}

export default App;