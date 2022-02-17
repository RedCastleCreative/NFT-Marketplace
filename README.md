This is an NFT Marketplace app built with React and Solidity.

Please run **npm install** on the terminal to download the appropriate packages defined in the package.json file. 

**Please ensure you have downloaded the following additionally **

1. Ganache
2. Truffle (global installation)
3. Metamask.io (hooked up on the browser)

**To compile using Truffle and to deploy onto local Ganache blockchain**
Ensure you have Ganache running on port 7545 and use "truffle compile" to compile.
To deploy contracts, use "truffle migrate --reset".

**To run the development server on a local host:** npm run start

**To mint and perform other actions**
Login is with MetaMask.  Ensure MetaMask is on the local Ganache network and import one or more 
of the Ganache test accounts to MetaMask.

**OVERVIEW**
Currently this app is a bare-bones starting point for an NFT marketplace.  The only functionality at this point is 
the ability to mint NFTs onto the blockchain on a test network (Ganache), however other functionalities have been 
defined in the backend, but not yet implemented.  This app follows ERC721 standards.
