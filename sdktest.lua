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

addon.name      = 'sdktest';
addon.author    = 'atom0s';
addon.version   = '1.1';
addon.desc      = 'Tests the various bindings of the Ashita SDK.';
addon.link      = 'https://ashitaxi.com/';

require 'common';

--[[
* Table of known tests that are registered to be available.
--]]
local registered_tests = T{
    -- Main Objects
    T{ cmd = '/sdktest ashitacore',             file = 'SDK.IAshitaCore',               desc = 'Tests the IAshitaCore object.' },
    T{ cmd = '/sdktest logmanager',             file = 'SDK.ILogManager',               desc = 'Tests the ILogManager object.' },

    -- Managers
    T{ cmd = '/sdktest chatmanager',            file = 'SDK.IChatManager',              desc = 'Tests the IChatManager object.' },
    T{ cmd = '/sdktest configurationmanager',   file = 'SDK.IConfigurationManager',     desc = 'Tests the IConfigurationManager object.' },
    T{ cmd = '/sdktest fontobjects',            file = 'SDK.IFontObjects',              desc = 'Tests the font and primitive objects.' },
    T{ cmd = '/sdktest guimanager',             file = 'SDK.IGuiManager',               desc = 'Tests the IGuiManager object.' },
    T{ cmd = '/sdktest inputmanager',           file = 'SDK.IInputManager',             desc = 'Tests the IInputManager and related objects.' },
    T{ cmd = '/sdktest offsetmanager',          file = 'SDK.IOffsetManager',            desc = 'Tests the IOffsetManager object.' },
    T{ cmd = '/sdktest packetmanager',          file = 'SDK.IPacketManager',            desc = 'Tests the IPacketManager object.' },
    T{ cmd = '/sdktest pluginmanager',          file = 'SDK.IPluginManager',            desc = 'Tests the IPluginManager object.' },
    T{ cmd = '/sdktest pointermanager',         file = 'SDK.IPointerManager',           desc = 'Tests the IPointerManager object.' },
    T{ cmd = '/sdktest polpluginmanager',       file = 'SDK.IPolPluginManager',         desc = 'Tests the IPolPluginManager object.' },
    T{ cmd = '/sdktest resourcemanager',        file = 'SDK.IResourceManager',          desc = 'Tests the IResourceManager object.' },

    -- Memory Manager and Objects
    T{ cmd = '/sdktest memory autofollow',      file = 'SDK.Memory.IAutoFollow',        desc = 'Tests the IAutoFollow memory object.' },
    T{ cmd = '/sdktest memory castbar',         file = 'SDK.Memory.ICastBar',           desc = 'Tests the ICastBar memory object.' },
    T{ cmd = '/sdktest memory entity',          file = 'SDK.Memory.IEntity',            desc = 'Tests the IEntity memory object.' },
    T{ cmd = '/sdktest memory inventory',       file = 'SDK.Memory.IInventory',         desc = 'Tests the IInventory memory object.' },
    T{ cmd = '/sdktest memory party',           file = 'SDK.Memory.IParty',             desc = 'Tests the IParty memory object.' },
    T{ cmd = '/sdktest memory player',          file = 'SDK.Memory.IPlayer',            desc = 'Tests the IPlayer memory object.' },
    T{ cmd = '/sdktest memory recast',          file = 'SDK.Memory.IRecast',            desc = 'Tests the IRecast memory object.' },
    T{ cmd = '/sdktest memory target',          file = 'SDK.Memory.ITarget',            desc = 'Tests the ITarget memory object.' },
};

--[[
* Counter used to help with potential race conditions if tests are spammed.
--]]
local test_counter = 0;

--[[
* Condition helper that will return the given true (t) or false (f) value based on the condition.
*
* @param {bool} c - The condition to check.
* @Param {any} t - The value to return if the condition is true.
* @Param {any} f - The value to return if the condition is true.
* @return {any} The condition based return.
--]]
local function fif(condition, t, f)
    if (condition) then
        return t;
    end
    return f;
end

