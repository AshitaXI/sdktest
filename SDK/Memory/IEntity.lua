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
* Initializes the test, preparing it for usage.
--]]
function test.init()
end

--[[
* Executes the test.
--]]
function test.exec()
    --[[
    There is no real / safe way to test these as we cannot guarantee pretty much any of the data.

    Entity information is not guaranteed and can be completely different for the same entity for
    various reasons. Because of this we can't do much testing here. We'll do some basic calls,
    just to see if anything fails.
    --]]

    -- Validate the manager object..
    local memManager = AshitaCore:GetMemoryManager();
    assert(memManager ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the entity object..
    local entity = memManager:GetEntity();
    assert(entity ~= nil, 'GetEntity returned an unexpected value.');

    -- Get the player entity.. (Using global helper.)
    local p = GetPlayerEntity();
    assert(p ~= nil, 'GetPlayerEntity returned an unexpected value.');

    -- Get the player entity.. (Using global helper.)
    local e = GetEntity(p.TargetIndex);
    assert(e ~= nil, 'GetEntity returned an unexpected value.');
    assert(p.TargetIndex == e.TargetIndex, 'unexpected target index found between entities.');

    -- Get the player entity..
    e = entity:GetRawEntity(p.TargetIndex);
    assert(e ~= nil, 'GetRawEntity returned an unexpected value.');
    assert(p.TargetIndex == e.TargetIndex, 'unexpected target index found between entities.');

    -- Call every 'Get' method available against our entity, ignoring the returns because we can't test it..
    assert(entity:GetLocalPositionX(e.TargetIndex) ~= nil, 'GetLocalPositionX returned an unexpected value.');
    assert(entity:GetLocalPositionY(e.TargetIndex) ~= nil, 'GetLocalPositionY returned an unexpected value.');
    assert(entity:GetLocalPositionZ(e.TargetIndex) ~= nil, 'GetLocalPositionZ returned an unexpected value.');
    assert(entity:GetLocalPositionRoll(e.TargetIndex) ~= nil, 'GetLocalPositionRoll returned an unexpected value.');
    assert(entity:GetLocalPositionYaw(e.TargetIndex) ~= nil, 'GetLocalPositionYaw returned an unexpected value.');
    assert(entity:GetLocalPositionPitch(e.TargetIndex) ~= nil, 'GetLocalPositionPitch returned an unexpected value.');
    assert(entity:GetLastPositionX(e.TargetIndex) ~= nil, 'GetLastPositionX returned an unexpected value.');
    assert(entity:GetLastPositionY(e.TargetIndex) ~= nil, 'GetLastPositionY returned an unexpected value.');
    assert(entity:GetLastPositionZ(e.TargetIndex) ~= nil, 'GetLastPositionZ returned an unexpected value.');
    assert(entity:GetLastPositionRoll(e.TargetIndex) ~= nil, 'GetLastPositionRoll returned an unexpected value.');
    assert(entity:GetLastPositionYaw(e.TargetIndex) ~= nil, 'GetLastPositionYaw returned an unexpected value.');
    assert(entity:GetLastPositionPitch(e.TargetIndex) ~= nil, 'GetLastPositionPitch returned an unexpected value.');
    assert(entity:GetMoveX(e.TargetIndex) ~= nil, 'GetMoveX returned an unexpected value.');
    assert(entity:GetMoveY(e.TargetIndex) ~= nil, 'GetMoveY returned an unexpected value.');
    assert(entity:GetMoveZ(e.TargetIndex) ~= nil, 'GetMoveZ returned an unexpected value.');
    assert(entity:GetTargetIndex(e.TargetIndex) ~= nil, 'GetTargetIndex returned an unexpected value.');
    assert(entity:GetServerId(e.TargetIndex) ~= nil, 'GetServerId returned an unexpected value.');
    assert(entity:GetName(e.TargetIndex) ~= nil, 'GetName returned an unexpected value.');
    assert(entity:GetMovementSpeed(e.TargetIndex) ~= nil, 'GetMovementSpeed returned an unexpected value.');
    assert(entity:GetAnimationSpeed(e.TargetIndex) ~= nil, 'GetAnimationSpeed returned an unexpected value.');
    assert(entity:GetWarpPointer(e.TargetIndex) ~= nil, 'GetWarpPointer returned an unexpected value.');
    assert(entity:GetAttachment(e.TargetIndex, 0) ~= nil, 'GetAttachment returned an unexpected value.');
    assert(entity:GetEventPointer(e.TargetIndex) ~= nil, 'GetEventPointer returned an unexpected value.');
    assert(entity:GetDistance(e.TargetIndex) ~= nil, 'GetDistance returned an unexpected value.');
    assert(entity:GetHeading(e.TargetIndex) ~= nil, 'GetHeading returned an unexpected value.');
    assert(entity:GetHPPercent(e.TargetIndex) ~= nil, 'GetHPPercent returned an unexpected value.');
    assert(entity:GetType(e.TargetIndex) ~= nil, 'GetType returned an unexpected value.');
    assert(entity:GetRace(e.TargetIndex) ~= nil, 'GetRace returned an unexpected value.');
    assert(entity:GetModelUpdateFlags(e.TargetIndex) ~= nil, 'GetModelUpdateFlags returned an unexpected value.');
    assert(entity:GetLookHair(e.TargetIndex) ~= nil, 'GetLookHair returned an unexpected value.');
    assert(entity:GetLookHead(e.TargetIndex) ~= nil, 'GetLookHead returned an unexpected value.');
    assert(entity:GetLookBody(e.TargetIndex) ~= nil, 'GetLookBody returned an unexpected value.');
    assert(entity:GetLookHands(e.TargetIndex) ~= nil, 'GetLookHands returned an unexpected value.');
    assert(entity:GetLookLegs(e.TargetIndex) ~= nil, 'GetLookLegs returned an unexpected value.');
    assert(entity:GetLookFeet(e.TargetIndex) ~= nil, 'GetLookFeet returned an unexpected value.');
    assert(entity:GetLookMain(e.TargetIndex) ~= nil, 'GetLookMain returned an unexpected value.');
    assert(entity:GetLookSub(e.TargetIndex) ~= nil, 'GetLookSub returned an unexpected value.');
    assert(entity:GetLookRanged(e.TargetIndex) ~= nil, 'GetLookRanged returned an unexpected value.');
    assert(entity:GetActionTimer1(e.TargetIndex) ~= nil, 'GetActionTimer1 returned an unexpected value.');
    assert(entity:GetActionTimer2(e.TargetIndex) ~= nil, 'GetActionTimer2 returned an unexpected value.');
    assert(entity:GetRenderFlags0(e.TargetIndex) ~= nil, 'GetRenderFlags0 returned an unexpected value.');
    assert(entity:GetRenderFlags1(e.TargetIndex) ~= nil, 'GetRenderFlags1 returned an unexpected value.');
    assert(entity:GetRenderFlags2(e.TargetIndex) ~= nil, 'GetRenderFlags2 returned an unexpected value.');
    assert(entity:GetRenderFlags3(e.TargetIndex) ~= nil, 'GetRenderFlags3 returned an unexpected value.');
    assert(entity:GetRenderFlags4(e.TargetIndex) ~= nil, 'GetRenderFlags4 returned an unexpected value.');
    assert(entity:GetRenderFlags5(e.TargetIndex) ~= nil, 'GetRenderFlags5 returned an unexpected value.');
    assert(entity:GetRenderFlags6(e.TargetIndex) ~= nil, 'GetRenderFlags6 returned an unexpected value.');
    assert(entity:GetRenderFlags7(e.TargetIndex) ~= nil, 'GetRenderFlags7 returned an unexpected value.');
    assert(entity:GetPopEffect(e.TargetIndex) ~= nil, 'GetPopEffect returned an unexpected value.');
    assert(entity:GetInteractionTargetIndex(e.TargetIndex) ~= nil, 'GetInteractionTargetIndex returned an unexpected value.');
    assert(entity:GetNpcSpeechFrame(e.TargetIndex) ~= nil, 'GetNpcSpeechFrame returned an unexpected value.');
    assert(entity:GetMovementSpeed2(e.TargetIndex) ~= nil, 'GetMovementSpeed2 returned an unexpected value.');
    assert(entity:GetNpcWalkPosition1(e.TargetIndex) ~= nil, 'GetNpcWalkPosition1 returned an unexpected value.');
    assert(entity:GetNpcWalkPosition2(e.TargetIndex) ~= nil, 'GetNpcWalkPosition2 returned an unexpected value.');
    assert(entity:GetNpcWalkMode(e.TargetIndex) ~= nil, 'GetNpcWalkMode returned an unexpected value.');
    assert(entity:GetCostumeId(e.TargetIndex) ~= nil, 'GetCostumeId returned an unexpected value.');
    assert(entity:GetMou4(e.TargetIndex) ~= nil, 'GetMou4 returned an unexpected value.');
    assert(entity:GetStatusServer(e.TargetIndex) ~= nil, 'GetStatusServer returned an unexpected value.');
    assert(entity:GetStatus(e.TargetIndex) ~= nil, 'GetStatus returned an unexpected value.');
    assert(entity:GetStatusEvent(e.TargetIndex) ~= nil, 'GetStatusEvent returned an unexpected value.');
    assert(entity:GetClaimStatus(e.TargetIndex) ~= nil, 'GetClaimStatus returned an unexpected value.');
    assert(entity:GetAnimation(e.TargetIndex, 0) ~= nil, 'GetAnimation returned an unexpected value.');
    assert(entity:GetAnimationTime(e.TargetIndex) ~= nil, 'GetAnimationTime returned an unexpected value.');
    assert(entity:GetAnimationStep(e.TargetIndex) ~= nil, 'GetAnimationStep returned an unexpected value.');
    assert(entity:GetAnimationPlay(e.TargetIndex) ~= nil, 'GetAnimationPlay returned an unexpected value.');
    assert(entity:GetEmoteTargetIndex(e.TargetIndex) ~= nil, 'GetEmoteTargetIndex returned an unexpected value.');
    assert(entity:GetEmoteId(e.TargetIndex) ~= nil, 'GetEmoteId returned an unexpected value.');
    assert(entity:GetEmoteIdString(e.TargetIndex) ~= nil, 'GetEmoteIdString returned an unexpected value.');
    assert(entity:GetEmoteTargetWarpPointer(e.TargetIndex) ~= nil, 'GetEmoteTargetWarpPointer returned an unexpected value.');
    assert(entity:GetSpawnFlags(e.TargetIndex) ~= nil, 'GetSpawnFlags returned an unexpected value.');
    assert(entity:GetLinkshellColor(e.TargetIndex) ~= nil, 'GetLinkshellColor returned an unexpected value.');
    assert(entity:GetNameColor(e.TargetIndex) ~= nil, 'GetNameColor returned an unexpected value.');
    assert(entity:GetCampaignNameFlag(e.TargetIndex) ~= nil, 'GetCampaignNameFlag returned an unexpected value.');
    assert(entity:GetFishingUnknown0000(e.TargetIndex) ~= nil, 'GetFishingUnknown0000 returned an unexpected value.');
    assert(entity:GetFishingUnknown0001(e.TargetIndex) ~= nil, 'GetFishingUnknown0001 returned an unexpected value.');
    assert(entity:GetFishingActionCountdown(e.TargetIndex) ~= nil, 'GetFishingActionCountdown returned an unexpected value.');
    assert(entity:GetFishingRodCastTime(e.TargetIndex) ~= nil, 'GetFishingRodCastTime returned an unexpected value.');
    assert(entity:GetFishingUnknown0002(e.TargetIndex) ~= nil, 'GetFishingUnknown0002 returned an unexpected value.');
    assert(entity:GetTargetedIndex(e.TargetIndex) ~= nil, 'GetTargetedIndex returned an unexpected value.');
    assert(entity:GetPetTargetIndex(e.TargetIndex) ~= nil, 'GetPetTargetIndex returned an unexpected value.');
    assert(entity:GetBallistaFlags(e.TargetIndex) ~= nil, 'GetBallistaFlags returned an unexpected value.');
    assert(entity:GetPankrationEnabled(e.TargetIndex) ~= nil, 'GetPankrationEnabled returned an unexpected value.');
    assert(entity:GetPankrationFlagFlip(e.TargetIndex) ~= nil, 'GetPankrationFlagFlip returned an unexpected value.');
    assert(entity:GetModelSize(e.TargetIndex) ~= nil, 'GetModelSize returned an unexpected value.');
    assert(entity:GetMonstrosityFlag(e.TargetIndex) ~= nil, 'GetMonstrosityFlag returned an unexpected value.');
    assert(entity:GetMonstrosityNameId(e.TargetIndex) ~= nil, 'GetMonstrosityNameId returned an unexpected value.');
    assert(entity:GetMonstrosityName(e.TargetIndex) ~= nil, 'GetMonstrosityName returned an unexpected value.');
    assert(entity:GetMonstrosityNameAbbr(e.TargetIndex) ~= nil, 'GetMonstrosityNameAbbr returned an unexpected value.');
    assert(entity:GetFellowTargetIndex(e.TargetIndex) ~= nil, 'GetFellowTargetIndex returned an unexpected value.');
    assert(entity:GetWarpTargetIndex(e.TargetIndex) ~= nil, 'GetWarpTargetIndex returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionX()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionY()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionZ()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionRoll()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionYaw()
    AshitaCore:GetMemoryManager():GetEntity():SetLocalPositionPitch()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionX()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionY()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionZ()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionRoll()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionYaw()
    AshitaCore:GetMemoryManager():GetEntity():SetLastPositionPitch()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveX()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveY()
    AshitaCore:GetMemoryManager():GetEntity():SetMoveZ()
    AshitaCore:GetMemoryManager():GetEntity():SetTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetServerId()
    AshitaCore:GetMemoryManager():GetEntity():SetName()
    AshitaCore:GetMemoryManager():GetEntity():SetMovementSpeed()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationSpeed()
    AshitaCore:GetMemoryManager():GetEntity():SetWarpPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetAttachment()
    AshitaCore:GetMemoryManager():GetEntity():SetEventPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetDistance()
    AshitaCore:GetMemoryManager():GetEntity():SetHeading()
    AshitaCore:GetMemoryManager():GetEntity():SetHPPercent()
    AshitaCore:GetMemoryManager():GetEntity():SetEntityType()
    AshitaCore:GetMemoryManager():GetEntity():SetRace()
    AshitaCore:GetMemoryManager():GetEntity():SetModelUpdateFlags()
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
    AshitaCore:GetMemoryManager():GetEntity():SetPopEffect()
    AshitaCore:GetMemoryManager():GetEntity():SetInteractionTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcSpeechFrame()
    AshitaCore:GetMemoryManager():GetEntity():SetMovementSpeed2()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcWalkPosition1()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcWalkPosition2()
    AshitaCore:GetMemoryManager():GetEntity():SetNpcWalkMode()
    AshitaCore:GetMemoryManager():GetEntity():SetCostumeId()
    AshitaCore:GetMemoryManager():GetEntity():SetMou4()
    AshitaCore:GetMemoryManager():GetEntity():SetStatusServer()
    AshitaCore:GetMemoryManager():GetEntity():SetStatus()
    AshitaCore:GetMemoryManager():GetEntity():SetStatusEvent()
    AshitaCore:GetMemoryManager():GetEntity():SetClaimStatus()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimation()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationTime()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationStep()
    AshitaCore:GetMemoryManager():GetEntity():SetAnimationPlay()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteId()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteIdString()
    AshitaCore:GetMemoryManager():GetEntity():SetEmoteTargetWarpPointer()
    AshitaCore:GetMemoryManager():GetEntity():SetSpawnFlags()
    AshitaCore:GetMemoryManager():GetEntity():SetLinkshellColor()
    AshitaCore:GetMemoryManager():GetEntity():SetNameColor()
    AshitaCore:GetMemoryManager():GetEntity():SetCampaignNameFlag()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingUnknown0000()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingUnknown0001()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingActionCountdown()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingRodCastTime()
    AshitaCore:GetMemoryManager():GetEntity():SetFishingUnknown0002()
    AshitaCore:GetMemoryManager():GetEntity():SetTargetedIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetPetTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetBallistaFlags()
    AshitaCore:GetMemoryManager():GetEntity():SetPankrationEnabled()
    AshitaCore:GetMemoryManager():GetEntity():SetPankrationFlagFlip()
    AshitaCore:GetMemoryManager():GetEntity():SetModelSize()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityFlag()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityNameId()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityName()
    AshitaCore:GetMemoryManager():GetEntity():SetMonstrosityNameAbbr()
    AshitaCore:GetMemoryManager():GetEntity():SetFellowTargetIndex()
    AshitaCore:GetMemoryManager():GetEntity():SetWarpTargetIndex()
        - There is no real decent way to test most of this because every character can have extremely varying data.

--]]