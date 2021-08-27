pragma solidity ^0.5.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";

contract WondersToken is ERC721Full {
    constructor() public ERC721Full("WondersToken", "WDRS") {}
    
    struct Artwork {
        string name;
        uint256 appraisalValue;
    }
    
    mapping(uint256 => Artwork) public artCollection;
    
    event Appraisal(uint256 tokenId, uint256 appraisalValue, string reportURI);
    
    function registerSite(address owner, string memory name, string memory tokenURI, uint256 initialAppraisalValue )
        public
        returns (uint256)
    {
        uint256 tokenId = totalSupply();
        _mint(owner, tokenId);
        _setTokenURI(tokenId, tokenURI);
        artCollection[tokenId] = Artwork(name, initialAppraisalValue);
        return tokenId;
    }
    
    
    function newAppraisal(
        uint256 tokenId,
        uint256 newAppraisalValue,
        string memory reportURI
    ) public returns (uint256) {
        artCollection[tokenId].appraisalValue = newAppraisalValue;

        emit Appraisal(tokenId, newAppraisalValue, reportURI);

        return artCollection[tokenId].appraisalValue;
    }
}