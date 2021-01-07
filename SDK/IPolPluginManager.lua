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
    if (args.name == 'sdktest_polplugin_event_test') then
        flags.set('sdktest:polplugin_event');
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = {
        { name = 'sdktest:polplugin_event', seen = false },
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
    local ppluginManager = AshitaCore:GetPolPluginManager();
    assert(ppluginManager ~= nil, 'GetPolPluginManager returned an unexpected value.');

    --[[
    Test POL plugin manager..

    Note:   Since there is no means of guaranteeing the user will have a specific POL plugin loaded, we cannot thoroughly
            test things. Instead, we will look for at least one plugin and check its data is at least accessible.
    --]]

    -- Test if any POL plugins are loaded..
    local c = ppluginManager:Count();
    if (c == 0) then
        return;
    end

    -- Test requesting a POL plugin.. (by index)
    local p = ppluginManager:Get(0);
    assert(p ~= nil, 'Get returned an unexpected value.');

    -- Test requesting the POL plugin properties..
    local n = p:GetName();
    local a = p:GetAuthor();
    local d = p:GetDescription();
    local l = p:GetLink();
    local v = p:GetVersion();
    local i = p:GetInterfaceVersion();
    local f = p:GetFlags();

    assert(n ~= nil, 'GetName returned an unexpected value.');
    assert(a ~= nil, 'GetAuthor returned an unexpected value.');
    assert(d ~= nil, 'GetDescription returned an unexpected value.');
    assert(l ~= nil, 'GetLink returned an unexpected value.');
    assert(v ~= nil, 'GetVersion returned an unexpected value.');
    assert(i ~= nil, 'GetInterfaceVersion returned an unexpected value.');
    assert(f ~= nil, 'GetFlags returned an unexpected value.');

    -- Test raising a plugin event..
    ppluginManager:RaiseEvent('sdktest_polplugin_event_test', { 0x13, 0x37 });

    -- Give tests time to complete and be processed by the client..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IPolPluginManager\30\81' \30\106waiting 2 seconds to allow events to send..\30\01");
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