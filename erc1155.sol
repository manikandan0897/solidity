// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MyERC1155Token is ERC1155, Ownable {
    // Token ID mapping
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC1155("https://myapi.com/api/token/{id}.json") {}

    // Function to mint tokens
    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
    }

    // Function to set token URI
    function setURI(uint256 tokenId, string memory newURI) public onlyOwner {
        _tokenURIs[tokenId] = newURI;
    }

    // Override uri function to return custom URI
    function uri(uint256 tokenId) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
