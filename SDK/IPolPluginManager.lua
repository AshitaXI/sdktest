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

local chat  = require 'chat';
local flags = require 'flags';

--[[
* The main test module table.
--]]
local test = T{};

--[[
* Event called when the addon is processing plugin events.
*
* @param {object} e - The event arguments.
--]]
local function plugin_event_callback(e)
    if (e.name == 'sdktest_polplugin_event_test') then
        flags.set('sdktest:polplugin_event');
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = T{
        T{ name = 'sdktest:polplugin_event',    seen = false },
        T{ name = 'sdktest:polplugin_get',      seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('plugin_event', 'plugin_event_callback', plugin_event_callback);
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Unregister event callbacks..
    ashita.events.unregister('plugin_event', 'plugin_event_callback');

    -- Ensure all flags were seen..
    flags.validate();
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetPolPluginManager();
    assert(mgr ~= nil, 'GetPolPluginManager returned an unexpected value.');

    --[[
    Note:   POL plugins are not as common as normal plugins. Due to this, there is no way to guarantee that
            the client has an expected pol plugin loaded to be tested against. Instead, we will check if any
            are loaded and just ensure the first one loaded has functioning as expected.
    --]]

    -- Test if any pol plugins are loaded..
    if (mgr:Count() == 0) then
        print(chat.header('SDKTest')
            :append('\30\81\'\30\06IPolPluginManager\30\81\' ')
            :append(chat.warning('Warning: '))
            :append(chat.message('There are no POL plugins currently loaded; cannot continue testing for them.')));

        return;
    end

    -- Obtain the first loaded plugin..
    local plugin = mgr:Get(0);
    assert(plugin ~= nil, 'Get returned an unexpected value.');

    -- Test the property returns..
    assert(plugin:GetName() ~= nil, 'GetName returned an unexpected value.');
    assert(plugin:GetAuthor() ~= nil, 'GetAuthor returned an unexpected value.');
    assert(plugin:GetDescription() ~= nil, 'GetDescription returned an unexpected value.');
    assert(plugin:GetLink() ~= nil, 'GetLink returned an unexpected value.');
    assert(plugin:GetVersion() ~= nil, 'GetVersion returned an unexpected value.');
    assert(plugin:GetInterfaceVersion() ~= nil, 'GetInterfaceVersion returned an unexpected value.');
    assert(plugin:GetFlags() ~= nil, 'GetFlags returned an unexpected value.');

    -- Test getting plugin by name and index..
    if (table.range(0, mgr:Count()):map(mgr.Get:bind(mgr)):contains(plugin)) then
        flags.set('sdktest:polplugin_get');
    end

    -- Test raising a plugin event..
    mgr:RaiseEvent('sdktest_polplugin_event_test', { 0x13, 0x37 });

    coroutine.sleepf(2);
end

-- Return the test module table..
return test;