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
    local mgr = AshitaCore:GetMemoryManager();
    assert(mgr ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the castbar object..
    local castbar = mgr:GetCastBar();
    assert(castbar ~= nil, 'GetCastBar returned an unexpected value.');

    --[[
    Note:   There is no real way to test this memory object as there are too may factors that can affect the
            values that will be used. Players will have various things applying to their cast times based on
            their current job, level, traits, job points, merits, etc.

            The following tests will be done on forced values instead.
    --]]

    -- Test setting the castbar values..
    castbar:SetMax(100);
    castbar:SetCount(1);
    castbar:SetPercent(25);
    castbar:SetCastType(2);

    -- Test getting the castbar values..
    assert(castbar:GetMax() == 100, 'GetMax returned an unexpected value.');
    assert(castbar:GetCount() == 1, 'GetCount returned an unexpected value.');
    assert(castbar:GetPercent() == 25, 'GetPercent returned an unexpected value.');
    assert(castbar:GetCastType() == 2, 'GetCastType returned an unexpected value.');
end

-- Return the test module table..
return test;