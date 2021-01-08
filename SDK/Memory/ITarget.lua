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

--[[
* The main test module table.
--]]
local test = { };

--[[
* Calculates the expected target hash used for internal client target validation.
*
* @param {number} idx - The target structure stack index.
* @param {number} sid - The targets server id.
* @param {number} tidx - The targets index.
* @return {number} The calculated target hash.
--]]
local function calculate_target_hash(idx, sid, tidx)
    local ptr = AshitaCore:GetPointerManager():Get('target.target');
    local off = AshitaCore:GetOffsetManager():Get('target.target', 'offset1');

    -- Prepare the pointer address used for the hash calculation..
    ptr = ashita.memory.read_uint32(ptr);
    ptr = ashita.memory.read_uint32(ptr + off);
    ptr = ptr + (idx * 0x28);

    -- Calculate and return the target hash..
    return bit.band((bit.rshift(ptr, 0x03) + (sid * 0x02)) + (tidx * 0x03), 0x0000FFFF);
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local memManager = AshitaCore:GetMemoryManager();
    assert(memManager ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the target object..
    local target = memManager:GetTarget();
    assert(target ~= nil, 'GetTarget returned an unexpected value.');

    -- Validate the raw target object..
    local t = target:GetRawStructure();
    assert(t ~= nil, 'GetRawStructure returned an unexpected value.');

    --[[
    Test setting and validating the players target..
    --]]

    -- Unset the players target..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06Memory.ITarget\30\81' \30\106Please be sure to not touch any controls while test is running!\30\01");
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06Memory.ITarget\30\81' \30\106Please be outside of a mog house while running this test!\30\01");
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06Memory.ITarget\30\81' \30\106Unsetting any current target..\30\01");

    -- Unset the target twice in case the player is currently sub-targetting something..
    coroutine.sleep(1);
    target:SetTarget(0, true);
    coroutine.sleep(1);
    target:SetTarget(0, true);
    coroutine.sleep(1);

    -- Test the target stack with nothing targeted..
    for x = 0, 1 do
        local v = target:GetTargetIndex(x);
        assert(v == 0, 'GetTargetIndex returned an unexpected value.');
        v = target:GetServerId(x);
        assert(v == 0 or v == 0x04000000, 'GetServerId returned an unexpected value.');
        v = target:GetEntityPointer(x);
        assert(v == 0, 'GetEntityPointer returned an unexpected value.');
        v = target:GetWarpPointer(x);
        assert(v == 0, 'GetWarpPointer returned an unexpected value.');
        v = target:GetArrowPositionX(x);
        assert(v == 0, 'GetArrowPositionX returned an unexpected value.');
        v = target:GetArrowPositionY(x);
        assert(v == 0, 'GetArrowPositionY returned an unexpected value.');
        v = target:GetArrowPositionZ(x);
        assert(v == 0, 'GetArrowPositionZ returned an unexpected value.');
        v = target:GetActive(x);
        assert(v == 0, 'GetActive returned an unexpected value.');
        v = target:GetArrowActive(x);
        assert(v == 0, 'GetArrowActive returned an unexpected value.');
        v = target:GetChecksum(x);
        assert(v == 0, 'GetChecksum returned an unexpected value.');
    end

    -- Get the local player entity..
    local p = GetPlayerEntity();
    assert(p ~= nil, 'GetPlayerEntity returned an unexpected value.');

    -- Test targeting the local player..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06Memory.ITarget\30\81' \30\106Targeting the local player..\30\01");
    target:SetTarget(p.TargetIndex, true);
    coroutine.sleep(1);

    -- Test the target information..
    local x = 0;
    local v = target:GetTargetIndex(x);
    assert(v == p.TargetIndex, 'GetTargetIndex returned an unexpected value.');
    v = target:GetServerId(x);
    assert(v == p.ServerId, 'GetServerId returned an unexpected value.');
    v = target:GetEntityPointer(x);
    assert(v ~= 0 and v ~= nil, 'GetEntityPointer returned an unexpected value.');
    v = target:GetWarpPointer(x);
    assert(v == p.WarpPointer, 'GetWarpPointer returned an unexpected value.');
    v = target:GetArrowPositionX(x);
    assert(v == 0, 'GetArrowPositionX returned an unexpected value.');
    v = target:GetArrowPositionY(x);
    assert(v == 0, 'GetArrowPositionY returned an unexpected value.');
    v = target:GetArrowPositionZ(x);
    assert(v == 0, 'GetArrowPositionZ returned an unexpected value.');
    v = target:GetActive(x);
    assert(v == 1, 'GetActive returned an unexpected value.');
    v = target:GetArrowActive(x);
    assert(v == 0, 'GetArrowActive returned an unexpected value.');
    v = target:GetChecksum(x);
    assert(v ~= 0, 'GetChecksum returned an unexpected value.');
    assert(v == calculate_target_hash(0, p.ServerId, p.TargetIndex), 'GetChecksum returned an unexpected value.');

    -- Test targeting the local player as a sub-target..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06Memory.ITarget\30\81' \30\106Targeting the local player as a sub-target..\30\01");
    AshitaCore:GetChatManager():QueueCommand(1, '/wave <st>');
    coroutine.sleep(2);

    -- Test the target information..
    for x = 0, 1 do
        v = target:GetTargetIndex(x);
        assert(v == p.TargetIndex, 'GetTargetIndex returned an unexpected value.');
        v = target:GetServerId(x);
        assert(v == p.ServerId, 'GetServerId returned an unexpected value.');
        v = target:GetEntityPointer(x);
        assert(v ~= 0 and v ~= nil, 'GetEntityPointer returned an unexpected value.');
        v = target:GetWarpPointer(x);
        assert(v == p.WarpPointer, 'GetWarpPointer returned an unexpected value.');
        v = target:GetArrowPositionX(x);
        assert(v == 0, 'GetArrowPositionX returned an unexpected value.');
        v = target:GetArrowPositionY(x);
        assert(v == 0, 'GetArrowPositionY returned an unexpected value.');
        v = target:GetArrowPositionZ(x);
        assert(v == 0, 'GetArrowPositionZ returned an unexpected value.');
        v = target:GetActive(x);
        assert(v == 1, 'GetActive returned an unexpected value.');
        v = target:GetArrowActive(x);
        assert(v == 0, 'GetArrowActive returned an unexpected value.');
        v = target:GetChecksum(x);
        assert(v ~= 0, 'GetChecksum returned an unexpected value.');
        assert(v == calculate_target_hash(x, p.ServerId, p.TargetIndex), 'GetChecksum returned an unexpected value.');
    end

    -- Clear the users target..
    target:SetTarget(0, true);
    coroutine.sleep(1);
    target:SetTarget(0, true);
    coroutine.sleep(1);

    -- Test additional methods..
    v = target:GetIsSubTargetActive();
    assert(v ~= nil, 'GetIsSubTargetActive returned an unexpected value.');
    v = target:GetIsPlayerMoving();
    assert(v ~= nil, 'GetIsPlayerMoving returned an unexpected value.');
    v = target:GetLockedOnFlags();
    assert(v ~= nil, 'GetLockedOnFlags returned an unexpected value.');
    v = target:GetSubTargetFlags();
    assert(v ~= nil, 'GetSubTargetFlags returned an unexpected value.');
    v = target:GetActionTargetActive();
    assert(v ~= nil, 'GetActionTargetActive returned an unexpected value.');
    v = target:GetActionTargetMaxYalms();
    assert(v ~= nil, 'GetActionTargetMaxYalms returned an unexpected value.');
    v = target:GetIsMenuOpen();
    assert(v ~= nil, 'GetIsMenuOpen returned an unexpected value.');
    v = target:GetIsActionAoe();
    assert(v ~= nil, 'GetIsActionAoe returned an unexpected value.');
    v = target:GetActionType();
    assert(v ~= nil, 'GetActionType returned an unexpected value.');
    v = target:GetActionAoeRange();
    assert(v ~= nil, 'GetActionAoeRange returned an unexpected value.');
    v = target:GetActionId();
    assert(v ~= nil, 'GetActionId returned an unexpected value.');
    v = target:GetActionTargetServerId();
    assert(v ~= nil, 'GetActionTargetServerId returned an unexpected value.');
    v = target:GetMouseDistanceX();
    assert(v ~= nil, 'GetMouseDistanceX returned an unexpected value.');
    v = target:GetMouseDistanceY();
    assert(v ~= nil, 'GetMouseDistanceY returned an unexpected value.');

    --[[
    Test the target window..
    --]]

    local win = target:GetRawStructureWindow();
    assert(win ~= nil, 'GetRawStructureWindow returned an unexpected value.');

    -- Test targeting the local player..
    print("\30\81[\30\06SDKTest\30\81] \30\81'\30\06Memory.ITarget\30\81' \30\106Targeting the local player..\30\01");
    target:SetTarget(p.TargetIndex, true);
    coroutine.sleep(2);

    v = target:GetWindowName();
    assert(v == p.Name, 'GetWindowName returned an unexpected value.');
    v = target:GetWindowEntityPointer();
    assert(v ~= nil, 'GetWindowEntityPointer returned an unexpected value.');
    v = target:GetWindowServerId();
    assert(v == p.ServerId, 'GetWindowServerId returned an unexpected value.');
    v = target:GetWindowHPPercent();
    assert(v == p.HPPercent, 'GetWindowHPPercent returned an unexpected value.');
    v = target:GetWindowDeathFlag();
    assert(v ~= nil, 'GetWindowDeathFlag returned an unexpected value.');
    v = target:GetWindowReraiseFlag();
    assert(v ~= nil, 'GetWindowReraiseFlag returned an unexpected value.');
    v = target:GetWindowIsLoaded();
    assert(v == 1, 'GetWindowIsLoaded returned an unexpected value.');

    -- Clear the users target..
    target:SetTarget(0, true);
    coroutine.sleep(1);
    target:SetTarget(0, true);
    coroutine.sleep(1);
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

-- Return the test module table..
return test;