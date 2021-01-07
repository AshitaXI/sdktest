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
    local offsetManager = AshitaCore:GetOffsetManager();
    assert(offsetManager ~= nil, 'GetOffsetManager returned an unexpected value.');

    -- Test basic offset usage..
    offsetManager:Add('sdktest', 'offset1', 1337);
    local v = offsetManager:Get('sdktest', 'offset1');
    assert(v == 1337, 'Get returned an unexpected value.');

    -- Test updating an existing offset..
    offsetManager:Add('sdktest', 'offset1', 0xBEEF);
    v = offsetManager:Get('sdktest', 'offset1');
    assert(v == 0xBEEF, 'Get returned an unexpected value.');

    -- Test deleting an offset..
    offsetManager:Delete('sdktest', 'offset1');
    v = offsetManager:Get('sdktest', 'offset1');
    assert(v == 0, 'Get returned an unexpected value.');

    -- Test deleteing an offset section..
    offsetManager:Add('sdktest', 'offset1', 1337);
    offsetManager:Add('sdktest', 'offset2', 0xBEEF);
    offsetManager:Delete('sdktest');

    v = offsetManager:Get('sdktest', 'offset1');
    assert(v == 0, 'Get returned an unexpected value.');
    v = offsetManager:Get('sdktest', 'offset2');
    assert(v == 0, 'Get returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Cleanup test offsets..
    local offsetManager = AshitaCore:GetOffsetManager();
    if (offsetManager ~= nil) then
        offsetManager:Delete('sdktest');
    end
end

-- Return the test module table..
return test;

--[[
Untested Functions:

--]]