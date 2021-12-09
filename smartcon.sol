// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/math/SafeMath.sol";


interface Crypter {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);
}

contract CryptoKillerNFT_MysteryBoxINCL is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    using SafeMath for uint256;

    // ENABLE THESE FOR PRODUCTION
    bool enforceTimelimit = true;
    bool enforceBoxPrice = true;

    mapping(address => uint256) lastBoxUnlock;

    uint256 createStandardPrice = 0.11 * 10**18;
    uint256 crateDeluxPrice = 0.21 * 10**18;
    uint256 crateUltimatePrice = 0.53 * 10**18;

    uint256 crateStandardPriceCPK = 650 * 10**18;
    uint256 crateDeluxPriceCPK = 1200 * 10**18;
    uint256 crateUltimatePriceCPK = 3000 * 10**18;

    
    uint256 standardBoxCount = 0;
    uint256 deluxeBoxCount = 0;
    uint256 ultimateBoxCount = 0;

    uint256 standardBoxLimit = 3000;
    uint256 deluxeBoxLimit = 1500;
    uint256 ultimateBoxLimit = 500;

    address payable adrPandao = payable(0xd8b6AB7306c194e3DC87071Aed0b70f2e67BADc6);
    address payable adrVscorpio = payable(0xe3DF2c1b3204bBE31dc9Dcd49EF6AbE8D138b5ea);
    address ERC20_Address = 0xf10499b90bcC14ebA723C7Dabe51bfaE9fB0B681; // Crypter token address

    string commonURI = "https://cloudflare-ipfs.com/ipfs/QmSQ8NTSYwiQGQgpwVAPjHrUKaVtXbDaAGAz5SrCwN4Eq6";
    string uncommonURI = "https://cloudflare-ipfs.com/ipfs/QmPMr1bpH84TqqWr2fCPW5m1bDULWfSzVDLD7MqdE8bw82";
    string rareURI = "https://cloudflare-ipfs.com/ipfs/QmT51YebQLfCNhNXoXPnbF1C9T4boHVVbLc5seNRououee";
    string epicURI = "https://cloudflare-ipfs.com/ipfs/QmSsXUwqLVxr8xC26yvTFJUVutcpWC9y6kccMnnuforSyk";
    string exoticURI = "https://cloudflare-ipfs.com/ipfs/QmaBHteLDMU9deB3um3ijxC78FspUEXpCYBfV9MXsc8FqK";
    string mysticURI = "https://cloudflare-ipfs.com/ipfs/QmdcKehm4bu83LxwW3u6Qa1k791kGzdbfzJGwmjxQsaBHa";
    string legendaryURI = "https://cloudflare-ipfs.com/ipfs/QmQFaiVRYqdWM6YZmGNLbCahx57wFzW6CUSGjaUzXNXb16";

    event NewItemMinted(address owner, uint256 tokenId, string tokenURI);
    
    event StandardBoxOpen(address caller);
    event DeluxeBoxOpen(address caller);
    event UltimateBoxOpen(address caller);

    event BoxUnlockSplitFee(uint256 bnbRVscorpio, uint256 bnbRPandao);

    function random() internal view returns (uint) {
        uint randomHash = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender)));
        return (randomHash % 1000) + 1;
    } 

    function standardUnbox() internal returns (bool)
    {
        uint256 randomNumber = random();
        uint256 nftTierWon;

        if(randomNumber >= 1 && randomNumber <= 500) nftTierWon = 1;
        if(randomNumber >= 500 && randomNumber <= 800) nftTierWon = 2;
        if(randomNumber >= 800 && randomNumber <= 950) nftTierWon = 3;
        if(randomNumber >= 950 && randomNumber <= 1000) nftTierWon = 4;

        if(nftTierWon == 1)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, commonURI);
        emit NewItemMinted(msg.sender, newItemId, commonURI);
        standardBoxCount++;
        return true;
        }

        if(nftTierWon == 2)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, uncommonURI);
        emit NewItemMinted(msg.sender, newItemId, uncommonURI);
        standardBoxCount++;
        return true;
        }      

        if(nftTierWon == 3)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, rareURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        standardBoxCount++;
        return true;
        }      

        if(nftTierWon == 4)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, epicURI);
        emit NewItemMinted(msg.sender, newItemId, epicURI);
        standardBoxCount++;
        return true;
        }   
        return false;
    }

    function deluxeUnbox() internal returns (bool)
    {
        uint256 randomNumber = random();
        uint256 nftTierWon;

        if(randomNumber >= 1 && randomNumber <= 10) nftTierWon = 1;
        if(randomNumber >= 10 && randomNumber <= 510) nftTierWon = 2;
        if(randomNumber >= 510 && randomNumber <= 869) nftTierWon = 3;
        if(randomNumber >= 869 && randomNumber <= 969) nftTierWon = 4;
        if(randomNumber >= 969 && randomNumber <= 989) nftTierWon = 5;
        if(randomNumber >= 989 && randomNumber <= 999) nftTierWon = 6;
        if(randomNumber == 1000) nftTierWon = 7;

        if(nftTierWon == 1)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, commonURI);
        emit NewItemMinted(msg.sender, newItemId, commonURI);
        deluxeBoxCount++;
        return true;
        }

        if(nftTierWon == 2)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, uncommonURI);
        emit NewItemMinted(msg.sender, newItemId, uncommonURI);
        deluxeBoxCount++;
        return true;
        }      

        if(nftTierWon == 3)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, rareURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        deluxeBoxCount++;
        return true;
        }      

        if(nftTierWon == 4)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, epicURI);
        emit NewItemMinted(msg.sender, newItemId, epicURI);
        deluxeBoxCount++;
        return true;
        }
        if(nftTierWon == 5)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, exoticURI);
        emit NewItemMinted(msg.sender, newItemId, exoticURI);
        deluxeBoxCount++;
        return true;
        }    
        if(nftTierWon == 6)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, mysticURI);
        emit NewItemMinted(msg.sender, newItemId, mysticURI);
        deluxeBoxCount++;
        return true;
        }  
        if(nftTierWon == 7)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, legendaryURI);
        emit NewItemMinted(msg.sender, newItemId, legendaryURI);
        deluxeBoxCount++;
        return true;
        }  

        return false;
    }

    function ultimateUnbox() internal returns (bool)
    {
        uint256 randomNumber = random();
        uint256 nftTierWon;

        if(randomNumber >= 1 && randomNumber <= 500) nftTierWon = 3;
        if(randomNumber >= 500 && randomNumber <= 800) nftTierWon = 4;
        if(randomNumber >= 800 && randomNumber <= 900) nftTierWon = 5;
        if(randomNumber >= 900 && randomNumber <= 970) nftTierWon = 6;
        if(randomNumber >= 970 && randomNumber <= 1000) nftTierWon = 7;


        if(nftTierWon == 3)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, rareURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        ultimateBoxCount++;
        // one more NFT
        _tokenIds.increment();
        newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, rareURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        ultimateBoxCount++;
        return true;
        }      

        if(nftTierWon == 4)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, epicURI);
        emit NewItemMinted(msg.sender, newItemId, epicURI);
        ultimateBoxCount++;
        // one more NFT
        _tokenIds.increment();
        newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, epicURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        ultimateBoxCount++;
        return true;
        }
        if(nftTierWon == 5)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, exoticURI);
        emit NewItemMinted(msg.sender, newItemId, exoticURI);
        ultimateBoxCount++;
        // one more NFT
        _tokenIds.increment();
        newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, exoticURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        ultimateBoxCount++;
        return true;
        }    
        if(nftTierWon == 6)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, mysticURI);
        emit NewItemMinted(msg.sender, newItemId, mysticURI);
        ultimateBoxCount++;
        // one more NFT
        _tokenIds.increment();
        newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, mysticURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        ultimateBoxCount++;
        return true;
        }  
        if(nftTierWon == 7)
        {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, legendaryURI);
        emit NewItemMinted(msg.sender, newItemId, legendaryURI);
        ultimateBoxCount++;
        // one more NFT
        _tokenIds.increment();
        newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, legendaryURI);
        emit NewItemMinted(msg.sender, newItemId, rareURI);
        ultimateBoxCount++;
        return true;
        }  

        return false;
    }


    constructor() ERC721("CryptoKiller", "CRPTK") {}

    function openStandardBox() external payable returns (bool)
    {
        emit StandardBoxOpen(msg.sender);

        if(enforceTimelimit) require(lastBoxUnlock[msg.sender] <= block.timestamp - 10, "You have to wait 10 seconds before opening another box");
        if(enforceBoxPrice) require(msg.value >= createStandardPrice, "You havent sent enough BNB to open this box");

        require(standardBoxCount < standardBoxLimit, "Mystery Box capacity is over");        

        uint256 value = msg.value;     

        uint256 bnbPandao;
        uint256 bnbVscorpio;

        bnbPandao = value.mul(95).div(100);
        bnbVscorpio = value.mul(5).div(100);

        adrPandao.transfer(bnbPandao);
        adrVscorpio.transfer(bnbVscorpio);

        emit BoxUnlockSplitFee(bnbPandao, bnbVscorpio);

        standardUnbox();

        return false;
                
    }



    function openStandardBoxCPK() external payable returns (bool)
    {
        emit StandardBoxOpen(msg.sender);

        require(standardBoxCount < standardBoxLimit, "Mystery Box capacity is over");  

        uint256 cpkPandao;
        uint256 cpkVscorpio;

        cpkPandao = crateStandardPriceCPK.mul(95).div(100);
        cpkVscorpio = crateStandardPriceCPK.mul(5).div(100);

        if(enforceTimelimit) require(lastBoxUnlock[msg.sender] <= block.timestamp - 10, "You have to wait 10 seconds before opening another box");
        if(enforceBoxPrice) 

        {
        Crypter(ERC20_Address).transferFrom(
                    msg.sender,
                    adrPandao,
                    cpkPandao
            );

        Crypter(ERC20_Address).transferFrom(
                    msg.sender,
                    adrVscorpio,
                    cpkVscorpio
            );
        }
        
        standardUnbox();

        return false;
                
    }

    function openDeluxeBox() external payable returns (bool)
    {


        emit DeluxeBoxOpen(msg.sender);
        if(enforceTimelimit) require(lastBoxUnlock[msg.sender] <= block.timestamp - 10, "You have to wait 10 seconds before opening another box");
        if(enforceBoxPrice) require(msg.value >= createStandardPrice, "You havent sent enough BNB to open this box");

        require(deluxeBoxCount < deluxeBoxLimit, "Mystery Box capacity is over");

        uint256 value = msg.value;     

        uint256 bnbPandao;
        uint256 bnbVscorpio;

        bnbPandao = value.mul(95).div(100);
        bnbVscorpio = value.mul(5).div(100);

        adrPandao.transfer(bnbPandao);
        adrVscorpio.transfer(bnbVscorpio);

        emit BoxUnlockSplitFee(bnbPandao, bnbVscorpio);

        deluxeUnbox();

        return true;
                
    }

    function openDeluxeBoxCPK() external payable returns (bool)
    {


        emit DeluxeBoxOpen(msg.sender);

        uint256 cpkPandao;
        uint256 cpkVscorpio;

        cpkPandao = crateDeluxPriceCPK.mul(95).div(100);
        cpkVscorpio = crateDeluxPriceCPK.mul(5).div(100);


        if(enforceTimelimit) require(lastBoxUnlock[msg.sender] <= block.timestamp - 10, "You have to wait 10 seconds before opening another box");
        if(enforceBoxPrice) 
        {
        Crypter(ERC20_Address).transferFrom(
                    msg.sender,
                    adrPandao,
                    cpkPandao
            );

        Crypter(ERC20_Address).transferFrom(
                    msg.sender,
                    adrVscorpio,
                    cpkVscorpio
            );
        }

        require(deluxeBoxCount < deluxeBoxLimit, "Mystery Box capacity is over");


        deluxeUnbox();

        return true;
                
    }


    function openUltimateBox() external payable returns (bool)
    {

        emit UltimateBoxOpen(msg.sender);        

        if(enforceTimelimit) require(lastBoxUnlock[msg.sender] <= block.timestamp - 10, "You have to wait 10 seconds before opening another box");
        if(enforceBoxPrice) require(msg.value >= createStandardPrice, "You havent sent enough BNB to open this box");

        require(ultimateBoxCount < ultimateBoxLimit, "Mystery Box capacity is over");

        uint256 value = msg.value;     

        uint256 bnbPandao;
        uint256 bnbVscorpio;

        bnbPandao = value.mul(95).div(100);
        bnbVscorpio = value.mul(5).div(100);

        adrPandao.transfer(bnbPandao);
        adrVscorpio.transfer(bnbVscorpio);

        emit BoxUnlockSplitFee(bnbPandao, bnbVscorpio);

        ultimateUnbox();

        return true;
                
    }

    function openUltimateBoxCPK() external payable returns (bool)
    {

        emit UltimateBoxOpen(msg.sender);       

        uint256 cpkPandao;
        uint256 cpkVscorpio;

        cpkPandao = crateUltimatePriceCPK.mul(95).div(100);
        cpkVscorpio = crateUltimatePriceCPK.mul(5).div(100);


        if(enforceTimelimit) require(lastBoxUnlock[msg.sender] <= block.timestamp - 10, "You have to wait 10 seconds before opening another box");
        if(enforceBoxPrice) 
        {
        Crypter(ERC20_Address).transferFrom(
                    msg.sender,
                    adrPandao,
                    cpkPandao
            );

        Crypter(ERC20_Address).transferFrom(
                    msg.sender,
                    adrVscorpio,
                    cpkVscorpio
            );
        }

        require(ultimateBoxCount < ultimateBoxLimit, "Mystery Box capacity is over");

        ultimateUnbox();

        return true;
                
    }


}