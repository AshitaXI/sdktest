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

--[[
* The main test module table.
--]]
local test = T{
    properties = T{
        'GetLocalPositionX',
        'GetLocalPositionZ',
        'GetLocalPositionY',
        'GetLocalPositionW',
        'GetLocalPositionRoll',
        'GetLocalPositionYaw',
        'GetLocalPositionPitch',
        'GetLastPositionX',
        'GetLastPositionZ',
        'GetLastPositionY',
        'GetLastPositionW',
        'GetLastPositionRoll',
        'GetLastPositionYaw',
        'GetLastPositionPitch',
        'GetMoveX',
        'GetMoveZ',
        'GetMoveY',
        'GetMoveW',
        'GetMoveDeltaX',
        'GetMoveDeltaZ',
        'GetMoveDeltaY',
        'GetMoveDeltaW',
        'GetMoveDeltaRoll',
        'GetMoveDeltaYaw',
        'GetMoveDeltaPitch',
        'GetTargetIndex',
        'GetServerId',
        'GetName',
        'GetMovementSpeed',
        'GetAnimationSpeed',
        'GetActorPointer',
        'GetAttachment',
        'GetEventPointer',
        'GetDistance',
        'GetTurnSpeed',
        'GetTurnSpeedHead',
        'GetHeading',
        'GetNext',
        'GetHPPercent',
        'GetType',
        'GetRace',
        'GetLocalMoveCount',
        'GetActorLockFlag',
        'GetModelUpdateFlags',
        'GetDoorId',
        'GetLookHair',
        'GetLookHead',
        'GetLookBody',
        'GetLookHands',
        'GetLookLegs',
        'GetLookFeet',
        'GetLookMain',
        'GetLookSub',
        'GetLookRanged',
        'GetActionTimer1',
        'GetActionTimer2',
        'GetRenderFlags0',
        'GetRenderFlags1',
        'GetRenderFlags2',
        'GetRenderFlags3',
        'GetRenderFlags4',
        'GetRenderFlags5',
        'GetRenderFlags6',
        'GetRenderFlags7',
        'GetRenderFlags8',
        'GetPopEffect',
        'GetUpdateMask',
        'GetInteractionTargetIndex',
        'GetNpcSpeechFrame',
        'GetLookAxisX',
        'GetLookAxisY',
        'GetMouthCounter',
        'GetMouthWaitCounter',
        'GetCraftTimerUnknown',
        'GetCraftServerId',
        'GetCraftAnimationEffect',
        'GetCraftAnimationStep',
        'GetCraftParam',
        'GetMovementSpeed2',
        'GetNpcWalkPosition1',
        'GetNpcWalkPosition2',
        'GetNpcWalkMode',
        'GetCostumeId',
        'GetMou4',
        'GetStatusServer',
        'GetStatus',
        'GetStatusEvent',
        'GetModelTime',
        'GetModelStartTime',
        'GetClaimStatus',
        'GetZoneId',
        'GetAnimation',
        'GetAnimationTime',
        'GetAnimationStep',
        'GetAnimationPlay',
        'GetEmoteTargetIndex',
        'GetEmoteId',
        'GetEmoteIdString',
        'GetEmoteTargetActorPointer',
        'GetSpawnFlags',
        'GetLinkshellColor',
        'GetNameColor',
        'GetCampaignNameFlag',
        'GetMountId',
        'GetFishingUnknown0000',
        'GetFishingUnknown0001',
        'GetFishingActionCountdown',
        'GetFishingRodCastTime',
        'GetFishingUnknown0002',
        'GetLastActionId',
        'GetLastActionActorPointer',
        'GetTargetedIndex',
        'GetPetTargetIndex',
        'GetUpdateRequestDelay',
        'GetIsDirty',
        'GetBallistaFlags',
        'GetPankrationEnabled',
        'GetPankrationFlagFlip',
        'GetModelSize',
        'GetModelHitboxSize',
        'GetEnvironmentAreaId',
        'GetMonstrosityFlag',
        'GetMonstrosityNameId',
        'GetMonstrosityName',
        'GetMonstrosityNameEnd',
        'GetMonstrosityNameAbbr',
        'GetMonstrosityNameAbbrEnd',
        'GetCustomProperties',
        'GetBallistaInfo',
        'GetFellowTargetIndex',
        'GetWarpTargetIndex',
        'GetTrustOwnerTargetIndex',
        'GetAreaDisplayTargetIndex',
    },
    backups = T{},
};

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

