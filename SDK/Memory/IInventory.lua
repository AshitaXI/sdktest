--[[
 * Addons - Copyright (c) 2025 Ashita Development Team
 * Contact: https://www.ashitaxi.com/
 * Contact: https://discord.gg/Ashita
 *
 * This file is part of Ashita.
 *
 * Ashita is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Ashita is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Ashita.  If not, see <https://www.gnu.org/licenses/>.
--]]

require 'common';

--[[
* The main test module table.
--]]
local test = T{};

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetMemoryManager();
    assert(mgr ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the inventory object..
    local inv = mgr:GetInventory();
    assert(inv ~= nil, 'GetInventory returned an unexpected value.');

    -- Validate the raw inventory object..
    local raw = inv:GetRawStructure();
    assert(raw ~= nil, 'GetRawStructure returned an unexpected value.');

    --[[
    Note:   It is not possible to fully test these objects as we cannot ensure what items the player has. Instead,
            we will only be testing that we can make the function calls and get valid types of returns.
    --]]

    -- Test the raw structure fields..
    assert(raw.Containers ~= nil, 'Containers returned an unexpected value.');
    assert(#raw.Containers == 18, 'Containers returned an unexpected value.');
    assert(raw.Containers[1].Items[1].Id == 65535, 'Containers returned an unexpected value.');

    assert(raw.iLookItem ~= nil, 'iLookItem returned an unexpected value.');
    assert(raw.pItem ~= nil, 'pItem returned an unexpected value.');

    assert(raw.TreasurePool ~= nil, 'TreasurePool returned an unexpected value.');
    assert(#raw.TreasurePool == 10, 'TreasurePool returned an unexpected value.');
    assert(raw.TreasurePoolStatus ~= nil, 'TreasurePoolStatus returned an unexpected value.');
    assert(raw.TreasurePoolItemCount ~= nil, 'TreasurePoolItemCount returned an unexpected value.');

    assert(raw.ContainerMaxCapacity ~= nil, 'ContainerMaxCapacity returned an unexpected value.');
    assert(#raw.ContainerMaxCapacity == 19, 'ContainerMaxCapacity returned an unexpected value.');
    assert(raw.ContainerMaxCapacity2 ~= nil, 'ContainerMaxCapacity2 returned an unexpected value.');
    assert(#raw.ContainerMaxCapacity2 == 18, 'ContainerMaxCapacity2 returned an unexpected value.');
    assert(raw.ContainerUpdateCounter ~= nil, 'ContainerUpdateCounter returned an unexpected value.');
    assert(raw.ContainerUpdateFlags ~= nil, 'ContainerUpdateFlags returned an unexpected value.');
    assert(raw.ContainerUpdateBuffer ~= nil, 'ContainerUpdateBuffer returned an unexpected value.');
    assert(raw.ContainerUpdateIndex ~= nil, 'ContainerUpdateIndex returned an unexpected value.');

    assert(raw.Equipment ~= nil, 'Equipment returned an unexpected value.');
    assert(#raw.Equipment == 16, 'Equipment returned an unexpected value.');

    assert(raw.DisplayItemSlot ~= nil, 'DisplayItemSlot returned an unexpected value.');
    assert(raw.DisplayItemPointer ~= nil, 'DisplayItemPointer returned an unexpected value.');

    assert(raw.CheckEquipment ~= nil, 'CheckEquipment returned an unexpected value.');
    assert(#raw.CheckEquipment == 16, 'CheckEquipment returned an unexpected value.');
    assert(raw.CheckTargetIndex ~= nil, 'CheckTargetIndex returned an unexpected value.');
    assert(raw.CheckServerId ~= nil, 'CheckServerId returned an unexpected value.');
    assert(raw.CheckFlags ~= nil, 'CheckFlags returned an unexpected value.');
    assert(raw.CheckMainJob ~= nil, 'CheckMainJob returned an unexpected value.');
    assert(raw.CheckSubJob ~= nil, 'CheckSubJob returned an unexpected value.');
    assert(raw.CheckMainJobLevel ~= nil, 'CheckMainJobLevel returned an unexpected value.');
    assert(raw.CheckSubJobLevel ~= nil, 'CheckSubJobLevel returned an unexpected value.');
    assert(raw.CheckMainJob2 ~= nil, 'CheckMainJob2 returned an unexpected value.');
    assert(raw.CheckMasteryLevel ~= nil, 'CheckMasteryLevel returned an unexpected value.');
    assert(raw.CheckMasteryFlags ~= nil, 'CheckMasteryFlags returned an unexpected value.');
    assert(raw.CheckLinkshellName ~= nil, 'CheckLinkshellName returned an unexpected value.');
    assert(raw.CheckLinkshellColor ~= nil, 'CheckLinkshellColor returned an unexpected value.');
    assert(raw.CheckLinkshellIconSetId ~= nil, 'CheckLinkshellIconSetId returned an unexpected value.');
    assert(raw.CheckLinkshellIconSetIndex ~= nil, 'CheckLinkshellIconSetIndex returned an unexpected value.');
    assert(raw.CheckBallistaChevronCount ~= nil, 'CheckBallistaChevronCount returned an unexpected value.');
    assert(raw.CheckBallistaChevronFlags ~= nil, 'CheckBallistaChevronFlags returned an unexpected value.');
    assert(raw.CheckBallistaFlags ~= nil, 'CheckBallistaFlags returned an unexpected value.');

    assert(raw.UserMessageCount ~= nil, 'UserMessageCount returned an unexpected value.');
    assert(raw.SearchComment ~= nil, 'SearchComment returned an unexpected value.');

    assert(raw.CraftStatus ~= nil, 'CraftStatus returned an unexpected value.');
    assert(raw.CraftCallback ~= nil, 'CraftCallback returned an unexpected value.');
    assert(raw.CraftTimestampAttempt ~= nil, 'CraftTimestampAttempt returned an unexpected value.');
    assert(raw.CraftTimestampResponse ~= nil, 'CraftTimestampResponse returned an unexpected value.');

    --[[
    Function Testing
    --]]

    -- Test container functions..
    local item = inv:GetContainerItem(0, 0);
    assert(item ~= nil, 'GetContainerItem returned an unexpected value.');
    assert(item.Id == 65535, 'GetContainerItem returned an unexpected value.');
    assert(item.Index == 0, 'GetContainerItem returned an unexpected value.');
    assert(item.Count ~= 0, 'GetContainerItem returned an unexpected value. (Oh noes you\'re broke! D:)');
    assert(item.Flags == 0, 'GetContainerItem returned an unexpected value.');
    assert(item.Price == 0, 'GetContainerItem returned an unexpected value.');
    assert(item.Extra ~= nil, 'GetContainerItem returned an unexpected value.');
    assert(#item.Extra == 28, 'GetContainerItem returned an unexpected value.');
    local extra = table.range(0, 27):map(function () return 0; end);
    assert(item.Extra:sub(0, 28):bytes():equals(extra), 'GetContainerItem returned an unexpected value. (Gil should not be augmented..)');
    assert(inv:GetContainerCount(0) > 0, 'GetContainerCount returned an unexpected value.');
    assert(inv:GetContainerCountMax(0) > 0, 'GetContainerCountMax returned an unexpected value.');

    -- Test treasure functions..
    item = inv:GetTreasurePoolItem(0);
    assert(item ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Use ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.ItemId ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Count ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Flags ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Price ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Extra ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Status ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.Lot ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.WinningLot ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.WinningEntityServerId ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.WinningEntityTargetIndex ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.WinningEntityName ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.TimeToLive ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(item.DropTime ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    assert(inv:GetTreasurePoolStatus() ~= nil, 'GetTreasurePoolStatus returned an unexpected value.');
    assert(inv:GetTreasurePoolItemCount() ~= nil, 'GetTreasurePoolItemCount returned an unexpected value.');

    -- Test misc functions..
    assert(inv:GetContainerUpdateCounter() ~= nil, 'GetContainerUpdateCounter returned an unexpected value.');
    assert(inv:GetContainerUpdateFlags() ~= nil, 'GetContainerUpdateFlags returned an unexpected value.');
    assert(inv:GetDisplayItemSlot() ~= nil, 'GetDisplayItemSlot returned an unexpected value.');
    assert(inv:GetDisplayItemPointer() ~= nil, 'GetDisplayItemPointer returned an unexpected value.');

    -- Test equipped item functions..
    item = inv:GetEquippedItem(0);
    assert(item ~= nil, 'GetEquippedItem returned an unexpected value.');
    assert(item.Slot ~= nil, 'GetEquippedItem returned an unexpected value.');
    assert(item.Index ~= nil, 'GetEquippedItem returned an unexpected value.');

    -- Test checked functions..
    item = inv:GetCheckEquippedItem(0);
    assert(item ~= nil, 'GetCheckEquippedItem returned an unexpected value.');
    assert(item.Slot ~= nil, 'GetCheckEquippedItem returned an unexpected value.');
    assert(item.Index ~= nil, 'GetCheckEquippedItem returned an unexpected value.');
    assert(item.Unknown0000 ~= nil, 'GetCheckEquippedItem returned an unexpected value.');
    assert(item.Extra ~= nil, 'GetCheckEquippedItem returned an unexpected value.');
    assert(inv:GetCheckTargetIndex() ~= nil, 'GetCheckTargetIndex returned an unexpected value.');
    assert(inv:GetCheckServerId() ~= nil, 'GetCheckServerId returned an unexpected value.');
    assert(inv:GetCheckFlags() ~= nil, 'GetCheckFlags returned an unexpected value.');
    assert(inv:GetCheckMainJob() ~= nil, 'GetCheckMainJob returned an unexpected value.');
    assert(inv:GetCheckSubJob() ~= nil, 'GetCheckSubJob returned an unexpected value.');
    assert(inv:GetCheckMainJobLevel() ~= nil, 'GetCheckMainJobLevel returned an unexpected value.');
    assert(inv:GetCheckSubJobLevel() ~= nil, 'GetCheckSubJobLevel returned an unexpected value.');
    assert(inv:GetCheckMainJob2() ~= nil, 'GetCheckMainJob2 returned an unexpected value.');
    assert(inv:GetCheckMasteryLevel() ~= nil, 'GetCheckMasteryLevel returned an unexpected value.');
    assert(inv:GetCheckMasteryFlags() ~= nil, 'GetCheckMasteryFlags returned an unexpected value.');
    assert(inv:GetCheckLinkshellName() ~= nil, 'GetCheckLinkshellName returned an unexpected value.');
    assert(inv:GetCheckLinkshellColor() ~= nil, 'GetCheckLinkshellColor returned an unexpected value.');
    assert(inv:GetCheckLinkshellIconSetId() ~= nil, 'GetCheckLinkshellIconSetId returned an unexpected value.');
    assert(inv:GetCheckLinkshellIconSetIndex() ~= nil, 'GetCheckLinkshellIconSetIndex returned an unexpected value.');
    assert(inv:GetCheckBallistaChevronCount() ~= nil, 'GetCheckBallistaChevronCount returned an unexpected value.');
    assert(inv:GetCheckBallistaChevronFlags() ~= nil, 'GetCheckBallistaChevronFlags returned an unexpected value.');
    assert(inv:GetCheckBallistaFlags() ~= nil, 'GetCheckBallistaFlags returned an unexpected value.');

    -- Test search comment functions..
    assert(inv:GetSearchComment() ~= nil, 'GetSearchComment returned an unexpected value.');

    -- Test crafting functions..
    assert(inv:GetCraftStatus(), 'GetCraftStatus returned an unexpected value.');
    assert(inv:GetCraftCallback(), 'GetCraftCallback returned an unexpected value.');
    assert(inv:GetCraftTimestampAttempt(), 'GetCraftTimestampAttempt returned an unexpected value.');
    assert(inv:GetCraftTimestampResponse(), 'GetCraftTimestampResponse returned an unexpected value.');

    -- Test selected item functions..
    inv:GetSelectedItemName(); -- Note: This can return nil, so we just test the call functions without throwing.
    assert(inv:GetSelectedItemId() ~= nil, 'GetSelectedItemId returned an unexpected value.');
    assert(inv:GetSelectedItemIndex() ~= nil, 'GetSelectedItemIndex returned an unexpected value.');
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetMemoryManager():GetInventory():SetCraftStatus()
    AshitaCore:GetMemoryManager():GetInventory():SetCraftCallback()
    AshitaCore:GetMemoryManager():GetInventory():SetCraftTimestampAttempt()
    AshitaCore:GetMemoryManager():GetInventory():SetCraftTimestampResponse()
--]]