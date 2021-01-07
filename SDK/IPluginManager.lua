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

local flags = require('flags');

--[[
* The main test module table.
--]]
local test = { };

--[[
* Event called when the addon is processing plugin events.
*
* @param {object} args - The event arguments.
--]]
local function plugin_event_callback(args)
    if (args.name == 'sdktest_plugin_event_test') then
        flags.set('sdktest:plugin_event');
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = {
        { name = 'sdktest:plugin_event', seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('plugin_event', 'plugin_event_callback', plugin_event_callback);
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local pluginManager = AshitaCore:GetPluginManager();
    assert(pluginManager ~= nil, 'GetPluginManager returned an unexpected value.');

    -- Test properties..
    local prev = pluginManager:GetSilentPlugins();
    pluginManager:SetSilentPlugins(true);
    local curr = pluginManager:GetSilentPlugins();
    pluginManager:SetSilentPlugins(prev);

    assert(curr == true, 'GetSilentPlugins returned an unexpected value.');

    -- Test if a plugin is loaded..
    local v = pluginManager:IsLoaded('addons');
    assert(v == true, 'IsLoaded returned an unexpected value.');

    -- Test the plugin load count..
    v = pluginManager:Count();
    assert(v >= 1, 'Count returned an unexpected value.');

    -- Test requesting a plugin..
    local p = pluginManager:Get('addons');
    assert(p ~= nil, 'Get returned an unexpected value.');

    -- Test the plugins properties..
    v = p:GetName();
    assert(v == 'Addons', 'GetName returned an unexpected value.');
    v = p:GetAuthor();
    assert(v == 'Ashita Development Team', 'GetAuthor returned an unexpected value.');
    v = p:GetDescription();
    assert(v == 'Enables Lua-based scripting with the Ashita SDK.', 'GetDescription returned an unexpected value.');
    v = p:GetLink();
    assert(v == 'https://www.ashitaxi.com/', 'GetLink returned an unexpected value.');
    v = p:GetVersion();
    assert(v >= 1.0, 'GetVersion returned an unexpected value.');
    v = p:GetInterfaceVersion();
    assert(v >= 4.0, 'GetInterfaceVersion returned an unexpected value.');
    v = p:GetPriority();
    assert(v == 0, 'GetPriority returned an unexpected value.');
    v = p:GetFlags();
    assert(v == 31, 'GetPriority returned an unexpected value.');

    -- Test raising a plugin event..
    pluginManager:RaiseEvent('sdktest_plugin_event_test', { 0x13, 0x37 });

    -- Give tests time to complete and be processed by the client..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IPluginManager\30\81' \30\106waiting 2 seconds to allow events to send..\30\01");
    coroutine.sleep(2);
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

-- Return the test module table..
return test;

--[[
Test Notes:

    It is not thread-safe to interact with plugins directly, thus most of the plugin system is not exposed to addons.

    Functions such as: Load, Unload, UnloadAll

    Plugin events are also not directly exposed (such as calling a specific plugins HandleCommand event) for the same reason.
    Plugins should create and expose a custom layer that uses the 'plugin_event' event to listen for and respond to events instead.
--]]