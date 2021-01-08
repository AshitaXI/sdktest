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
* Event called when the addon is processing keyboard input. (WNDPROC)
*
* @param {object} args - The event arguments.
--]]
local function key_callback(args)
    -- Do nothing if the test state isn't ready..
    if (not flags.is_set('sdktest:autofollow_step1')) then
        return;
    end

    -- Look for F9 key presses..
    if (args.wparam == 0x78) then
        -- Block the event..
        args.blocked = true;

        -- Part 1: Wait for user to stand still and press F9..
        if (flags.is_set('sdktest:autofollow_step1') and not flags.is_set('sdktest:autofollow_step2')) then
            flags.set('sdktest:autofollow_step2');
            return;
        end

        -- Part 2: Wait for the user to move and press F9..
        if (flags.is_set('sdktest:autofollow_step3') and not flags.is_set('sdktest:autofollow_step4')) then
            flags.set('sdktest:autofollow_step4');
            return;
        end

        -- Part 3: Wait for the user to target an npc and press F9..
        if (flags.is_set('sdktest:autofollow_step6') and not flags.is_set('sdktest:autofollow_step7')) then
            flags.set('sdktest:autofollow_step7');
            return;
        end

        return;
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = {
        { name = 'sdktest:autofollow_step1', seen = false },
        { name = 'sdktest:autofollow_step2', seen = false },
        { name = 'sdktest:autofollow_step3', seen = false },
        { name = 'sdktest:autofollow_step4', seen = false },
        { name = 'sdktest:autofollow_step5', seen = false },
        { name = 'sdktest:autofollow_step6', seen = false },
        { name = 'sdktest:autofollow_step7', seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('key', 'key_callback', key_callback);
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local memManager = AshitaCore:GetMemoryManager();
    assert(memManager ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the auto follow object..
    local follow = memManager:GetAutoFollow();
    assert(follow ~= nil, 'GetAutoFollow returned an unexpected value.');

    -- Toggle the camera..
    local c1 = follow:GetIsFirstPersonCamera();
    if (c1 == 0) then
        follow:SetIsFirstPersonCamera(1);
    else
        follow:SetIsFirstPersonCamera(0);
    end
    coroutine.sleep(1);
    local c2 = follow:GetIsFirstPersonCamera();
    assert(c2 ~= c1, 'GetIsFirstPersonCamera returned an unexpected value.');
    follow:SetIsFirstPersonCamera(c1);
    coroutine.sleep(1);

    -- Target the local player..
    local p = GetPlayerEntity();
    assert(p ~= nil, 'GetPlayerEntity returned an unexpected value.');
    AshitaCore:GetMemoryManager():GetTarget():SetTarget(p.TargetIndex, false);
    coroutine.sleep(2);

    local ti = follow:GetTargetIndex();
    local si = follow:GetTargetServerId();
    assert(p.TargetIndex == ti, 'GetTargetIndex returned an unexpected value.');
    assert(p.ServerId == si, 'GetTargetServerId returned an unexpected value.');

    -- Test positional auto-following..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IAutoFollow\30\81' \30\106To begin testing auto-following; stand still so your position can be recorded..\30\01");
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IAutoFollow\30\81' \30\106Press \30\06F9\30\106 when ready.\30\01");

    -- Set the test state and wait for the user to press F9..
    flags.set('sdktest:autofollow_step1');
    while (not flags.is_set('sdktest:autofollow_step2')) do
        coroutine.sleep(1);
    end

    -- Store the players current position..
    local x = p.Movement.LocalPosition.X;
    local y = p.Movement.LocalPosition.Y;
    local z = p.Movement.LocalPosition.Z;

    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IAutoFollow\30\81' \30\106Next, run away from your previous position about 10 yalms, in a clear path..\30\01");
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IAutoFollow\30\81' \30\106Press \30\06F9\30\106 when ready.\30\01");

    -- Set the test state and wait for the user to press F9..
    flags.set('sdktest:autofollow_step3');
    while (not flags.is_set('sdktest:autofollow_step4')) do
        coroutine.sleep(1);
    end

    -- Run to the previous position until we're close to it..
    while (not flags.is_set('sdktest:autofollow_step5')) do
        -- Calculate the position delta of the players current and previous positions..
        local d_x = x - p.Movement.LocalPosition.X;
        local d_y = y - p.Movement.LocalPosition.Y;
        local d_z = z - p.Movement.LocalPosition.Z;

        -- Update the auto-follow deltas..
        follow:SetFollowDeltaX(d_x);
        follow:SetFollowDeltaY(d_y);
        follow:SetFollowDeltaZ(d_z);
        follow:SetIsAutoRunning(1);

        -- Test we can get the current deltas..
        local f_x = follow:GetFollowDeltaX();
        local f_y = follow:GetFollowDeltaY();
        local f_z = follow:GetFollowDeltaZ();
        assert(f_x ~= nil, 'GetFollowDeltaX returned an unexpected value.');
        assert(f_y ~= nil, 'GetFollowDeltaY returned an unexpected value.');
        assert(f_z ~= nil, 'GetFollowDeltaZ returned an unexpected value.');

        -- Ensure we are running..
        local r = follow:GetIsAutoRunning();
        assert(r == 1, 'GetIsAutoRunning returned an unexpected value.');

        -- Sleep to let the player run some..
        coroutine.sleepf(5);

        -- Check if we're close enough to stop following..
        local dist = math.sqrt(math.pow(d_x, 2) + math.pow(d_z, 2));
        if (dist <= 0.3) then
            -- Stop auto-following..
            follow:SetIsAutoRunning(0);

            -- Set the flag..
            flags.set('sdktest:autofollow_step5');
        end
    end

    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IAutoFollow\30\81' \30\106Next, target and stand next to an NPC.\30\01");
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06IAutoFollow\30\81' \30\106Press \30\06F9\30\106 when ready.\30\01");

    -- Set the test state and wait for the user to press F9..
    flags.set('sdktest:autofollow_step6');
    while (not flags.is_set('sdktest:autofollow_step7')) do
        coroutine.sleep(1);
    end

    -- Validate the players target..
    ti = follow:GetTargetIndex();
    assert(ti ~= 0, 'GetTargetIndex returned an unexpected value.');
    assert(ti ~= p.TargetIndex, 'GetTargetIndex returned an unexpected value.');

    -- Get the target entity..
    local t = GetEntity(ti);
    assert(t ~= nil, 'GetEntity returned an unexpected value.');

    -- Validate the target entity is an npc..
    assert(t.Type ~= 0, 'Type returned an unexpected value.');
    assert(t.Distance < 10, 'Target is too far away, please get closer..');

    -- Lock onto the target if we aren't already..
    local l = follow:GetIsCameraLockedOn();
    if (l == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/lockon');
        coroutine.sleep(1);
    end

    -- Attempt to follow the npc..
    AshitaCore:GetChatManager():QueueCommand(1, '/follow');
    coroutine.sleep(1);

    -- Test that we are following the target..
    ti = follow:GetFollowTargetIndex();
    si = follow:GetFollowTargetServerId();
    assert(ti == t.TargetIndex, 'GetFollowTargetIndex returned an unexpected value.');
    assert(si == t.ServerId, 'GetFollowTargetServerId returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Unregister event callbacks..
    ashita.events.unregister('key', 'key_callback');

    -- Ensure all flags were seen..
    flags.validate();
end

-- Return the test module table..
return test;

--[[
Untested Functions:

--]]