--[[
* Executes the given test entry.
*
* @param {table} test - The test entry from the 'registered_tests' table.
* @param {number} cnt - An incremented counter to help prevent race-conditions when executing tests.
* @return {bool} True on success, false otherwise.
--]]
local function run_test(test, cnt)
    -- Remove the preload state of the test and test flags helper..
    package.loaded[test.file] = nil;
    package.loaded['flags'] = nil;

    -- Require the test file..
    local m = nil;
    local res, err = pcall(function ()
        m = require(test.file);

        -- Validate the test files return..
        assert(type(m) == 'table', 'test file returned an unexpected value.');
        assert(m.init ~= nil, 'test is missing expected \'init\' function.');
        assert(m.exec ~= nil, 'test is missing expected \'exec\' function.');
        assert(m.cleanup ~= nil, 'test is missing expected \'cleanup\' function.');
    end);

    if (m == nil) then
        print('\30\81[\30\06SDKTest\30\81] \30\106Error: \30\76Test file failed to load properly.\30\01');
        return false;
    end

    -- Execute the test..
    if (res) then
        local errors = T{};

        -- Initialize the test..
        res, err = pcall(function ()
            m.init(cnt);
        end);

        -- Store the error if one is present..
        if (not res) then
            table.insert(errors, err);
        end

        -- Execute the test..
        if (res) then
            res, err = pcall(function ()
                m.exec(cnt);
            end);

            -- Store the error if one is present..
            if (not res) then
                table.insert(errors, err);
            end
        end

        -- Cleanup the test..
        res, err = pcall(function ()
            m.cleanup(cnt);
        end);

        -- Store the error if one is present..
        if (not res) then
            table.insert(errors, err);
        end

        -- Display the test results..
        res = fif(#errors == 0, '\30\02Ok!', '\30\76Error!');
        print(('\30\81[\30\06SDKTest\30\81] \30\106Tests for \30\81\'\30\06%s\30\81\' \30\106completed: %s\30\01'):fmt(test.file:sub(5, -1), res));

        -- Display errors if any are present..
        errors:each(function (v)
            print(('\30\81[\30\06SDKTest\30\81] \30\106Error: \30\76%s\30\01'):fmt(v));
        end);

        return #errors == 0;
    end

    -- Failed to require and validate the test file..
    print(('\30\81[\30\06SDKTest\30\81] \30\106Error: \30\76%s\30\01'):fmt(err));
    return false;
end

--[[
* Event called when the addon is being loaded.
--]]
ashita.events.register('load', 'sdktest_main_load', function ()
    -- Display the about info..
    print('\30\81[\30\06SDKTest\30\81] \30\71---------------------------------------------------------------------------\30\01');
    print('\30\81[\30\06SDKTest\30\81] \30\106Welcome to the Ashita SDK Lua Binding Test Addon!\30\01');
    print('\30\81[\30\06SDKTest\30\81] \30\71---------------------------------------------------------------------------\30\01');
    print('\30\81[\30\06SDKTest\30\81] \30\106This addon is used to test and validate the various Lua bindings.\30\01');
    print('\30\81[\30\06SDKTest\30\81] \30\106Feel free to browse the source and learn how to make use of Ashita\'s SDK from Lua!\30\01');
    print('\30\81[\30\06SDKTest\30\81] \30\71---------------------------------------------------------------------------\30\01');

    -- Display the command usage..
    print('\30\81[\30\06SDKTest\30\81] \30\106The following commands are valid to execute a test:\30\01');
    registered_tests:each(function (v)
        print(('\30\81[\30\06SDKTest\30\81] \30\106Command: \30\02%s\30\106 - \30\03%s\03\01'):fmt(v.cmd, v.desc));
    end);
    print(('\30\81[\30\06SDKTest\30\81] \30\106Command: \30\02%s\30\106 - \30\03%s\03\01'):fmt('/sdktest all', 'Runs all tests.'));
end);

--[[
* Event called when the addon is processing a command.
*
* @param {table} args - The command arguments table.
--]]
ashita.events.register('command', 'sdktest_main_command', function (args)
    -- Execute a specific test..
    for _, v in pairs(registered_tests) do
        if (v.cmd:ieq(args.command)) then
            -- Mark the command as handled..
            args.blocked = true;

            -- Step the test counter..
            test_counter = test_counter + 1;

            -- Run the test..
            run_test(v, test_counter);
            return;
        end
    end

    -- Execute all tests..
    if (args.command:ieq('/sdktest all')) then
        -- Mark the command as handled..
        args.blocked = true;

        for _, v in pairs(registered_tests) do
            -- Step the test counter..
            test_counter = test_counter + 1;

            -- Run the test..
            if (not run_test(v, test_counter)) then
                return;
            end
        end

        print('\30\81[\30\06SDKTest\30\81] \30\106All tests completed!\30\01');
        return;
    end
end);