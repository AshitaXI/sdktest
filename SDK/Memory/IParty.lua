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
    -- Validate the manager object..
    local memManager = AshitaCore:GetMemoryManager();
    assert(memManager ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the party object..
    local party = memManager:GetParty();
    assert(party ~= nil, 'GetParty returned an unexpected value.');

    --[[
    Test the alliance information methods..
    --]]

    local v = party:GetAllianceLeaderServerId();
    assert(v ~= nil, 'GetAllianceLeaderServerId returned an unexpected value.');
    v = party:GetAlliancePartyLeaderServerId1();
    assert(v ~= nil, 'GetAlliancePartyLeaderServerId1 returned an unexpected value.');
    v = party:GetAlliancePartyLeaderServerId2();
    assert(v ~= nil, 'GetAlliancePartyLeaderServerId2 returned an unexpected value.');
    v = party:GetAlliancePartyLeaderServerId3();
    assert(v ~= nil, 'GetAlliancePartyLeaderServerId3 returned an unexpected value.');
    v = party:GetAlliancePartyVisible1();
    assert(v ~= nil, 'GetAlliancePartyVisible1 returned an unexpected value.');
    v = party:GetAlliancePartyVisible2();
    assert(v ~= nil, 'GetAlliancePartyVisible2 returned an unexpected value.');
    v = party:GetAlliancePartyVisible3();
    assert(v ~= nil, 'GetAlliancePartyVisible3 returned an unexpected value.');
    v = party:GetAlliancePartyMemberCount1();
    assert(v ~= nil, 'GetAlliancePartyMemberCount1 returned an unexpected value.');
    v = party:GetAlliancePartyMemberCount2();
    assert(v ~= nil, 'GetAlliancePartyMemberCount2 returned an unexpected value.');
    v = party:GetAlliancePartyMemberCount3();
    assert(v ~= nil, 'GetAlliancePartyMemberCount3 returned an unexpected value.');
    v = party:GetAllianceInvited();
    assert(v ~= nil, 'GetAllianceInvited returned an unexpected value.');

    -- Get the player entity..
    local e = GetPlayerEntity();
    assert(e ~= nil, 'GetPlayerEntity returned an unexpected value.');

    --[[
    Test the party information methods..
    --]]

    v = party:GetMemberIndex(0);
    assert(v ~= nil, 'GetMemberIndex returned an unexpected value.');
    v = party:GetMemberNumber(0);
    assert(v ~= nil, 'GetMemberNumber returned an unexpected value.');
    v = party:GetMemberName(0);
    assert(v ~= nil, 'GetMemberName returned an unexpected value.');
    assert(v == e.Name, 'GetMemberName returned an unexpected value.');
    v = party:GetMemberServerId(0);
    assert(v ~= nil, 'GetMemberServerId returned an unexpected value.');
    assert(v == e.ServerId, 'GetMemberServerId returned an unexpected value.');
    v = party:GetMemberTargetIndex(0);
    assert(v ~= nil, 'GetMemberTargetIndex returned an unexpected value.');
    assert(v == e.TargetIndex, 'GetMemberTargetIndex returned an unexpected value.');
    v = party:GetMemberLastUpdatedTimestamp(0);
    assert(v ~= nil, 'GetMemoryLastUpdatedTimestamp returned an unexpected value.');
    v = party:GetMemberHP(0);
    assert(v ~= nil, 'GetMemberHP returned an unexpected value.');
    v = party:GetMemberMP(0);
    assert(v ~= nil, 'GetMemberMP returned an unexpected value.');
    v = party:GetMemberTP(0);
    assert(v ~= nil, 'GetMemberTP returned an unexpected value.');
    v = party:GetMemberHPPercent(0);
    assert(v ~= nil, 'GetMemberHPPercent returned an unexpected value.');
    v = party:GetMemberMPPercent(0);
    assert(v ~= nil, 'GetMemberMPPercent returned an unexpected value.');
    v = party:GetMemberZone(0);
    assert(v ~= nil, 'GetMemberZone returned an unexpected value.');
    v = party:GetMemberZone2(0);
    assert(v ~= nil, 'GetMemberZone2 returned an unexpected value.');
    v = party:GetMemberFlagMask(0);
    assert(v ~= nil, 'GetMemberFlagMask returned an unexpected value.');
    v = party:GetMemberTreasureLot(0, 0);
    assert(v ~= nil, 'GetMemberTreasureLot returned an unexpected value.');
    v = party:GetMemberMonstrosityItemId(0);
    assert(v ~= nil, 'GetMemberMonstrosityItemId returned an unexpected value.');
    v = party:GetMemberMonstrosityPrefixFlag1(0);
    assert(v ~= nil, 'GetMemberMonstrosityPrefixFlag1 returned an unexpected value.');
    v = party:GetMemberMonstrosityPrefixFlag2(0);
    assert(v ~= nil, 'GetMemberMonstrosityPrefixFlag2 returned an unexpected value.');
    v = party:GetMemberMonstrosityName(0);
    assert(v ~= nil, 'GetMemberMonstrosityName returned an unexpected value.');
    v = party:GetMemberMainJob(0);
    assert(v ~= nil, 'GetMemberMainJob returned an unexpected value.');
    v = party:GetMemberMainJobLevel(0);
    assert(v ~= nil, 'GetMemberMainJobLevel returned an unexpected value.');
    v = party:GetMemberSubJob(0);
    assert(v ~= nil, 'GetMemberSubJob returned an unexpected value.');
    v = party:GetMemberSubJobLevel(0);
    assert(v ~= nil, 'GetMemberSubJobLevel returned an unexpected value.');
    v = party:GetMemberServerId2(0);
    assert(v ~= nil, 'GetMemberServerId2 returned an unexpected value.');
    v = party:GetMemberHPPercent2(0);
    assert(v ~= nil, 'GetMemberHPPercent2 returned an unexpected value.');
    v = party:GetMemberMPPercent2(0);
    assert(v ~= nil, 'GetMemberMPPercent2 returned an unexpected value.');
    v = party:GetMemberIsActive(0);
    assert(v ~= nil, 'GetMemberIsActive returned an unexpected value.');
    assert(v == 1, 'GetMemberIsActive returned an unexpected value.');

    -- Test status icons..
    v = party:GetStatusIconsServerId(0);
    assert(v ~= nil, 'GetStatusIconsServerId returned an unexpected value.');
    v = party:GetStatusIconsTargetIndex(0);
    assert(v ~= nil, 'GetStatusIconsTargetIndex returned an unexpected value.');
    v = party:GetStatusIconsBitMask(0);
    assert(v ~= nil, 'GetStatusIconsBitMask returned an unexpected value.');
    v = party:GetStatusIcons(0);
    assert(v ~= nil, 'GetStatusIcons returned an unexpected value.');
    assert(#v == 32, 'GetStatusIcons returned an unexpected value.');

    --[[
    Test the raw structure..
    --]]

    -- Validate the raw party..
    local p = party:GetRawStructure();
    assert(p ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#p.Members == 18, 'GetRawStructure returned an unexpected value.');

    -- Testing alliance data..
    assert(p.Members[1].AllianceInfo ~= nil, 'AllianceInfo returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.AllianceLeaderServerId ~= nil, 'AllianceLeaderServerId returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyLeaderServerId1 ~= nil, 'PartyLeaderServerId1 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyLeaderServerId2 ~= nil, 'PartyLeaderServerId2 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyLeaderServerId3 ~= nil, 'PartyLeaderServerId3 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyVisible1 ~= nil, 'PartyVisible1 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyVisible2 ~= nil, 'PartyVisible2 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyVisible3 ~= nil, 'PartyVisible3 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyMemberCount1 ~= nil, 'PartyMemberCount1 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyMemberCount1 >= 1, 'PartyMemberCount1 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyMemberCount2 ~= nil, 'PartyMemberCount2 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.PartyMemberCount3 ~= nil, 'PartyMemberCount3 returned an unexpected value.');
    assert(p.Members[1].AllianceInfo.Invited ~= nil, 'Invited returned an unexpected value.');

    -- Testing the local players data..
    assert(p.Members[1].Index ~= nil, 'Index returned an unexpected value.');
    assert(p.Members[1].MemberNumber ~= nil, 'MemberNumber returned an unexpected value.');
    assert(p.Members[1].Name == e.Name, 'Name returned an unexpected value.');
    assert(p.Members[1].ServerId == e.ServerId, 'ServerId returned an unexpected value.');
    assert(p.Members[1].TargetIndex == e.TargetIndex, 'TargetIndex returned an unexpected value.');
    assert(p.Members[1].LastUpdatedTimestamp ~= nil, 'LastUpdatedTimestamp returned an unexpected value.');
    assert(p.Members[1].HP ~= nil, 'HP returned an unexpected value.');
    assert(p.Members[1].MP ~= nil, 'MP returned an unexpected value.');
    assert(p.Members[1].TP ~= nil, 'TP returned an unexpected value.');
    assert(p.Members[1].HPPercent ~= nil, 'HPPercent returned an unexpected value.');
    assert(p.Members[1].MPPercent ~= nil, 'MPPercent returned an unexpected value.');
    assert(p.Members[1].Zone ~= nil, 'Zone returned an unexpected value.');
    assert(p.Members[1].Zone2 ~= nil, 'Zone2 returned an unexpected value.');
    assert(p.Members[1].FlagMask ~= nil, 'FlagMask returned an unexpected value.');
    assert(p.Members[1].TreasureLots ~= nil, 'TreasureLots returned an unexpected value.');
    assert(p.Members[1].MonstrosityItemId ~= nil, 'MonstrosityItemId returned an unexpected value.');
    assert(p.Members[1].MonstrosityPrefixFlag1 ~= nil, 'MonstrosityPrefixFlag1 returned an unexpected value.');
    assert(p.Members[1].MonstrosityPrefixFlag2 ~= nil, 'MonstrosityPrefixFlag2 returned an unexpected value.');
    assert(p.Members[1].MonstrosityName ~= nil, 'MonstrosityName returned an unexpected value.');
    assert(p.Members[1].MainJob ~= nil, 'MainJob returned an unexpected value.');
    assert(p.Members[1].MainJobLevel ~= nil, 'MainJobLevel returned an unexpected value.');
    assert(p.Members[1].SubJob ~= nil, 'SubJob returned an unexpected value.');
    assert(p.Members[1].SubJobLevel ~= nil, 'SubJobLevel returned an unexpected value.');
    assert(p.Members[1].ServerId2 ~= nil, 'ServerId2 returned an unexpected value.');
    assert(p.Members[1].HPPercent2 ~= nil, 'HPPercent2 returned an unexpected value.');
    assert(p.Members[1].MPPercent2 ~= nil, 'MPPercent2 returned an unexpected value.');
    assert(p.Members[1].IsActive == 1, 'IsActive returned an unexpected value.');

    -- Test the raw party status icons..
    local picons = party:GetRawStructureStatusIcons();
    assert(picons ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(#picons.Members == 5, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(picons.Members[1].ServerId ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(picons.Members[1].TargetIndex ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(picons.Members[1].BitMask ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(#picons.Members[1].StatusIcons == 32, 'GetRawStructureStatusIcons returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

-- Return the test module table..
return test;