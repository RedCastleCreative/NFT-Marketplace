// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    //array of all NFTs
    uint256[] private _allTokens;

    //mapping from tokenID to position in _allTokens array
    // _allTokensIndex[X] --> _allTokens
    
    mapping (uint256 => uint256) private _allTokensIndex;

    //mapping from owner to list of all owner token IDs -  all tokens (NFTs) owner has
    //  Owner address[X]  --> [NFT1, NFT2, NFT3]
    mapping (address => uint256[]) private _ownedTokens;

    //mapping from token ID index of the owner tokens list
    mapping (uint256 => uint256) private _ownedTokensIndex;


    constructor() {
        _registeredInterface(bytes4(keccak256('totalSupply(bytes4)')^
            keccak256('tokenByIndex(bytes4)')^
            keccak256('tokenOfOwnerByIndex(bytes4)')));
    }

    function tokenByIndex(uint256 _index) public view returns (uint256) {
        require (_index < totalSupply(), 'Global index is out of bounds');
        return _allTokens[_index];
    }

 
    function tokenOfOwnerByIndex(address _owner, uint256 _index) public view returns (uint256) {
        require (_index < balanceOf(_owner), 'Owner index is out of bounds');
        return _ownedTokens[_owner][_index];
    }


    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        //add tokens to owner and keep track of total supply
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }


    //add a new NFT (token) to the _addTokens array and set the location of the NFT in the _allTokensIndex aray
    function _addTokensToAllTokenEnumeration (uint256 tokenId) private {

        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    //for our list of owners, add the NFT to _ownedTokens to the owner with address 'to' and increase the number of tokens this particular owner owns by
    //incrementing _ownedTokensIndex
    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    //return the total supply of the _allTokens array (the number of NFTs minted)
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }
}