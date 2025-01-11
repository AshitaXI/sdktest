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
    if (e.name == 'sdktest_plugin_event_test') then
        flags.set('sdktest:plugin_event');
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = T{
        T{ name = 'sdktest:plugin_event',   seen = false },
        T{ name = 'sdktest:plugin_get',     seen = false },
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
    local mgr = AshitaCore:GetPluginManager();
    assert(mgr ~= nil, 'GetPluginManager returned an unexpected value.');

    -- Test properties..
    local prev = mgr:GetSilentPlugins();
    mgr:SetSilentPlugins(false);
    assert(mgr:GetSilentPlugins() == false, 'GetSilentPlugins returned an unexpected value.');
    mgr:SetSilentPlugins(true);
    assert(mgr:GetSilentPlugins() == true, 'GetSilentPlugins returned an unexpected value.');
    mgr:SetSilentPlugins(prev);

    -- Test if a plugin is loaded..
    assert(mgr:IsLoaded('addons') == true, 'IsLoaded returned an unexpected value.');

    -- Test the plugin load count..
    assert(mgr:Count() >= 1, 'Count returned an unexpected value.');

    -- Test obtaining a plugin..
    local plugin = mgr:Get('addons');
    assert(plugin ~= nil, 'Get returned an unexpected value.');
    assert(plugin:GetName() == 'Addons', 'GetName returned an unexpected value.');
    assert(plugin:GetAuthor() == 'Ashita Development Team', 'GetAuthor returned an unexpected value.');
    assert(plugin:GetDescription() == 'Enables Lua-based scripting with the Ashita SDK.', 'GetDescription returned an unexpected value.');
    assert(plugin:GetLink() == 'https://www.ashitaxi.com/', 'GetLink returned an unexpected value.');
    assert(plugin:GetVersion() >= 2.4, 'GetVersion returned an unexpected value.');
    assert(plugin:GetInterfaceVersion() >= 4.0, 'GetInterfaceVersion returned an unexpected value.');
    assert(plugin:GetPriority() == 0, 'GetPriority returned an unexpected value.');
    assert(plugin:GetFlags() == 0x1F, 'GetFlags returned an unexpected value.');

    -- Test getting plugin by name and index..
    if (table.range(0, mgr:Count()):map(mgr.Get:bind(mgr)):contains(plugin)) then
        flags.set('sdktest:plugin_get');
    end

    -- Test raising a plugin event..
    mgr:RaiseEvent('sdktest_plugin_event_test', { 0x13, 0x37 });

    coroutine.sleepf(2);
end

-- Return the test module table..
return test;