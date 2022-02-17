// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './Libraries/Counters.sol';

contract ERC721 is ERC165, IERC721 {

    using SafeMath for uint256; 
    using Counters for Counters.Counter;

    //mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    //mapping from owner to number of owned tokens
    mapping(address => Counters.Counter) private _ownedTokensCount;

    //mapping from token id to approved addresses
    mapping (uint256 => address) private _tokenApprovals;

    constructor() {
        _registeredInterface(bytes4(keccak256('balanceOf(bytes4)')^
            keccak256('ownerOf(bytes4)')^
            keccak256('transferFrom(bytes4)')));
    }


    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), 'ERC721: Zero addresses are considered invalid');
        return _ownedTokensCount[_owner].current();

    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'ERC721: Zero addresses are considered invalid');
        return owner;
    }


    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), 'ERC721 requires minting to a non-zero address');
        require(!_exists(_tokenId), 'ERC721: token already minted');
        _tokenOwner[_tokenId] = _to;
        _ownedTokensCount[_to].increment();

        emit Transfer(address(0), _to, _tokenId);
    }


    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'ERROR ERC721: Receiving address is not valid');
        require(ownerOf(_tokenId) == _from, 'Sender is not the owner!');

        _tokenOwner[_tokenId] = _to;
        _ownedTokensCount[_from].decrement();
        _ownedTokensCount[_to].increment();

        emit Transfer(_from, _to, _tokenId);

    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        _transferFrom(_from, _to, _tokenId);
    }


}