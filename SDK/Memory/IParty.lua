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
local test = T{};

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
    -- Validate the manager object..
    local mgr = AshitaCore:GetMemoryManager();
    assert(mgr ~= nil, 'GetMemoryManager returned an unexpected value.');

    -- Validate the party object..
    local party = mgr:GetParty();
    assert(party ~= nil, 'GetParty returned an unexpected value.');

    -- Validate the raw party object..
    local raw = party:GetRawStructure();
    assert(raw ~= nil, 'GetRawStructure returned an unexpected value.');

    -- Test the raw party structure fields..
    assert(raw.Members ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.Members == 18, 'GetRawStructure returned an unexpected value.');

    for x = 1, 18 do
        if (x == 1) then
            assert(raw.Members[x].AllianceInfo ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.AllianceLeaderServerId ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyLeaderServerId1 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyLeaderServerId2 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyLeaderServerId3 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyVisible1 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyVisible2 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyVisible3 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyMemberCount1 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyMemberCount2 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.PartyMemberCount3 ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.Invited ~= nil, 'GetRawStructure returned an unexpected value.');
            assert(raw.Members[x].AllianceInfo.Unknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
        end
        assert(raw.Members[x].Index ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MemberNumber ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].Name ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].ServerId ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].TargetIndex ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].LastUpdatedTimestamp ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].HP ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MP ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].TP ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].HPPercent ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MPPercent ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].Zone ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].Zone2 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].Unknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].FlagMask ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].TreasureLots ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(#raw.Members[x].TreasureLots == 10, 'GetRawStructure returned an unexpected value.');
        for y = 1, 10 do
            assert(raw.Members[x].TreasureLots[y] ~= nil, 'GetRawStructure returned an unexpected value.');
        end
        assert(raw.Members[x].MonstrosityItemId ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MonstrosityPrefixFlag1 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MonstrosityPrefixFlag2 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MonstrosityName ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MainJob ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MainJobLevel ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].SubJob ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].SubJobLevel ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].Unknown0001 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].ServerId2 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].HPPercent2 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].MPPercent2 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].IsActive ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.Members[x].Unknown0002 ~= nil, 'GetRawStructure returned an unexpected value.');
    end

    -- Obtain the player entity..
    local player = GetPlayerEntity();
    assert(player ~= nil, 'GetPlayerEntity returned an unexpected value.');

    -- Validate the party information against the player entity information..
    assert(raw.Members[1].Name == player.Name, 'GetRawStructure returned an unexpected value.');
    assert(raw.Members[1].ServerId == player.ServerId, 'GetRawStructure returned an unexpected value.');
    assert(raw.Members[1].TargetIndex == player.TargetIndex, 'GetRawStructure returned an unexpected value.');
    assert(raw.Members[1].HPPercent == player.HPPercent, 'GetRawStructure returned an unexpected value.');
    assert(raw.Members[1].IsActive == 1, 'GetRawStructure returned an unexpected value.');

    -- Test the raw status icons structure fields..
    raw = party:GetRawStructureStatusIcons();
    assert(raw ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(#raw.Members == 5, 'GetRawStructureStatusIcons returned an unexpected value.');

    for x = 1, 5 do
        assert(raw.Members[x].ServerId ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
        assert(raw.Members[x].TargetIndex ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
        assert(raw.Members[x].BitMask ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
        assert(raw.Members[x].StatusIcons ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
        assert(#raw.Members[x].StatusIcons == 32, 'GetRawStructureStatusIcons returned an unexpected value.');
    end

    --[[
    Function Testing
    --]]

    -- Test alliance functions..
    assert(party:GetAllianceLeaderServerId() ~= nil, 'GetAllianceLeaderServerId returned an unexpected value.');
    assert(party:GetAlliancePartyLeaderServerId1() ~= nil, 'GetAlliancePartyLeaderServerId1 returned an unexpected value.');
    assert(party:GetAlliancePartyLeaderServerId2() ~= nil, 'GetAlliancePartyLeaderServerId2 returned an unexpected value.');
    assert(party:GetAlliancePartyLeaderServerId3() ~= nil, 'GetAlliancePartyLeaderServerId3 returned an unexpected value.');
    assert(party:GetAlliancePartyVisible1() ~= nil, 'GetAlliancePartyVisible1 returned an unexpected value.');
    assert(party:GetAlliancePartyVisible2() ~= nil, 'GetAlliancePartyVisible2 returned an unexpected value.');
    assert(party:GetAlliancePartyVisible3() ~= nil, 'GetAlliancePartyVisible3 returned an unexpected value.');
    assert(party:GetAlliancePartyMemberCount1() ~= nil, 'GetAlliancePartyMemberCount1 returned an unexpected value.');
    assert(party:GetAlliancePartyMemberCount2() ~= nil, 'GetAlliancePartyMemberCount2 returned an unexpected value.');
    assert(party:GetAlliancePartyMemberCount3() ~= nil, 'GetAlliancePartyMemberCount3 returned an unexpected value.');
    assert(party:GetAllianceInvited() ~= nil, 'GetAllianceInvited returned an unexpected value.');

    for x = 0, 17 do
        assert(party:GetMemberIndex(x) ~= nil, 'GetMemberIndex returned an unexpected value.');
        assert(party:GetMemberNumber(x) ~= nil, 'GetMemberNumber returned an unexpected value.');
        party:GetMemberName(x); -- Note: This can return nil, so we just test the call functions without throwing.
        assert(party:GetMemberServerId(x) ~= nil, 'GetMemberServerId returned an unexpected value.');
        assert(party:GetMemberTargetIndex(x) ~= nil, 'GetMemberTargetIndex returned an unexpected value.');
        assert(party:GetMemberLastUpdatedTimestamp(x) ~= nil, 'GetMemberLastUpdatedTimestamp returned an unexpected value.');
        assert(party:GetMemberHP(x) ~= nil, 'GetMemberHP returned an unexpected value.');
        assert(party:GetMemberMP(x) ~= nil, 'GetMemberMP returned an unexpected value.');
        assert(party:GetMemberTP(x) ~= nil, 'GetMemberTP returned an unexpected value.');
        assert(party:GetMemberHPPercent(x) ~= nil, 'GetMemberHPPercent returned an unexpected value.');
        assert(party:GetMemberMPPercent(x) ~= nil, 'GetMemberMPPercent returned an unexpected value.');
        assert(party:GetMemberZone(x) ~= nil, 'GetMemberZone returned an unexpected value.');
        assert(party:GetMemberZone2(x) ~= nil, 'GetMemberZone2 returned an unexpected value.');
        assert(party:GetMemberFlagMask(x) ~= nil, 'GetMemberFlagMask returned an unexpected value.');
        for y = 0, 9 do
            assert(party:GetMemberTreasureLot(x, y) ~= nil, 'GetMemberTreasureLot returned an unexpected value.');
        end
        assert(party:GetMemberMonstrosityItemId(x) ~= nil, 'GetMemberMonstrosityItemId returned an unexpected value.');
        assert(party:GetMemberMonstrosityPrefixFlag1(x) ~= nil, 'GetMemberMonstrosityPrefixFlag1 returned an unexpected value.');
        assert(party:GetMemberMonstrosityPrefixFlag2(x) ~= nil, 'GetMemberMonstrosityPrefixFlag2 returned an unexpected value.');
        party:GetMemberMonstrosityName(x); -- Note: This can return nil, so we just test the call functions without throwing.
        assert(party:GetMemberMainJob(x) ~= nil, 'GetMemberMainJob returned an unexpected value.');
        assert(party:GetMemberMainJobLevel(x) ~= nil, 'GetMemberMainJobLevel returned an unexpected value.');
        assert(party:GetMemberSubJob(x) ~= nil, 'GetMemberSubJob returned an unexpected value.');
        assert(party:GetMemberSubJobLevel(x) ~= nil, 'GetMemberSubJobLevel returned an unexpected value.');
        assert(party:GetMemberServerId2(x) ~= nil, 'GetMemberServerId2 returned an unexpected value.');
        assert(party:GetMemberHPPercent2(x) ~= nil, 'GetMemberHPPercent2 returned an unexpected value.');
        assert(party:GetMemberMPPercent2(x) ~= nil, 'GetMemberMPPercent2 returned an unexpected value.');
        assert(party:GetMemberIsActive(x) ~= nil, 'GetMemberIsActive returned an unexpected value.');
    end

    for x = 0, 4 do
        assert(party:GetStatusIconsServerId(x) ~= nil, 'GetStatusIconsServerId returned an unexpected value.');
        assert(party:GetStatusIconsTargetIndex(x) ~= nil, 'GetStatusIconsTargetIndex returned an unexpected value.');
        assert(party:GetStatusIconsBitMask(x) ~= nil, 'GetStatusIconsBitMask returned an unexpected value.');
        assert(party:GetStatusIcons(x) ~= nil, 'GetStatusIcons returned an unexpected value.');
        assert(#party:GetStatusIcons(x) == 32, 'GetStatusIcons returned an unexpected value.');
    end
end

-- Return the test module table..
return test;