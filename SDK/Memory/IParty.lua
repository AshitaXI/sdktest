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

    --[[
    Test the raw structure..
    --]]

    -- Validate the raw party..
    local p = party:GetRawStructure();
    assert(p ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#p.Members == 18, 'GetRawStructure returned an unexpected value.');

    -- Testing the local players data..
    assert(p.Members[1].Name == e.Name, 'Name returned an unexpected value.');
    assert(p.Members[1].ServerId == e.ServerId, 'ServerId returned an unexpected value.');
    assert(p.Members[1].TargetIndex == e.TargetIndex, 'TargetIndex returned an unexpected value.');
    assert(p.Members[1].IsActive == 1, 'IsActive returned an unexpected value.');

    -- Test the raw party status icons..
    local picons = party:GetRawStructureStatusIcons();
    assert(picons ~= nil, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(#picons.Members == 5, 'GetRawStructureStatusIcons returned an unexpected value.');
    assert(#picons.Members[1].StatusIcons == 32, 'GetRawStructureStatusIcons returned an unexpected value.');
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

    AshitaCore:GetMemoryManager():GetParty():GetStatusIconsServerId()
    AshitaCore:GetMemoryManager():GetParty():GetStatusIconsTargetIndex()
    AshitaCore:GetMemoryManager():GetParty():GetStatusIconsBitMask()
    AshitaCore:GetMemoryManager():GetParty():GetStatusIcons()
        - We cannot really test these reliably since we cannot ensure the player will be in a party.
--]]