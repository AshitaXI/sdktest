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
* Event called when the addon is processing keyboard input. (WNDPROC)
*
* @param {object} e - The event arguments.
--]]
local function key_callback(e)
    -- Look for F9 key presses..
    local isF9      = e.wparam == 0x78;
    local isKeyDown = not (bit.band(e.lparam, bit.lshift(0x8000, 0x10)) == bit.lshift(0x8000, 0x10));

    if (not isF9 or not isKeyDown) then
        return;
    end

    -- Do nothing if the test state isn't ready..
    if (not flags.is_set('sdktest:autofollow_step1')) then
        return;
    end

    -- Block all F9 presses during this testing..
    e.blocked = true;

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
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = T{
        T{ name = 'sdktest:autofollow_step1', seen = false },
        T{ name = 'sdktest:autofollow_step2', seen = false },
        T{ name = 'sdktest:autofollow_step3', seen = false },
        T{ name = 'sdktest:autofollow_step4', seen = false },
        T{ name = 'sdktest:autofollow_step5', seen = false },
        T{ name = 'sdktest:autofollow_step6', seen = false },
        T{ name = 'sdktest:autofollow_step7', seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('key', 'key_callback', key_callback);
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

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetMemoryManager();
    assert(mgr ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the auto follow object..
    local follow = mgr:GetAutoFollow();
    assert(follow ~= nil, 'GetAutoFollow returned an unexpected value.');

    -- Test the first person camera flag..
    local cam = follow:GetIsFirstPersonCamera();
    if (cam == 0) then
        follow:SetIsFirstPersonCamera(1);
        assert(follow:GetIsFirstPersonCamera() == 1, 'GetIsFirstPersonCamera returned an unexpected value.');
    else
        follow:SetIsFirstPersonCamera(0);
        assert(follow:GetIsFirstPersonCamera() == 0, 'GetIsFirstPersonCamera returned an unexpected value.');
    end
    coroutine.sleepf(1);
    assert(follow:GetIsFirstPersonCamera() ~= cam, 'GetIsFirstPersonCamera returned an unexpected value.');
    follow:SetIsFirstPersonCamera(cam);
    coroutine.sleepf(1);

    -- Target the local player entity..
    local player = GetPlayerEntity();
    assert(player ~= nil, 'GetPlayerEntity returned an unexpected value.');
    AshitaCore:GetMemoryManager():GetTarget():SetTarget(player.TargetIndex, false);
    coroutine.sleepf(1);

    -- Test the follow target information..
    assert(follow:GetTargetIndex() == player.TargetIndex, 'GetTargetIndex returned an unexpected value.');
    assert(follow:GetTargetServerId() == player.ServerId, 'GetTargetServerId returned an unexpected value.');

    --[[
    Auto Follow Position Testing
    --]]

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.IAutoFollow\30\81\' ')
        :append(chat.message('The next set of tests will require you to interact with the game client!')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.IAutoFollow\30\81\' ')
        :append(chat.message('Be sure to read the instructions carefully before continuing with the tests!')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.IAutoFollow\30\81\' ')
        :append(chat.message('Stand completely still so that your current position can be recorded. Then press '))
        :append(chat.color1(6, 'F9'))
        :append(chat.message('\' when ready.')));

    -- Wait for the user to press 'F9'..
    flags.set('sdktest:autofollow_step1');
    while (not flags.is_set('sdktest:autofollow_step2')) do
        coroutine.sleepf(5);
    end

    -- Store the players current position..
    local x = player.Movement.LocalPosition.X;
    local z = player.Movement.LocalPosition.Z;
    local y = player.Movement.LocalPosition.Y;

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.IAutoFollow\30\81\' ')
        :append(chat.message('Next, run about 10 yalms forward from your position. in a clear path. Then press '))
        :append(chat.color1(6, 'F9'))
        :append(chat.message('\' when ready.')));

    -- Wait for the user to press 'F9'..
    flags.set('sdktest:autofollow_step3');
    while (not flags.is_set('sdktest:autofollow_step4')) do
        coroutine.sleepf(5);
    end

    -- Run back to the players previous position until we're close to it..
    while (not flags.is_set('sdktest:autofollow_step5')) do
        local delta_x = x - player.Movement.LocalPosition.X;
        local delta_z = z - player.Movement.LocalPosition.Z;
        local delta_y = y - player.Movement.LocalPosition.Y;

        -- Set the auto-follow position delta..
        follow:SetFollowDeltaX(delta_x);
        follow:SetFollowDeltaZ(delta_z);
        follow:SetFollowDeltaY(delta_y);

        -- Start running towards the position..
        follow:SetIsAutoRunning(1);

        -- Test obtaining the current delta information..
        assert(follow:GetFollowDeltaX() ~= nil, 'GetFollowDeltaX returned an unexpected value.');
        assert(follow:GetFollowDeltaZ() ~= nil, 'GetFollowDeltaZ returned an unexpected value.');
        assert(follow:GetFollowDeltaY() ~= nil, 'GetFollowDeltaY returned an unexpected value.');

        -- Test that the player is running..
        assert(follow:GetIsAutoRunning(), 'GetIsAutoRunning returned an unexpected value.')

        coroutine.sleepf(5);

        -- Wait until the player is back near their original position..
        if (math.sqrt(math.pow(delta_x, 2) + math.pow(delta_y, 2) + math.pow(delta_z, 2)) <= 0.4) then
            follow:SetIsAutoRunning(0);
            flags.set('sdktest:autofollow_step5');
        end
    end

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.IAutoFollow\30\81\' ')
        :append(chat.message('Next, stand next to an NPC (within 10 yalms) and target them. Then press '))
        :append(chat.color1(6, 'F9'))
        :append(chat.message('\' when ready.')));

    -- Wait for the user to press 'F9'..
    flags.set('sdktest:autofollow_step6');
    while (not flags.is_set('sdktest:autofollow_step7')) do
        coroutine.sleepf(5);
    end

    -- Test the player has a valid target..
    assert(follow:GetTargetIndex() ~= 0, 'GetTargetIndex returned an unexpected value.');
    assert(follow:GetTargetIndex() ~= player.TargetIndex, 'GetTargetIndex returned an unexpected value.');
    assert(follow:GetTargetServerId() ~= 0, 'GetTargetServerId returned an unexpected value.');
    assert(bit.band(follow:GetTargetServerId(), 0x01000000) == 0x01000000, 'GetTargetServerId returned an unexpected value.');

    -- Test the targeted entity is valid..
    local entity = GetEntity(follow:GetTargetIndex());
    assert(entity ~= nil, 'GetEntity returned an unexpected value.');
    assert(entity.Type ~= 0, 'Entity Type returned an unexpected value.');
    assert(entity.Distance < 10, 'Entity Distance returned an unexpected value.');

    --[[
    Note:   The following is to test the target lock-on feature. This feature only works when the client is not currently
            in first-person view. If they are, then the lock-on flag is not updated by the client. Therefore, we must ensure
            that the player is not in first-person mode when this test is being performed.
    --]]

    -- Ensure the player is not in first person mode for the following tests..
    while (follow:GetIsFirstPersonCamera() == 1) do
        follow:SetIsFirstPersonCamera(0);
        coroutine.sleepf(1);
    end

    -- Test locking onto the target..
    local lock = follow:GetIsCameraLockedOn();
    AshitaCore:GetChatManager():QueueCommand(1, '/lockon');
    coroutine.sleepf(5);
    assert(follow:GetIsCameraLockedOn() ~= lock, 'GetIsCameraLockedOn returned an unexpected value.');
    AshitaCore:GetChatManager():QueueCommand(1, '/lockon');
    coroutine.sleepf(5);
    assert(follow:GetIsCameraLockedOn() == lock, 'GetIsCameraLockedOn returned an unexpected value.');

    -- Ensure we are locked onto the target..
    lock = follow:GetIsCameraLockedOn();
    if (lock == 0) then
        AshitaCore:GetChatManager():QueueCommand(1, '/lockon');
        coroutine.sleepf(5);
        assert(follow:GetIsCameraLockedOn() == 1, 'GetIsCameraLockedOn returned an unexpected value.');
    end

    -- Follow the target..
    AshitaCore:GetChatManager():QueueCommand(1, '/follow');
    coroutine.sleepf(5);

    assert(follow:GetFollowTargetIndex() == entity.TargetIndex, 'GetFollowTargetIndex returned an unexpected value.');
    assert(follow:GetFollowTargetServerId() == entity.ServerId, 'GetFollowTargetServerId returned an unexpected value.');

    coroutine.sleepf(5);

    -- Cancel auto-follow and restore the client to normal..
    follow:SetIsAutoRunning(0);
    follow:SetIsFirstPersonCamera(0);
    follow:SetIsCameraLocked(0);
    follow:SetIsCameraLockedOn(0);

    coroutine.sleepf(5);

    -- Ensure we are locked onto the target..
    if (follow:GetIsCameraLockedOn() == 1) then
        AshitaCore:GetChatManager():QueueCommand(1, '/lockon');
        coroutine.sleepf(5);
    end
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetMemoryManager():GetAutoFollow():GetIsCameraLocked()
    AshitaCore:GetMemoryManager():GetAutoFollow():SetIsCameraLocked()
--]]