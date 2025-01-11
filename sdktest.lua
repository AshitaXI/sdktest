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

addon.name      = 'sdktest';
addon.author    = 'atom0s';
addon.version   = '1.1';
addon.desc      = 'Tests the various bindings of the Ashita SDK.';
addon.link      = 'https://ashitaxi.com/';

require 'common';

local chat = require 'chat';

-- sdktest Variables
local sdktest = T{
    test_counter = 0,
    tests = T{
        -- Main Objects
        T{ name = 'ashitacore',             file = 'SDK.IAshitaCore',           desc = 'Tests the IAshitaCore interface.', },
        T{ name = 'logmanager',             file = 'SDK.ILogManager',           desc = 'Tests the ILogManager interface.', },

        -- Manager Objects
        T{ name = 'chatmanager',            file = 'SDK.IChatManager',          desc = 'Tests the IChatManager interface.', },
        T{ name = 'configurationmanager',   file = 'SDK.IConfigurationManager', desc = 'Tests the IConfigurationManager interface.', },
        T{ name = 'fontobjects',            file = 'SDK.IFontObjects',          desc = 'Tests the IFontManager, IFontObject, IPrimitiveManager and IPrimitiveObject interface.', },
        T{ name = 'guimanager',             file = 'SDK.IGuiManager',           desc = 'Tests the IGuiManager interface.', },
        T{ name = 'inputmanager',           file = 'SDK.IInputManager',         desc = 'Tests the IInputManager interface.', },
        T{ name = 'offsetmanager',          file = 'SDK.IOffsetManager',        desc = 'Tests the IOffsetManager interface.', },
        T{ name = 'packetmanager',          file = 'SDK.IPacketManager',        desc = 'Tests the IPacketManager interface.', },
        T{ name = 'pluginmanager',          file = 'SDK.IPluginManager',        desc = 'Tests the IPluginManager interface.', },
        T{ name = 'pointermanager',         file = 'SDK.IPointerManager',       desc = 'Tests the IPointerManager interface.', },
        T{ name = 'polpluginmanager',       file = 'SDK.IPolPluginManager',     desc = 'Tests the IPolPluginManager interface.', },
        T{ name = 'resourcemanager',        file = 'SDK.IResourceManager',      desc = 'Tests the IResourceManager interface.', },

        -- Memory Manager Objects
        T{ name = 'memory autofollow',      file = 'SDK.Memory.IAutoFollow',    desc = 'Tests the IAutoFollow memory interface.', },
        T{ name = 'memory castbar',         file = 'SDK.Memory.ICastBar',       desc = 'Tests the ICastBar memory interface.', },
        T{ name = 'memory entity',          file = 'SDK.Memory.IEntity',        desc = 'Tests the IEntity memory interface.', },
        T{ name = 'memory inventory',       file = 'SDK.Memory.IInventory',     desc = 'Tests the IInventory memory interface.', },
        T{ name = 'memory party',           file = 'SDK.Memory.IParty',         desc = 'Tests the IParty memory interface.', },
        T{ name = 'memory player',          file = 'SDK.Memory.IPlayer',        desc = 'Tests the IPlayer memory interface.', },
        T{ name = 'memory recast',          file = 'SDK.Memory.IRecast',        desc = 'Tests the IRecast memory interface.', },
        T{ name = 'memory target',          file = 'SDK.Memory.ITarget',        desc = 'Tests the ITarget memory interface.', },
    },
};
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
* Executes the given test.
*
* @param {table} t - The test to execute.
* @return {bool} True on success, false otherwise.
--]]
local function run_test(t)
    -- Reset the state of preloaded packages..
    package.loaded[t.file]  = nil;
    package.loaded['flags'] = nil;

    local test = nil;
    local res, err = pcall(function ()
        -- Require the test file..
        test = require(t.file);

        -- Validate the test table..
        assert(type(test) == 'table', 'Test file returned an unexpected value.');
        assert(test.init ~= nil, 'Test file missing required \'init\' function.');
        assert(test.exec ~= nil, 'Test file missing required \'exec\' function.');
        assert(test.cleanup ~= nil, 'Test file missing required \'cleanup\' function.');
    end);

    -- Validate the test file loaded..
    if (test == nil or not res or err ~= nil) then
        print(chat.header('SDKTest'):append(chat.message('Error: ')):append(chat.error('Test file failed to load properly.')));
        if (err) then
            print(chat.header('SDKTest'):append(chat.message('Error: ')):append(chat.error(err)));
        end
        return false;
    end

    local errors = T{};

    -- Execute the test initialization function..
    res, err = pcall(function () test.init(sdktest.test_counter); end);
    if (not res) then errors:append(err); end

    if (res) then
        -- Execute the test..
        res, err = pcall(function () test.exec(sdktest.test_counter); end);
        if (not res) then errors:append(err); end
    end

    -- Execute the test cleanup function..
    res, err = pcall(function () test.cleanup(sdktest.test_counter); end);
    if (not res) then errors:append(err); end

    -- Display the test results..
    res = fif(#errors == 0, chat.success('Ok!'), chat.error('Error!'));
    print(chat.header('SDKTest')
        :append(chat.message('Tests for '))
        :append(chat.color1(81, '\''))
        :append(chat.success(t.name))
        :append(chat.color1(81, '\''))
        :append(chat.message(' completed: '))
        :append(res));

    -- Display the test errors..
    errors:each(function (v)
        print(chat.header('SDKTest')
            :append(chat.error('Error: '))
            :append(chat.error(v)));
    end);

    return #errors == 0;
end

--[[
* event: load
* desc : Event called when the addon is being loaded.
--]]
ashita.events.register('load', 'sdktest_main_load', function ()
    print(chat.header('SDKTest'):append(chat.color1(71, '---------------------------------------------------------------------------')));
    print(chat.header('SDKTest'):append(chat.message('Welcome to the Ashita SDK Lua Binding Test Addon!')));
    print(chat.header('SDKTest'):append(chat.color1(71, '---------------------------------------------------------------------------')));
    print(chat.header('SDKTest'):append(chat.message('This addon is used to test and validate the various Lua bindings.')));
    print(chat.header('SDKTest'):append(chat.message('Feel free to browse the source and learn how to make use of Ashita\'s SDK from Lua!')));
    print(chat.header('SDKTest'):append(chat.color1(71, '---------------------------------------------------------------------------')));
    print(chat.header('SDKTest'):append(chat.message('The following commands are valid to execute a test:')));
    sdktest.tests:each(function (v)
        print(chat.header('SDKTest'):append(chat.message('Command: ')):append(chat.success('/sdktest ' .. v.name)):append(chat.message(' - ')):append(chat.color1(3, v.desc)));
    end);
    print(chat.header('SDKTest'):append(chat.message('Command: ')):append(chat.success('/sdktest all')):append(chat.message(' - ')):append(chat.color1(3, 'Runs all registered tests.')));
end);

--[[
* event: command
* desc : Event called when the addon is processing a command.
--]]
ashita.events.register('command', 'sdktest_main_command', function (e)
    local args = e.command:args();
    if (#args == 0 or args[1] ~= '/sdktest') then
        return;
    end

    e.blocked = true;

    -- Handle: /sdktest all - Runs all registered tests.
    if (#args == 2 and args[2]:any('all')) then
        for _, v in pairs(sdktest.tests) do
            sdktest.test_counter = sdktest.test_counter + 1;
            if (not run_test(v)) then
                return;
            end
        end
        print(chat.header('SDKTest'):append(chat.success('All tests completed!')));
        return;
    end

    -- Handle: /sdktest <test name>
    local cmd = args:slice(2, #args):join(' ');
    local _, v = sdktest.tests:find_if(function (v)
        return v.name:ieq(cmd);
    end);

    if (v == nil) then
        print(chat.header('SDKTest')
            :append(chat.error('Unknown test requested: '))
            :append(chat.message(e.command:sub(10, -1))));
        return;
    end

    sdktest.test_counter = sdktest.test_counter + 1;

    run_test(v);
end);