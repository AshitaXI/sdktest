--[[
 * Addons - Copyright (c) 2021 Ashita Development Team
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
    local memManager = AshitaCore:GetMemoryManager();
    assert(memManager ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the inventory object..
    local inv = memManager:GetInventory();
    assert(inv ~= nil, 'GetInventory returned an unexpected value.');

    -- Validate the raw inventory..
    local i = inv:GetRawStructure();
    assert(i ~= nil, 'GetRawStructure returned an unexpected value.');

    --[[
    Test the raw structure..

    Note:   Because we cannot guarantee what items a user has, we are only testing that we can make the following calls and
            only expect a type of return or size of return.
    --]]

    local v = i.Containers;
    assert(v ~= nil, 'Containers returned an unexpected value.');
    assert(#v == 18, 'Containers returned an unexpected value.');
    assert(v[1].Items[1].Id == 65535, 'Containers returned an unexpected value.');

    v = i.TreasurePool;
    assert(v ~= nil, 'TreasurePool returned an unexpected value.');
    assert(#v == 10, 'TreasurePool returned an unexpected value.');

    v = i.TreasurePoolStatus;
    assert(v ~= nil, 'TreasurePoolStatus returned an unexpected value.');

    v = i.TreasurePoolItemCount;
    assert(v ~= nil, 'TreasurePoolItemCount returned an unexpected value.');

    v = i.ContainerMaxCapacity;
    assert(v ~= nil, 'ContainerMaxCapacity returned an unexpected value.');
    assert(#v == 19, 'ContainerMaxCapacity returned an unexpected value.');

    v = i.ContainerMaxCapacity2;
    assert(v ~= nil, 'ContainerMaxCapacity2 returned an unexpected value.');
    assert(#v == 18, 'ContainerMaxCapacity2 returned an unexpected value.');

    v = i.ContainerUpdateCounter;
    assert(v ~= nil, 'ContainerUpdateCounter returned an unexpected value.');
    v = i.ContainerUpdateFlags;
    assert(v ~= nil, 'ContainerUpdateFlags returned an unexpected value.');
    v = i.ContainerUpdateBuffer;
    assert(v ~= nil, 'ContainerUpdateBuffer returned an unexpected value.');
    v = i.ContainerUpdateIndex;
    assert(v ~= nil, 'ContainerUpdateIndex returned an unexpected value.');

    v = i.Equipment;
    assert(v ~= nil, 'Equipment returned an unexpected value.');
    assert(#v == 16, 'Equipment returned an unexpected value.');

    v = i.DisplayItemSlot;
    assert(v ~= nil, 'DisplayItemSlot returned an unexpected value.');
    v = i.DisplayItemPointer;
    assert(v ~= nil, 'DisplayItemPointer returned an unexpected value.');

    v = i.CheckEquipment;
    assert(v ~= nil, 'CheckEquipment returned an unexpected value.');
    assert(#v == 16, 'CheckEquipment returned an unexpected value.');

    v = i.CheckTargetIndex;
    assert(v ~= nil, 'CheckTargetIndex returned an unexpected value.');
    v = i.CheckServerId;
    assert(v ~= nil, 'CheckServerId returned an unexpected value.');
    v = i.CheckFlags;
    assert(v ~= nil, 'CheckFlags returned an unexpected value.');
    v = i.CheckMainJob;
    assert(v ~= nil, 'CheckMainJob returned an unexpected value.');
    v = i.CheckSubJob;
    assert(v ~= nil, 'CheckSubJob returned an unexpected value.');
    v = i.CheckMainJobLevel;
    assert(v ~= nil, 'CheckMainJobLevel returned an unexpected value.');
    v = i.CheckSubJobLevel;
    assert(v ~= nil, 'CheckSubJobLevel returned an unexpected value.');
    v = i.CheckMainJob2;
    assert(v ~= nil, 'CheckMainJob2 returned an unexpected value.');
    v = i.CheckMasteryLevel;
    assert(v ~= nil, 'CheckMasteryLevel returned an unexpected value.');
    v = i.CheckMasteryFlags;
    assert(v ~= nil, 'CheckMasteryFlags returned an unexpected value.');
    v = i.CheckLinkshellName;
    assert(v ~= nil, 'CheckLinkshellName returned an unexpected value.');
    v = i.CheckLinkshellColor;
    assert(v ~= nil, 'CheckLinkshellColor returned an unexpected value.');
    v = i.CheckLinkshellIconSetId;
    assert(v ~= nil, 'CheckLinkshellIconSetId returned an unexpected value.');
    v = i.CheckLinkshellIconSetIndex;
    assert(v ~= nil, 'CheckLinkshellIconSetIndex returned an unexpected value.');

    v = i.SearchComment;
    assert(v ~= nil, 'SearchComment returned an unexpected value.');

    v = i.CraftStatus;
    assert(v ~= nil, 'CraftStatus returned an unexpected value.');
    v = i.CraftCallback;
    assert(v ~= nil, 'CraftCallback returned an unexpected value.');
    v = i.CraftTimestampAttempt;
    assert(v ~= nil, 'CraftTimestampAttempt returned an unexpected value.');
    v = i.CraftTimestampResponse;
    assert(v ~= nil, 'CraftTimestampResponse returned an unexpected value.');

    --[[
    Test functions..
    --]]

    -- Test obtaining an item.. (Gil)
    local item = inv:GetContainerItem(0, 0); -- Gil
    assert(item ~= nil, 'GetContainerItem returned an unexpected value.');
    assert(item.Id == 65535, 'Id returned an unexpected value.');
    assert(item.Index == 0, 'Index returned an unexpected value.');
    assert(item.Flags == 0, 'Flags returned an unexpected value.');

    -- Test obtaining container sizes..
    local c = inv:GetContainerCount(0);     -- Inventory
    local m = inv:GetContainerCountMax(0);  -- Inventory
    assert(c > 0, 'GetContainerCount returned an unexpected value.');
    assert(m > 0, 'GetContainerCountMax returned an unexpected value.');

    -- Test the treasure pool..
    item = inv:GetTreasurePoolItem(0);
    assert(item ~= nil, 'GetTreasurePoolItem returned an unexpected value.');
    v = inv:GetTreasurePoolStatus();
    assert(v ~= nil, 'GetTreasurePoolStatus returned an unexpected value.');
    v = inv:GetTreasurePoolItemCount();
    assert(v ~= nil, 'GetTreasurePoolItemCount returned an unexpected value.');

    -- Test misc properties..
    v = inv:GetContainerUpdateCounter();
    assert(v ~= nil, 'GetContainerUpdateCounter returned an unexpected value.');
    v = inv:GetContainerUpdateFlags();
    assert(v ~= nil, 'GetContainerUpdateFlags returned an unexpected value.');
    v = inv:GetDisplayItemSlot();
    assert(v ~= nil, 'GetDisplayItemSlot returned an unexpected value.');
    v = inv:GetDisplayItemPointer();
    assert(v ~= nil, 'GetDisplayItemPointer returned an unexpected value.');

    -- Test the equipment..
    item = inv:GetEquippedItem(0);
    assert(item ~= nil, 'GetEquippedItem returned an unexpected value.');

    item = inv:GetCheckEquippedItem(0);
    assert(item ~= nil, 'GetCheckEquippedItem returned an unexpected value.');
    v = inv:GetCheckTargetIndex();
    assert(v ~= nil, 'GetCheckTargetIndex returned an unexpected value.');
    v = inv:GetCheckServerId();
    assert(v ~= nil, 'GetCheckServerId returned an unexpected value.');
    v = inv:GetCheckFlags();
    assert(v ~= nil, 'GetCheckFlags returned an unexpected value.');
    v = inv:GetCheckMainJob();
    assert(v ~= nil, 'GetCheckMainJob returned an unexpected value.');
    v = inv:GetCheckSubJob();
    assert(v ~= nil, 'GetCheckSubJob returned an unexpected value.');
    v = inv:GetCheckMainJobLevel();
    assert(v ~= nil, 'GetCheckMainJobLevel returned an unexpected value.');
    v = inv:GetCheckSubJobLevel();
    assert(v ~= nil, 'GetCheckSubJobLevel returned an unexpected value.');
    v = inv:GetCheckMainJob2();
    assert(v ~= nil, 'GetCheckMainJob2 returned an unexpected value.');
    v = inv:GetCheckMasteryLevel();
    assert(v ~= nil, 'GetCheckMasteryLevel returned an unexpected value.');
    v = inv:GetCheckMasteryFlags();
    assert(v ~= nil, 'GetCheckMasteryFlags returned an unexpected value.');
    v = inv:GetCheckLinkshellName();
    assert(v ~= nil, 'GetCheckLinkshellName returned an unexpected value.');
    v = inv:GetCheckLinkshellColor();
    assert(v ~= nil, 'GetCheckLinkshellColor returned an unexpected value.');
    v = inv:GetCheckLinkshellIconSetId();
    assert(v ~= nil, 'GetCheckLinkshellIconSetId returned an unexpected value.');
    v = inv:GetCheckLinkshellIconSetIndex();
    assert(v ~= nil, 'GetCheckLinkshellIconSetIndex returned an unexpected value.');

    v = inv:GetSearchComment();
    assert(v ~= nil, 'GetSearchComment returned an unexpected value.');

    -- Test the craft functions..
    v = inv:GetCraftStatus();
    assert(v ~= nil, 'GetCraftStatus returned an unexpected value.');
    v = inv:GetCraftCallback();
    assert(v ~= nil, 'GetCraftCallback returned an unexpected value.');
    v = inv:GetCraftTimestampAttempt();
    assert(v ~= nil, 'GetCraftTimestampAttempt returned an unexpected value.');
    v = inv:GetCraftTimestampResponse();
    assert(v ~= nil, 'GetCraftTimestampResponse returned an unexpected value.');

    -- Test the selected item..
    inv:GetSelectedItemName(); -- Ensure the call works and doesn't fail/error..
    v = inv:GetSelectedItemId();
    assert(v ~= nil, 'GetSelectedItemId returned an unexpected value.');
    v = inv:GetSelectedItemIndex();
    assert(v ~= nil, 'GetSelectedItemIndex returned an unexpected value.');
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    Inventory:SetCraftStatus()
    Inventory:SetCraftCallback()
    Inventory:SetCraftTimestampAttempt()
    Inventory:SetCraftTimestampResponse()
        - We do not want to risk a player ban, so we do not tamper with sensitive data like this.
--]]