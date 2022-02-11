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

    -- Validate the castbar object..
    local castbar = memManager:GetCastBar();
    assert(castbar ~= nil, 'GetCastBar returned an unexpected value.');

    --[[
    There is no real / safe way to test these as we cannot guarantee pretty much any of the data.

    Players will have varying things that will alter the cast time of anything such as:
        - Job Traits
        - Gear
        - Merits
        - Job Points
        - etc.

    Because of this, we can't really test for valid data and just force set things.
    --]]

    -- Test setting the castbar values..
    castbar:SetMax(100);
    castbar:SetCount(1);
    castbar:SetPercent(25);
    castbar:SetCastType(2);

    -- Test getting the castbar values..
    local v = castbar:GetMax();
    assert(v == 100, 'GetMax returned an unexpected value.');
    v = castbar:GetCount();
    assert(v == 1, 'GetCount returned an unexpected value.');
    v = castbar:GetPercent();
    assert(v == 25, 'GetPercent returned an unexpected value.');
    v = castbar:GetCastType();
    assert(v == 2, 'GetCastType returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

-- Return the test module table..
return test;