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

--[[
* The main test module table.
--]]
local test = { };

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
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
    assert(#v == 13, 'TreasurePool returned an unexpected value.');
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
    assert(#v == 13, 'TreasurePool returned an unexpected value.');

    v = i.ContainerMaxCapacity2;
    assert(v ~= nil, 'ContainerMaxCapacity2 returned an unexpected value.');
    assert(#v == 13, 'TreasurePool returned an unexpected value.');

    v = i.Equipment;
    assert(v ~= nil, 'Equipment returned an unexpected value.');
    assert(#v == 16, 'TreasurePool returned an unexpected value.');

    v = i.CraftStatus;
    assert(v ~= nil, 'CraftStatus returned an unexpected value.');
    v = i.CraftCallback;
    assert(v ~= nil, 'CraftCallback returned an unexpected value.');
    v = i.CraftTimestamp;
    assert(v ~= nil, 'CraftTimestamp returned an unexpected value.');

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

    -- Test the equipment..
    item = inv:GetEquippedItem(0);
    assert(item ~= nil, 'GetEquippedItem returned an unexpected value.');

    -- Test the craft functions..
    inv:GetCraftStatus();
    inv:GetCraftCallback();
    inv:GetCraftTimestamp();

    -- Test the selected item..
    inv:GetSelectedItemName();
    inv:GetSelectedItemId();
    inv:GetSelectedItemIndex();
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    Inventory:SetCraftStatus()
    Inventory:SetCraftCallback()
    Inventory:SetCraftTimestamp()
        - We do not want to risk a player ban, so we do not tamper with sensitive data like this.
--]]