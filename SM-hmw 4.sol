pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SpaceComponentCampaign is ERC721 {

    struct Campaign {
        string componentName;
        string manufacturer;
        uint256 targetQuantity;
        uint256 currentQuantity;
        string documentationHash;
        bool testingCompleted;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public nextTokenId;

    constructor() ERC721("SpaceComponentCampaign","SCC") {}

    function createCampaign(
        string memory componentName,
        string memory manufacturer,
        uint256 targetQuantity
    ) public {

        uint256 tokenId = nextTokenId;
        _mint(msg.sender, tokenId);

        campaigns[tokenId] = Campaign(
            componentName,
            manufacturer,
            targetQuantity,
            0,
            "",
            false
        );

        nextTokenId++;
    }

    function joinCampaign(uint256 tokenId, uint256 quantity) public {
        campaigns[tokenId].currentQuantity += quantity;
    }

    function uploadDocumentation(uint256 tokenId, string memory hash) public {
        campaigns[tokenId].documentationHash = hash;
        campaigns[tokenId].testingCompleted = true;
    }
}