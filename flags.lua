--[[
 * Addons - Copyright (c) 2020 Ashita Development Team
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
]]--

--[[
Flags Helper Module

This is a simple module that helps with testing by holding flag state information.
Flags are used as simple true/false validations if a test has successfully done its purpose.

Registering flags should be done once, in a single block table in the format of:

    local flags = require('flags');

    local test_flags = {
        { name = 'some_flag_name_1', seen = false },
        { name = 'some_flag_name_2', seen = false },
        { name = 'some_flag_name_3', seen = false },
    };
    flags.register(test_flags);

While testing, a flag can be set to its true state by using:

    flags.set('some_flag_name_1');

You can also test if a flag is set via:

    local f = flags.is_set('some_flag_name_1');

Once all testing has completed, you can validate all your flags have been met/set via:

    flags.validate();
]]--

--[[
* The main flags module table.
--]]
local flags = { };

--[[
* Table of registered flags that are part of the testing.
--]]
flags.flags = { };

--[[
* Registers a table of flags to be monitored.
*
* @param {table} tests - The table of tests to monitor.
--]]
function flags.register(tests)
    flags.flags = tests;
end

--[[
* Returns if the given flag is set or not.
*
* @param {string} name - The name of the flag to check.
* @return {bool} True if set, false otherwise.
--]]
function flags.is_set(name)
    for _, v in pairs(flags.flags) do
        if (v.name == string.lower(name)) then
            return v.seen;
        end
    end
    error(string.format('is_set requested an unregistered flag: %s', tostring(name)));
end

--[[
* Sets a flag to its true state.
*
* @param {string} name - The name of the flag to set.
--]]
function flags.set(name)
    for _, v in pairs(flags.flags) do
        if (v.name == string.lower(name)) then
            v.seen = true;
            return;
        end
    end
    error(string.format('set requested an unregistered flag: %s', tostring(name)));
end

--[[
* Asserts that all flags have met their true condition.
--]]
function flags.validate()
    local failed = { };

    for _, v in pairs(flags.flags) do
        if (not v.seen) then
            table.insert(failed, v.name);
        end
    end

    assert(#failed == 0, string.format('failed to validate all flag conditions were met: %s', table.concat(failed, ', ')));
end

-- Return the flags module table..
return flags;