// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract PayFiNFTBadge is Initializable, ERC721Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    using Strings for uint256;

    string private _defaultURI;

    struct MintParam {
        address to;
        uint256 tokenId;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __ERC721_init("PayFi NFT Badge", "PNB");
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        require(balanceOf(to) == 0, "PayFiNFTBadge: one address can only own one token");
        _mint(to, tokenId);
    }

    function mintBatch(MintParam[] calldata params) public {
        for (uint256 i = 0; i < params.length; ) {
            mint(params[i].to, params[i].tokenId);
            unchecked {
                ++i;
            }
        }
    }

    function setDefaultURI(string calldata uri) public onlyOwner {
        _defaultURI = uri;
    }

    function _baseURI() internal view override returns (string memory) {
        return _defaultURI;
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}

    function transferFrom(address from, address to, uint256 tokenId) public override  {
        require(false, "PayFiNFTBadge: Soul Bound Token");
        super.transferFrom(from, to, tokenId);
    }

}