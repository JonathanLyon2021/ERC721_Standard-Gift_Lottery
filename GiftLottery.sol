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