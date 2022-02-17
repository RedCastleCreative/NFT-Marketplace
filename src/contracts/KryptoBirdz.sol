// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {
    //array to store NFTs
    string [] public kryptoBirdz;

    mapping(string => bool) _kryptoBirdzExists;

    function mint (string memory _KryptoBird) public {

        require(!_kryptoBirdzExists[_KryptoBird], 'Error - already exists');
        //uint _id = KryptoBirdz.push(_KryptoBird);
        kryptoBirdz.push(_KryptoBird);
        uint _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);
        _kryptoBirdzExists[_KryptoBird] = true;
    }

    constructor () ERC721Connector ('KryptoBird', 'KBIRDZ') {

    }




}