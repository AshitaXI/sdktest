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

    -- Validate the recast object..
    local recast = mgr:GetRecast();
    assert(recast ~= nil, 'GetRecast returned an unexpected value.');

    -- Test the recast functions..
    assert(recast:GetAbilityRecast(0) ~= nil, 'GetAbilityRecast returned an unexpected value.');
    assert(recast:GetAbilityCalc1(0) ~= nil, 'GetAbilityCalc1 returned an unexpected value.');
    assert(recast:GetAbilityTimerId(0) ~= nil, 'GetAbilityTimerId returned an unexpected value.');
    assert(recast:GetAbilityCalc2(0) ~= nil, 'GetAbilityCalc2 returned an unexpected value.');
    assert(recast:GetAbilityTimer(0) ~= nil, 'GetAbilityTimer returned an unexpected value.');
    assert(recast:GetSpellTimer(0) ~= nil, 'GetSpellTimer returned an unexpected value.');
end

-- Return the test module table..
return test;