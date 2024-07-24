// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    // mapping for store items
    mapping(uint256 => string) public items;
    mapping(uint256 => string) public itemNames;
    mapping (uint256 => uint256) public itemPrices;
    uint itemsCount = 4;

    // mapping for addresses to items owned
    mapping(address => mapping(uint256 => uint256) ) public accounts;

    constructor() ERC20("Degen", "DGN") {
        // instantiate items
        items[0] = "0 : Healing Potion II : 25 DGN";
        items[1] = "1 : Shortsword : 15 DGN";
        items[2] = "2 : Firework Starters : 5 DGN";
        items[3] = "3 : Backpack Slot : 100 DGN";

        itemNames[0] = "Healing Potion";
        itemNames[1] = "Shortsword";
        itemNames[2] = "Firework Starters";
        itemNames[3] = "Backpack Slot";

        itemPrices[0] = 25;
        itemPrices[1] = 15;
        itemPrices[2] = 5;
        itemPrices[3] = 100;
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        // mint new tokens for a user
        _mint(to, amount);
    }

    function transferTokens(address to, uint256 amount) external {
        // make sure user has enough tokens
        require(checkBalance() >= amount, "You don't have enough Degen Tokens.");

        // transfer tokens
        approve(msg.sender, amount);
        transferFrom(msg.sender, to, amount);
    }

    function redeemTokens(uint256 itemID) external {
        // make sure item exists in store
        require(itemPrices[itemID] > 0, "Item doesn't exist.");

        // make sure user has enough tokens
        require(checkBalance() >= itemPrices[itemID], "You don't have enough Degen Tokens.");

        uint256 prevItemCount = accounts[msg.sender][itemID];
        uint256 prevTokens = this.balanceOf(msg.sender);

        // update user account
        accounts[msg.sender][itemID] += 1;

        // burn tokens
        burnTokens(itemPrices[itemID]);

        // make sure updates are correct
        assert(accounts[msg.sender][itemID] == prevItemCount + 1);
        assert(this.balanceOf(msg.sender) == prevTokens - itemPrices[itemID]);
    }

    function burnTokens(uint256 amount) public {
        // make sure user has enough tokens
        require(checkBalance() >= amount, "You don't have enough Degen Tokens.");
        
        // burn tokens
        super._burn(msg.sender, amount);
    }

    function checkBalance() public view returns (uint256)  {
        return this.balanceOf(msg.sender);
    }

    function viewStore() public view returns (string[] memory) {
        string[] memory storeItems = new string[](itemsCount);
        for (uint i = 0; i < itemsCount; i++) {
            storeItems[i] = items[i];
        }

        // return items available in store
        return storeItems;
    }

    function viewItemHeld(uint256 itemID) public view returns (uint256) {
        // make sure item exists in store
        require(itemPrices[itemID] > 0, "Item doesn't exist.");
        
        // return user-view of their item
        return accounts[msg.sender][itemID];
    }
}
