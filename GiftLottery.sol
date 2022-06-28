//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.11;

import './node_modules/@openzepplin/contracts/token/ERC721/ERC721.sol';
import './node_modules/@openzepplin/contracts/utils/Counters.sol';

contract GiftLottery is ERC721 {
    address private owner;
    address[] private participants;
    uint256 private endTime;
}