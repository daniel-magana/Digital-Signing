import React, { Component } from "react";
import AdoptionContract from "../../build/contracts/Adoption.json";
import getWeb3 from "./getWeb3";
import PetInfo from "./PetInfo";

class Perros extends Component {
    state = { adopters: null, web3: null, accounts: null, contract: null, petsData:null };

    componentDidMount = async () => {
        try {
            // Get network provider and web3 instance.
            const web3 = await getWeb3();
      
            // Use web3 to get the user's accounts.
            const accounts = await web3.eth.getAccounts();
      
            // Get the contract instance.
            const networkId = await web3.eth.net.getId();
            const deployedNetwork = AdoptionContract.networks[networkId];
            const instance = new web3.eth.Contract(
              AdoptionContract.abi,
              deployedNetwork && deployedNetwork.address,
            );
      
            // Set web3, accounts, and contract to the state, and then proceed with an
            // example of interacting with the contract's methods.
            this.setState({ web3, accounts, contract: instance }, this.runExample);
          } catch (error) {
            // Catch any errors for any of the above operations.
            alert(
                `Failed to load web3, accounts, or contract. Check console for details.`,
            );
            console.error(error);
          }
    };
 
    runExample = async () => {
        const { accounts, contract } = this.state;
    

        const response = await contract.methods.getAdopters().call();
    
        // Update state with the result.
        this.setState({ adopters: response });
    };

    getPets() {
        
        $.getJSON('../pets.json', function(data) {
            this.setState({petsData: data});
        });

        petsComponents = this.state.petsData.map((item, index) => {<PetInfo petInfo={item} adopted={this.adopters[index]}/>});
        return petsComponents;
    }

    render() {

        const petsComponents = getPets();

        return (
            <div>
                {petsComponents}
            </div>
        );
    }
}



export default Perros;