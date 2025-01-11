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
* Calculates the expected target checksum used for internal client target validation.
*
* @param {number} idx - The target structure stack index.
* @param {number} sid - The targets server id.
* @param {number} tidx - The targets index.
* @return {number} The calculated target checksum.
--]]
local function calculate_checksum(idx, sid, tidx)
    local ptr = ashita.memory.read_uint32(AshitaCore:GetPointerManager():Get('target.target'));
    if (ptr == 0) then return 0; end
    ptr = ashita.memory.read_uint32(ptr + AshitaCore:GetOffsetManager():Get('target.target', 'offset1'));
    if (ptr == 0) then return 0; end
    return bit.band((bit.rshift(ptr + (idx * 0x28), 0x03) + (sid * 0x02)) + (tidx * 0x03), 0x0000FFFF);
end

--[[
* Event called when the addon is processing keyboard input. (WNDPROC)
*
* @param {object} e - The event arguments.
--]]
local function key_callback(e)
    local isF9      = e.wparam == 0x78;
    local isKeyDown = not (bit.band(e.lparam, bit.lshift(0x8000, 0x10)) == bit.lshift(0x8000, 0x10));

    if (not isF9 or not isKeyDown) then
        return;
    end

    if (flags.is_set('sdktest:target_state_1') and not flags.is_set('sdktest:target_state_2')) then
        flags.set('sdktest:target_state_2');
        e.blocked = true;
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = T{
        T{ name = 'sdktest:target_state_1', seen = false },
        T{ name = 'sdktest:target_state_2', seen = false },
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

    -- Validate the target object..
    local target = mgr:GetTarget();
    assert(target ~= nil, 'GetTarget returned an unexpected value.');

    -- Validate the raw target object..
    local raw = target:GetRawStructure();
    assert(raw ~= nil, 'GetRawStructure returned an unexpected value.');

    -- Validate the raw target window object..
    local win = target:GetRawStructureWindow();
    assert(win ~= nil, 'GetRawStructureWindow returned an unexpected value.');

    -- Test the raw target structure fields..
    assert(raw.Targets ~= nil, 'Targets returned an unexpected value.');
    assert(#raw.Targets == 2, 'Targets returned an unexpected value.');
    for x = 1, 2 do
        assert(raw.Targets[x].Index, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ServerId, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].EntityPointer, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ActorPointer, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ArrowPosition, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ArrowPosition.X, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ArrowPosition.Z, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ArrowPosition.Y, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].ArrowPosition.W, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].IsActive, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].IsModelActor, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].IsArrowActive, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].Unknown0000, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].Checksum, 'GetRawStructure returned an unexpected value.');
        assert(raw.Targets[x].Unknown0001, 'GetRawStructure returned an unexpected value.');
    end
    assert(raw.IsWalk ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsAutoNotice ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsSubTargetActive ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.DeactivateTarget ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ModeChangeLock ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsMouseRequestStack ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsMouseRequestCancel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsPlayerMoving ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0001 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0002 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0003 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.LockedOnFlags ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.SubTargetFlags ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0004 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.DefaultMode ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MenuTargetLock ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionTargetActive ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionTargetMaxYalms ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0005 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0006 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0007 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0008 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0009 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0010 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsMenuOpen ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsActionAoe ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionType ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionAoeRange ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionId ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionTargetServerId ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0011 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0012 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0013 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.FocusTargetIndex ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.FocusTargetServerId ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.TargetPosF ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.TargetPosF == 4, 'GetRawStructure returned an unexpected value.');
    assert(raw.LastTargetName ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Padding0000 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.LastTargetIndex ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.LastTargetServerId ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.LastTargetChecksum ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionCallback ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.CancelCallback ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MyroomCallback ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ActionAoeCallback ~= nil, 'GetRawStructure returned an unexpected value.');

    -- Test the raw target window structure fields..
    assert(win.VTablePointer ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_BaseObj ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_pParentMCD ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_InputEnable ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Unknown0000 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_SaveCursol ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_Reposition ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Unknown0001 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Name ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Padding0000 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.EntityPointer ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.FrameChildrenOffsetX ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.FrameChildrenOffsetY ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.IconPositionX ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.IconPositionY ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.FrameOffsetX ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.FrameOffsetY ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Unknown0002 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.LockShape ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.ServerId ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.HPPercent ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.DeathFlag ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.ReraiseFlag ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Padding0001 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.DeathNameColor ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.IsWindowLoaded ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Padding0002 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.HelpString ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.HelpTitle ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_pAnkShape ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_Sub ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Unknown0003 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_AnkNum ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.Unknown0004 ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_AnkX ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_AnkY ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_SubAnkX ~= nil, 'GetRawStructureWindow returned an unexpected value.');
    assert(win.m_SubAnkY ~= nil, 'GetRawStructureWindow returned an unexpected value.');

    --[[
    Function Testing
    --]]

    for x = 0, 1 do
        assert(target:GetTargetIndex(x) ~= nil, 'GetTargetIndex returned an unexpected value.');
        assert(target:GetServerId(x) ~= nil, 'GetServerId returned an unexpected value.');
        assert(target:GetEntityPointer(x) ~= nil, 'GetEntityPointer returned an unexpected value.');
        assert(target:GetActorPointer(x) ~= nil, 'GetActorPointer returned an unexpected value.');
        assert(target:GetArrowPositionX(x) ~= nil, 'GetArrowPositionX returned an unexpected value.');
        assert(target:GetArrowPositionZ(x) ~= nil, 'GetArrowPositionZ returned an unexpected value.');
        assert(target:GetArrowPositionY(x) ~= nil, 'GetArrowPositionY returned an unexpected value.');
        assert(target:GetArrowPositionW(x) ~= nil, 'GetArrowPositionW returned an unexpected value.');
        assert(target:GetIsActive(x) ~= nil, 'GetIsActive returned an unexpected value.');
        assert(target:GetIsModelActor(x) ~= nil, 'GetIsModelActor returned an unexpected value.');
        assert(target:GetIsArrowActive(x) ~= nil, 'GetIsArrowActive returned an unexpected value.');
        assert(target:GetChecksum(x) ~= nil, 'GetChecksum returned an unexpected value.');
    end

    assert(target:GetIsWalk() ~= nil, ':GetIsWalk returned an unexpected value.');
    assert(target:GetIsAutoNotice() ~= nil, 'GetIsAutoNotice returned an unexpected value.');
    assert(target:GetIsSubTargetActive() ~= nil, 'GetIsSubTargetActive returned an unexpected value.');
    assert(target:GetDeactivateTarget() ~= nil, 'GetDeactivateTarget returned an unexpected value.');
    assert(target:GetModeChangeLock() ~= nil, 'GetModeChangeLock returned an unexpected value.');
    assert(target:GetIsMouseRequestStack() ~= nil, 'GetIsMouseRequestStack returned an unexpected value.');
    assert(target:GetIsMouseRequestCancel() ~= nil, 'GetIsMouseRequestCancel returned an unexpected value.');
    assert(target:GetIsPlayerMoving() ~= nil, 'GetIsPlayerMoving returned an unexpected value.');
    assert(target:GetLockedOnFlags() ~= nil, 'GetLockedOnFlags returned an unexpected value.');
    assert(target:GetSubTargetFlags() ~= nil, 'GetSubTargetFlags returned an unexpected value.');
    assert(target:GetDefaultMode() ~= nil, 'GetDefaultMode returned an unexpected value.');
    assert(target:GetMenuTargetLock() ~= nil, 'GetMenuTargetLock returned an unexpected value.');
    assert(target:GetActionTargetActive() ~= nil, 'GetActionTargetActive returned an unexpected value.');
    assert(target:GetActionTargetMaxYalms() ~= nil, 'GetActionTargetMaxYalms returned an unexpected value.');
    assert(target:GetIsMenuOpen() ~= nil, 'GetIsMenuOpen returned an unexpected value.');
    assert(target:GetIsActionAoe() ~= nil, 'GetIsActionAoe returned an unexpected value.');
    assert(target:GetActionType() ~= nil, 'GetActionType returned an unexpected value.');
    assert(target:GetActionAoeRange() ~= nil, 'GetActionAoeRange returned an unexpected value.');
    assert(target:GetActionId() ~= nil, 'GetActionId returned an unexpected value.');
    assert(target:GetActionTargetServerId() ~= nil, 'GetActionTargetServerId returned an unexpected value.');
    assert(target:GetFocusTargetIndex() ~= nil, 'GetFocusTargetIndex returned an unexpected value.');
    assert(target:GetFocusTargetServerId() ~= nil, 'GetFocusTargetServerId returned an unexpected value.');
    assert(target:GetTargetPosF(0) ~= nil, 'GetTargetPosF returned an unexpected value.');
    assert(target:GetTargetPosF(1) ~= nil, 'GetTargetPosF returned an unexpected value.');
    assert(target:GetTargetPosF(2) ~= nil, 'GetTargetPosF returned an unexpected value.');
    assert(target:GetTargetPosF(3) ~= nil, 'GetTargetPosF returned an unexpected value.');
    assert(target:GetLastTargetName() ~= nil, 'GetLastTargetName returned an unexpected value.');
    assert(target:GetLastTargetIndex() ~= nil, 'GetLastTargetIndex returned an unexpected value.');
    assert(target:GetLastTargetServerId() ~= nil, 'GetLastTargetServerId returned an unexpected value.');
    assert(target:GetLastTargetChecksum() ~= nil, 'GetLastTargetChecksum returned an unexpected value.');
    assert(target:GetActionCallback() ~= nil, 'GetActionCallback returned an unexpected value.');
    assert(target:GetCancelCallback() ~= nil, 'GetCancelCallback returned an unexpected value.');
    assert(target:GetMyroomCallback() ~= nil, 'GetMyroomCallback returned an unexpected value.');
    assert(target:GetActionAoeCallback() ~= nil, 'GetActionAoeCallback returned an unexpected value.');

    assert(target:GetWindowName() ~= nil, 'GetWindowName returned an unexpected value.');
    assert(target:GetWindowEntityPointer() ~= nil, 'GetWindowEntityPointer returned an unexpected value.');
    assert(target:GetWindowFrameChildrenOffsetX() ~= nil, 'GetWindowFrameChildrenOffsetX returned an unexpected value.');
    assert(target:GetWindowFrameChildrenOffsetY() ~= nil, 'GetWindowFrameChildrenOffsetY returned an unexpected value.');
    assert(target:GetWindowIconPositionX() ~= nil, 'GetWindowIconPositionX returned an unexpected value.');
    assert(target:GetWindowIconPositionY() ~= nil, 'GetWindowIconPositionY returned an unexpected value.');
    assert(target:GetWindowFrameOffsetX() ~= nil, 'GetWindowFrameOffsetX returned an unexpected value.');
    assert(target:GetWindowFrameOffsetY() ~= nil, 'GetWindowFrameOffsetY returned an unexpected value.');
    assert(target:GetWindowLockShape() ~= nil, 'GetWindowLockShape returned an unexpected value.');
    assert(target:GetWindowServerId() ~= nil, 'GetWindowServerId returned an unexpected value.');
    assert(target:GetWindowHPPercent() ~= nil, 'GetWindowHPPercent returned an unexpected value.');
    assert(target:GetWindowDeathFlag() ~= nil, 'GetWindowDeathFlag returned an unexpected value.');
    assert(target:GetWindowReraiseFlag() ~= nil, 'GetWindowReraiseFlag returned an unexpected value.');
    assert(target:GetWindowDeathNameColor() ~= nil, 'GetWindowDeathNameColor returned an unexpected value.');
    assert(target:GetWindowIsWindowLoaded() ~= nil, 'GetWindowIsWindowLoaded returned an unexpected value.');
    assert(target:GetWindowHelpString() ~= nil, 'GetWindowHelpString returned an unexpected value.');
    assert(target:GetWindowHelpTitle() ~= nil, 'GetWindowHelpTitle returned an unexpected value.');
    for x = 0, 15 do
        assert(target:GetWindowAnkShape(x) ~= nil, 'GetWindowAnkShape returned an unexpected value.');
    end
    assert(target:GetWindowSub() ~= nil, 'GetWindowSub returned an unexpected value.');
    assert(target:GetWindowAnkNum() ~= nil, 'GetWindowAnkNum returned an unexpected value.');
    assert(target:GetWindowAnkX() ~= nil, 'GetWindowAnkX returned an unexpected value.');
    assert(target:GetWindowAnkY() ~= nil, 'GetWindowAnkY returned an unexpected value.');
    assert(target:GetWindowSubAnkX() ~= nil, 'GetWindowSubAnkX returned an unexpected value.');
    assert(target:GetWindowSubAnkY() ~= nil, 'GetWindowSubAnkY returned an unexpected value.');

    --[[
    Set Target Testing
    --]]

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.ITarget\30\81\' ')
        :append(chat.message('The next set of tests will require you to be outside of your mog house.')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.ITarget\30\81\' ')
        :append(chat.message('It is also important that you do not touch your controls during these tests!')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.ITarget\30\81\' ')
        :append(chat.message('Please press \''))
        :append(chat.color1(6, 'F9'))
        :append(chat.message('\' when you are ready to continue.')));

    -- Wait for the user to press 'F9'..
    flags.set('sdktest:target_state_1');
    while (not flags.is_set('sdktest:target_state_2')) do
        coroutine.sleepf(5);
    end

    local function clear_targets()
        while (target:GetTargetIndex(0) ~= 0 or target:GetTargetIndex(1) ~= 0) do
            coroutine.sleepf(2);
            target:SetTarget(0, true);
        end
        coroutine.sleepf(2);
    end

    -- Unset the current targets..
    clear_targets();

    -- Test that no targets are currently set..
    assert(target:GetTargetIndex(0) == 0, 'GetTargetIndex returned an unexpected value.');
    assert(target:GetTargetIndex(1) == 0, 'GetTargetIndex returned an unexpected value.');
    assert(target:GetServerId(0) == 0x04000000, 'GetServerId returned an unexpected value.');
    assert(target:GetServerId(1) == 0x04000000, 'GetServerId returned an unexpected value.');
    assert(target:GetEntityPointer(0) == 0, 'GetEntityPointer returned an unexpected value.');
    assert(target:GetEntityPointer(1) == 0, 'GetEntityPointer returned an unexpected value.');
    assert(target:GetChecksum(0) == 0, 'GetChecksum returned an unexpected value.');
    assert(target:GetChecksum(1) == 0, 'GetChecksum returned an unexpected value.');

    -- Obtain the player entity..
    local player = GetPlayerEntity();
    assert(player ~= nil, 'GetPlayerEntity returned an unexpected value.');

    -- Test targeting the local player..
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.ITarget\30\81\' ')
        :append(chat.message('Targeting the local player..')));
    target:SetTarget(player.TargetIndex, true);
    coroutine.sleepf(2);

    -- Test the current target information matches the local player..
    assert(target:GetTargetIndex(0) == player.TargetIndex, 'GetTargetIndex returned an unexpected value.');
    assert(target:GetServerId(0) == player.ServerId, 'GetServerId returned an unexpected value.');
    assert(target:GetEntityPointer(0) ~= nil and target:GetEntityPointer(0) ~= 0, 'GetEntityPointer returned an unexpected value.');
    assert(target:GetActorPointer(0) ~= nil and target:GetActorPointer(0) ~= 0, 'GetActorPointer returned an unexpected value.');
    assert(target:GetIsActive(0) == 1, 'GetIsActive returned an unexpected value.');
    assert(target:GetChecksum(0) == calculate_checksum(0, player.ServerId, player.TargetIndex), 'GetChecksum returned an unexpected value.');

    -- Test targeting the local player as a sub-target..
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.ITarget\30\81\' ')
        :append(chat.message('Targeting the local player as a sub-target..')));
    AshitaCore:GetChatManager():QueueCommand(1, '/wave <st>');
    coroutine.sleepf(2);

    -- Test that the current target and sub-target information matches the local player..
    for x = 0, 1 do
        assert(target:GetTargetIndex(x) == player.TargetIndex, 'GetTargetIndex returned an unexpected value.');
        assert(target:GetServerId(x) == player.ServerId, 'GetServerId returned an unexpected value.');
        assert(target:GetEntityPointer(x) ~= nil and target:GetEntityPointer(x) ~= 0, 'GetEntityPointer returned an unexpected value.');
        assert(target:GetActorPointer(x) ~= nil and target:GetActorPointer(x) ~= 0, 'GetActorPointer returned an unexpected value.');
        assert(target:GetIsActive(x) == 1, 'GetIsActive returned an unexpected value.');
        assert(target:GetChecksum(x) == calculate_checksum(x, player.ServerId, player.TargetIndex), 'GetChecksum returned an unexpected value.');
    end

    -- Unset the current targets..
    clear_targets();

    --[[
    Target Window Testing
    --]]

    -- Test targeting the local player..
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06Memory.ITarget\30\81\' ')
        :append(chat.message('Targeting the local player..')));
    target:SetTarget(player.TargetIndex, true);
    coroutine.sleepf(2);

    assert(target:GetWindowName() == player.Name, 'GetWindowName returned an unexpected value.');
    assert(target:GetWindowServerId() == player.ServerId, 'GetWindowServerId returned an unexpected value.');
    assert(target:GetWindowHPPercent() == player.HPPercent, 'GetWindowHPPercent returned an unexpected value.');

    -- Unset the current targets..
    clear_targets();
end

-- Return the test module table..
return test;