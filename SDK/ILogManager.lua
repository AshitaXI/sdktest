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
    -- Validate the main object..
    local mgr = LogManager;
    assert(mgr ~= nil, 'LogManager was nil; this is a critical error!');

    -- Test logging to the log file..
    mgr:Log(5, 'sdktest', 'This is a test message.');

    -- Test the log level property..
    local prev = mgr:GetLogLevel();
    mgr:SetLogLevel(4);
    local curr = mgr:GetLogLevel();
    mgr:SetLogLevel(prev);

    assert(curr == 4, 'GetLogLevel returned an unexpected value.');
end

-- Return the test module table..
return test;