--[[
* Executes the test.
--]]
function test.exec()
    --[[
    Note:   There is no real safe way to test this objects properties as none of the data can be guaranteed. It is
            also not safe to edit some of these values live as it can cause different things to happen that could
            result in a player being banned. Due to this, we will only be testing if we can get values from an entity.
    --]]

    -- Validate the manager object..
    local mgr = AshitaCore:GetMemoryManager();
    assert(mgr ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the entity object..
    local entity = mgr:GetEntity();
    assert(entity ~= nil, 'GetEntity returned an unexpected value.');

    --[[
    Obtaining Entities Testing
    --]]

    -- Test getting the player entity.. (Using global player helper.)
    local player1 = GetPlayerEntity();
    assert(player1 ~= nil, 'GetPlayerEntity returned an unexpected value.');

    -- Test getting the player entity.. (Using global entity helper.)
    local player2 = GetEntity(player1.TargetIndex);
    assert(player2 ~= nil, 'GetEntity returned an unexpected value.');
    assert(player2.TargetIndex == player1.TargetIndex, 'unexpected target index found between entities.');

    -- Test getting the player raw entity.. (Using global entity helper.)
    player2 = entity:GetRawEntity(player1.TargetIndex);
    assert(player2 ~= nil, 'GetRawEntity returned an unexpected value.');
    assert(player2.TargetIndex == player1.TargetIndex, 'unexpected target index found between entities.');

    --[[
    Entity Map Testing
    --]]

    -- Test the entity map size..
    assert(entity:GetEntityMapSize() == 2304, 'GetEntityMapSize returned an unexpected value.');

    --[[
    Entity Property Testing
    --]]

    -- Test that no getters return nil..
    test.properties:each(function (v)
        switch(v, T{
            ['GetAttachment'] = function ()
                table.range(0, 11):each(function (i)
                    assert(entity['GetAttachment'](entity, player1.TargetIndex, i) ~= nil, ('%s returned an unexpected value.'):fmt(v));
                end);
            end,
            ['GetAnimation'] = function ()
                table.range(0, 9):each(function (i)
                    assert(entity['GetAnimation'](entity, player1.TargetIndex, i) ~= nil, ('%s returned an unexpected value.'):fmt(v));
                end);
            end,
            [switch.default] = function ()
                assert(entity[v](entity, player1.TargetIndex) ~= nil, ('%s returned an unexpected value.'):fmt(v));
            end,
        });
    end);
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionX()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionZ()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionY()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionW()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionRoll()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionYaw()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionPitch()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionX()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionZ()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionY()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionW()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionRoll()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionYaw()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionPitch()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveX()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveZ()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveY()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveW()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaX()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaZ()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaY()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaW()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaRoll()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaYaw()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveDeltaPitch()
    AshitaCore:GetMemoryManager():GetEntity():SetTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetServerId()
    AshitaCore:GetMemoryManager():GetEntity():SetName()
    AshitaCore:GetMemoryManager():GetEntity():SetMovementSpeed()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationSpeed()
    AshitaCore:GetMemoryManager():GetEntity():SetActorPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetAttachment()
    AshitaCore:GetMemoryManager():GetEntity():SetEventPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetDistance()
    AshitaCore:GetMemoryManager():GetEntity():SetTurnSpeed()
    AshitaCore:GetMemoryManager():GetEntity():SetTurnSpeedHead()
    AshitaCore:GetMemoryManager():GetEntity():SetHeading()
    AshitaCore:GetMemoryManager():GetEntity():SetNext()
    AshitaCore:GetMemoryManager():GetEntity():SetHPPercent()
    AshitaCore:GetMemoryManager():GetEntity():SetType()
    AshitaCore:GetMemoryManager():GetEntity():SetRace()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalMoveCount()
    AshitaCore:GetMemoryManager():GetEntity():SetActorLockFlag()
    AshitaCore:GetMemoryManager():GetEntity():SetModelUpdateFlags()
    AshitaCore:GetMemoryManager():GetEntity():SetDoorId()
    AshitaCore:GetMemoryManager():GetEntity():SetLookHair()
    AshitaCore:GetMemoryManager():GetEntity():SetLookHead()
    AshitaCore:GetMemoryManager():GetEntity():SetLookBody()
    AshitaCore:GetMemoryManager():GetEntity():SetLookHands()
    AshitaCore:GetMemoryManager():GetEntity():SetLookLegs()
    AshitaCore:GetMemoryManager():GetEntity():SetLookFeet()
    AshitaCore:GetMemoryManager():GetEntity():SetLookMain()
    AshitaCore:GetMemoryManager():GetEntity():SetLookSub()
    AshitaCore:GetMemoryManager():GetEntity():SetLookRanged()
    AshitaCore:GetMemoryManager():GetEntity():SetActionTimer1()
    AshitaCore:GetMemoryManager():GetEntity():SetActionTimer2()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags0()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags1()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags2()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags3()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags4()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags5()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags6()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags7()
    AshitaCore:GetMemoryManager():GetEntity():SetRenderFlags8()
    AshitaCore:GetMemoryManager():GetEntity():SetPopEffect()
    AshitaCore:GetMemoryManager():GetEntity():SetUpdateMask()
    AshitaCore:GetMemoryManager():GetEntity():SetInteractionTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcSpeechFrame()
    AshitaCore:GetMemoryManager():GetEntity():SetLookAxisX()
    AshitaCore:GetMemoryManager():GetEntity():SetLookAxisY()
    AshitaCore:GetMemoryManager():GetEntity():SetMouthCounter()
    AshitaCore:GetMemoryManager():GetEntity():SetMouthWaitCounter()
    AshitaCore:GetMemoryManager():GetEntity():SetCraftTimerUnknown()
    AshitaCore:GetMemoryManager():GetEntity():SetCraftServerId()
    AshitaCore:GetMemoryManager():GetEntity():SetCraftAnimationEffect()
    AshitaCore:GetMemoryManager():GetEntity():SetCraftAnimationStep()
    AshitaCore:GetMemoryManager():GetEntity():SetCraftParam()
    AshitaCore:GetMemoryManager():GetEntity():SetMovementSpeed2()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcWalkPosition1()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcWalkPosition2()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcWalkMode()
    AshitaCore:GetMemoryManager():GetEntity():SetCostumeId()
    AshitaCore:GetMemoryManager():GetEntity():SetMou4()
    AshitaCore:GetMemoryManager():GetEntity():SetStatusServer()
    AshitaCore:GetMemoryManager():GetEntity():SetStatus()
    AshitaCore:GetMemoryManager():GetEntity():SetStatusEvent()
    AshitaCore:GetMemoryManager():GetEntity():SetModelTime()
    AshitaCore:GetMemoryManager():GetEntity():SetModelStartTime()
    AshitaCore:GetMemoryManager():GetEntity():SetClaimStatus()
    AshitaCore:GetMemoryManager():GetEntity():SetZoneId()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimation()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationTime()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationStep()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationPlay()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteId()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteIdString()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteTargetActorPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetSpawnFlags()
    AshitaCore:GetMemoryManager():GetEntity():SetLinkshellColor()
    AshitaCore:GetMemoryManager():GetEntity():SetNameColor()
    AshitaCore:GetMemoryManager():GetEntity():SetCampaignNameFlag()
    AshitaCore:GetMemoryManager():GetEntity():SetMountId()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingUnknown0000()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingUnknown0001()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingActionCountdown()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingRodCastTime()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingUnknown0002()
    AshitaCore:GetMemoryManager():GetEntity():SetLastActionId()
    AshitaCore:GetMemoryManager():GetEntity():SetLastActionActorPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetTargetedIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetPetTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetUpdateRequestDelay()
    AshitaCore:GetMemoryManager():GetEntity():SetIsDirty()
    AshitaCore:GetMemoryManager():GetEntity():SetBallistaFlags()
    AshitaCore:GetMemoryManager():GetEntity():SetPankrationEnabled()
    AshitaCore:GetMemoryManager():GetEntity():SetPankrationFlagFlip()
    AshitaCore:GetMemoryManager():GetEntity():SetModelSize()
    AshitaCore:GetMemoryManager():GetEntity():SetModelHitboxSize()
    AshitaCore:GetMemoryManager():GetEntity():SetEnvironmentAreaId()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityFlag()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityNameId()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityName()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityNameEnd()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityNameAbbr()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityNameAbbrEnd()
    AshitaCore:GetMemoryManager():GetEntity():SetCustomProperties()
    AshitaCore:GetMemoryManager():GetEntity():SetBallistaInfo()
    AshitaCore:GetMemoryManager():GetEntity():SetFellowTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetWarpTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetTrustOwnerTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetAreaDisplayTargetIndex()
--]]