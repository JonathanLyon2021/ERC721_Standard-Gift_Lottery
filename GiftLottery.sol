//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.11;

import './node_modules/@openzepplin/contracts/token/ERC721/ERC721.sol';
import './node_modules/@openzepplin/contracts/utils/Counters.sol';

contract GiftLottery is ERC721 {
    address private owner;
    address[] private participants;
    uint256 private endTime;
}

struct Gift {
    string title;
    string description;
    string tokenURI;
}

mapping(uint256 => Gift) giftIdToGift;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

constructor(uint256 _endtime) ERC721("GiftLottery", "GLT") {
    owner = msg.sender;
    endtime = _endtime;
    }
    
modifier onlyOwner {
    require(msg.sender == owner, "Must be the Contract Owner");
_;
}

event CreateGift(address indexed participant, uint256 giftId);

function createGift(string calldata _title, string calldata _description, string calldata token URI) external {
    require(endtime >= block.timestamp, "Creation Time is Over");
    _tokenIds.increment();
    uint256 indexx = _tokenIds.current();
    
    _mint(owner, index);
    giftIdToGift[index] = Gift(_title, _description, tokenURI);
    
    
    participants.push(msg.sender);
    emit CreateGift(msg.sender, index);
}

function pseudoRandom(uint256 _giftId) private view returns(uint) {
    Gift memory gift = giftIdToGift[_giftId];
    return uint(keccak256(abi.encodePacked(gift.title, gift.description, gift.tokenURI, _giftId))) % participants.length;
}

event ReceivedGift(address indexed winner, uint256 giftId);

function distributeGifts() public onlyOwner {
    for(uint i = 1; i <= _tokenIds.current(); i++) {
    uint randomAddress = pseudoRandom(i);
    
    address winner = participants[randomAddress];
    transferFrom(msg.sender, winner, i);
    
    emit ReceivedGift(winner, i);
   
   }
}
    
