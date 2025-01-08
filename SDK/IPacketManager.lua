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

local ffi   = require 'ffi';
local flags = require 'flags';

--[[
* The main test module table.
--]]
local test = T{};

--[[
* Event called when the addon is processing incoming packets.
*
* @param {object} args - The event arguments.
--]]
local function packet_in_callback(args)
    -- Look for the injected test packets..
    if (args.id == 0x01 and args.injected) then
        local p = {};
        for x = 1, string.len(args.data) do
            p[x] = string.byte(args.data, x);
        end

        -- Check for known test packet data..
        if (p[0x01] == 0x01 and p[0x02] == 0x04 and p[0x05] == 0x13 and p[0x06] == 0x37 and p[0x07] == 0x13 and p[0x08] == 0x37) then
            flags.set('sdktest:packet_in');
            args.blocked = true;
        end
    end
end

--[[
* Event called when the addon is processing outgoing packets.
*
* @param {object} args - The event arguments.
--]]
local function packet_out_callback(args)
    -- Look for the injected test packets..
    if (args.id == 0x01) then
        local p = {};
        for x = 1, string.len(args.data) do
            p[x] = string.byte(args.data, x);
        end

        -- Check for known test packet data.. (AddOutgoingPacket)
        if (args.injected and (p[0x01] == 0x01 and p[0x02] == 0x04 and p[0x05] == 0x13 and p[0x06] == 0x37 and p[0x07] == 0x13 and p[0x08] == 0x37)) then
            flags.set('sdktest:packet_out');
            args.blocked = true;
        end

        -- Check for known test packet data.. (QueuePacket)
        if (not args.injected and (p[0x01] == 0x01 and p[0x02] == 0x04 and p[0x05] == 0xDE and p[0x06] == 0xAD and p[0x07] == 0xBE and p[0x08] == 0xEF)) then
            flags.set('sdktest:packet_out_queued');
            args.blocked = true;
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
    local packetManager = AshitaCore:GetPacketManager();
    assert(packetManager ~= nil, 'GetPacketManager returned an unexpected value.');

    -- Test injecting packets..
    packetManager:AddIncomingPacket(0x01, { 0x01, 0x04, 0x00, 0x00, 0x13, 0x37, 0x13, 0x37 });
    packetManager:AddOutgoingPacket(0x01, { 0x01, 0x04, 0x00, 0x00, 0x13, 0x37, 0x13, 0x37 });

    -- Test injecting an outgoing packet using the games actual packet queue functions..
    packetManager:QueuePacket(0x01, 0x08, 0x00, 0x00, 0x00, function (ptr)
        -- Use FFI to write to the packets buffer..
        local p = ffi.cast('uint8_t*', ptr);
        p[0x04] = 0xDE;
        p[0x05] = 0xAD;
        p[0x06] = 0xBE;
        p[0x07] = 0xEF;
    end);

    -- Give tests time to complete and be processed by the client..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IPacketManager\30\81' \30\106waiting 2 seconds to allow packets to send..\30\01");
    coroutine.sleep(2);
end

-- Return the test module table..
return test;