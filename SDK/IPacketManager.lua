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
local ffi   = require 'ffi';
local flags = require 'flags';

--[[
* The main test module table.
--]]
local test = T{
    packets = T{
        incoming    = T{ 0x01, 0x04, 0x00, 0x00, 0x13, 0x37, 0x13, 0x37 },
        outgoing    = T{ 0x01, 0x04, 0x00, 0x00, 0x13, 0x37, 0x13, 0x37 },
        queued      = T{ 0x01, 0x04, 0x00, 0x00, 0xDE, 0xAD, 0xBE, 0xEF },
    },
};

--[[
* Event called when the addon is processing incoming packets.
*
* @param {object} e - The event arguments.
--]]
local function packet_in_callback(e)
    -- Prevent all 0x0001 packets from continuing further..
    if (e.injected and e.id == 0x0001) then
        e.blocked = true;

        if (e.data:sub(0, e.size):bytes():equals(test.packets.incoming)) then
            flags.set('sdktest:packet_in');
        end
    end
end

--[[
* Event called when the addon is processing outgoing packets.
*
* @param {object} e - The event arguments.
--]]
local function packet_out_callback(e)
    -- Prevent all 0x0001 packets from continuing further..
    if (e.id == 0x0001) then
        e.blocked = true;

        -- Packets that are queued using the game functions will have their sync count set..
        local p = e.data:sub(0, e.size):bytes();
        if (not e.injected and (p[3] ~= 0 or p[4] ~= 0)) then
            p[3] = 0;
            p[4] = 0;
        end

        if (p:equals(test.packets.outgoing)) then
            flags.set('sdktest:packet_out');
        end

        if (p:equals(test.packets.queued)) then
            flags.set('sdktest:packet_out_queued');
        end
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = T{
        T{ name = 'sdktest:packet_in',           seen = false },
        T{ name = 'sdktest:packet_out',          seen = false },
        T{ name = 'sdktest:packet_out_queued',   seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('packet_in', 'packet_in_callback', packet_in_callback);
    ashita.events.register('packet_out', 'packet_out_callback', packet_out_callback);
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Unregister event callbacks..
    ashita.events.unregister('packet_in', 'packet_in_callback');
    ashita.events.unregister('packet_out', 'packet_out_callback');

    -- Ensure all flags were seen..
    flags.validate();
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetPacketManager();
    assert(mgr ~= nil, 'GetPacketManager returned an unexpected value.');

    -- Test packet injection..
    mgr:AddIncomingPacket(test.packets.incoming[1], test.packets.incoming);
    mgr:AddOutgoingPacket(test.packets.outgoing[1], test.packets.outgoing);

    -- Test outgoing packet injection using the games actual packet queue functions..
    mgr:QueuePacket(0x01, 0x08, 0x00, 0x00, 0x00, function (ptr)
        local p = ffi.cast('uint8_t*', ptr);
        p[0x04] = 0xDE;
        p[0x05] = 0xAD;
        p[0x06] = 0xBE;
        p[0x07] = 0xEF;
    end);

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IPacketManager\30\81\' ')
        :append(chat.message('Waiting 2 seconds to allow packets to send..')));

    coroutine.sleep(2);
end

-- Return the test module table..
return test;