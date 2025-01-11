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
    -- Cleanup test pointers..
    local mgr = AshitaCore:GetPointerManager();
    if (mgr ~= nil) then
        mgr:Delete('sdktest_pointer_1');
        mgr:Delete('sdktest_pointer_2');
    end
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetPointerManager();
    assert(mgr ~= nil, 'GetPointerManager returned an unexpected value.');

    -- Test adding a pointer.. (direct value)
    mgr:Add('sdktest_pointer_1', 0x13371337);
    assert(mgr:Get('sdktest_pointer_1') == 0x13371337, 'Get returned an unexpected value.');

    -- Test adding a pointer.. (scanned)
    assert(mgr:Add('sdktest_pointer_2', 'FFXiMain.dll', '8B560C8B042A8B0485', 9, 0) == mgr:Get('entitymap'), 'Get returned an unexpected value.');

    -- Test updating an existing pointer..
    mgr:Add('sdktest_pointer_1', 0xDEADBEEF);
    assert(mgr:Get('sdktest_pointer_1') == 0xDEADBEEF, 'Get returned an unexpected value.');

    -- Test deleting pointers..
    mgr:Delete('sdktest_pointer_1');
    mgr:Delete('sdktest_pointer_2');

    assert(mgr:Get('sdktest_pointer_1') == 0, 'Get returned an unexpected value.');
    assert(mgr:Get('sdktest_pointer_2') == 0, 'Get returned an unexpected value.');
end

-- Return the test module table..
return test;