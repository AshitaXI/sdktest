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

    -- Validate the player object..
    local player = memManager:GetPlayer();
    assert(player ~= nil, 'GetPlayer returned an unexpected value.');

    --[[
    Test the player functions..
    --]]

    local v = nil;
    v = player:GetMPMax();
    assert(v ~= nil, 'GetMPMax returned an unexpected value.');
    v = player:GetMainJob();
    assert(v ~= nil, 'GetMainJob returned an unexpected value.');
    v = player:GetMainJobLevel();
    assert(v ~= nil, 'GetMainJobLevel returned an unexpected value.');
    v = player:GetSubJob();
    assert(v ~= nil, 'GetSubJob returned an unexpected value.');
    v = player:GetSubJobLevel();
    assert(v ~= nil, 'GetSubJobLevel returned an unexpected value.');
    v = player:GetExpCurrent();
    assert(v ~= nil, 'GetExpCurrent returned an unexpected value.');
    v = player:GetExpNeeded();
    assert(v ~= nil, 'GetExpNeeded returned an unexpected value.');
    v = player:GetStat(0);
    assert(v ~= nil, 'GetStat returned an unexpected value.');
    v = player:GetStatModifier(0);
    assert(v ~= nil, 'GetStatModifier returned an unexpected value.');
    v = player:GetAttack();
    assert(v ~= nil, 'GetAttack returned an unexpected value.');
    v = player:GetDefense();
    assert(v ~= nil, 'GetDefense returned an unexpected value.');
    v = player:GetResist(0);
    assert(v ~= nil, 'GetResist returned an unexpected value.');
    v = player:GetTitle();
    assert(v ~= nil, 'GetTitle returned an unexpected value.');
    v = player:GetRank();
    assert(v ~= nil, 'GetRank returned an unexpected value.');
    v = player:GetRankPoints();
    assert(v ~= nil, 'GetRankPoints returned an unexpected value.');
    v = player:GetNation();
    assert(v ~= nil, 'GetNation returned an unexpected value.');
    v = player:GetResidence();
    assert(v ~= nil, 'GetResidence returned an unexpected value.');
    v = player:GetSuLevel();
    assert(v ~= nil, 'GetSuLevel returned an unexpected value.');
    v = player:GetHomepoint();
    assert(v ~= nil, 'GetHomepoint returned an unexpected value.');
    v = player:GetCombatSkill(0);
    assert(v ~= nil, 'GetCombatSkill returned an unexpected value.');
    v = player:GetCraftSkill(0);
    assert(v ~= nil, 'GetCraftSkill returned an unexpected value.');
    v = player:GetAbilityRecast(0);
    assert(v ~= nil, 'GetAbilityRecast returned an unexpected value.');
    v = player:GetAbilityRecastTimerId(0);
    assert(v ~= nil, 'GetAbilityRecastTimerId returned an unexpected value.');
    v = player:GetMountRecast();
    assert(v ~= nil, 'GetMountRecast returned an unexpected value.');
    v = player:GetMountRecastTimerId();
    assert(v ~= nil, 'GetMountRecastTimerId returned an unexpected value.');
    v = player:GetHighestItemLevel();
    assert(v ~= nil, 'GetHighestItemLevel returned an unexpected value.');
    v = player:GetItemLevel();
    assert(v ~= nil, 'GetItemLevel returned an unexpected value.');
    v = player:GetMainHandItemLevel();
    assert(v ~= nil, 'GetMainHandItemLevel returned an unexpected value.');
    v = player:GetUnityFaction();
    assert(v ~= nil, 'GetUnityFaction returned an unexpected value.');
    v = player:GetUnityPoints();
    assert(v ~= nil, 'GetUnityPoints returned an unexpected value.');
    v = player:GetUnityPartialPersonalEvalutionPoints();
    assert(v ~= nil, 'GetUnityPartialPersonalEvalutionPoints returned an unexpected value.');
    v = player:GetUnityPersonalEvaluationPoints();
    assert(v ~= nil, 'GetUnityPersonalEvaluationPoints returned an unexpected value.');
    v = player:GetUnityChatColorFlag();
    assert(v ~= nil, 'GetUnityChatColorFlag returned an unexpected value.');
    v = player:GetDataLoadedFlags();
    assert(v ~= nil, 'GetDataLoadedFlags returned an unexpected value.');
    v = player:GetLimitPoints();
    assert(v ~= nil, 'GetLimitPoints returned an unexpected value.');
    v = player:GetMeritPoints();
    assert(v ~= nil, 'GetMeritPoints returned an unexpected value.');
    v = player:GetLimitMode();
    assert(v ~= nil, 'GetLimitMode returned an unexpected value.');
    v = player:GetMeritPointsMax();
    assert(v ~= nil, 'GetMeritPointsMax returned an unexpected value.');
    v = player:GetHomepointMasks();
    assert(v ~= nil, 'GetHomepointMasks returned an unexpected value.');
    v = player:GetIsZoning();
    assert(v ~= nil, 'GetIsZoning returned an unexpected value.');
    assert(v == 0, 'GetIsZoning returned an unexpected value.');

    v = player:GetCapacityPoints(0);
    assert(v ~= nil, 'GetCapacityPoints returned an unexpected value.');
    v = player:GetJobPoints(0);
    assert(v ~= nil, 'GetJobPoints returned an unexpected value.');
    v = player:GetJobPointsSpent(0);
    assert(v ~= nil, 'GetJobPointsSpent returned an unexpected value.');

    v = player:GetStatusIcons();
    assert(v ~= nil, 'GetStatusIcons returned an unexpected value.');
    v = player:GetStatusTimers();
    assert(v ~= nil, 'GetStatusTimers returned an unexpected value.');
    v = player:GetBuffs();
    assert(v ~= nil, 'GetBuffs returned an unexpected value.');

    v = player:GetPetMPPercent();
    assert(v ~= nil, 'GetPetMPPercent returned an unexpected value.');
    v = player:GetPetTP();
    assert(v ~= nil, 'GetPetTP returned an unexpected value.');

    v = player:GetJobLevel(0);
    assert(v ~= nil, 'GetJobLevel returned an unexpected value.');
    v = player:GetLoginStatus();
    assert(v ~= nil, 'GetLoginStatus returned an unexpected value.');
    assert(v == 2, 'GetLoginStatus returned an unexpected value.');

    v = player:HasAbility(0);
    assert(v ~= nil, 'HasAbility returned an unexpected value.');
    v = player:HasPetCommand(0);
    assert(v ~= nil, 'HasPetCommand returned an unexpected value.');
    v = player:HasSpell(0);
    assert(v ~= nil, 'HasSpell returned an unexpected value.');
    v = player:HasTrait(0);
    assert(v ~= nil, 'HasTrait returned an unexpected value.');
    v = player:HasWeaponSkill(0);
    assert(v ~= nil, 'HasWeaponSkill returned an unexpected value.');
    v = player:HasKeyItem(0);
    assert(v ~= nil, 'HasKeyItem returned an unexpected value.');

    --[[
    Test the raw object..
    --]]

    local p = player:GetRawStructure();
    assert(p ~= nil, 'GetRawStructure returned an unexpected value.');

    assert(player:GetHPMax() == p.HPMax, 'HPMax returned an unexpected value.');
    assert(player:GetMPMax() == p.MPMax, 'MPMax returned an unexpected value.');
    assert(player:GetMainJob() == p.MainJob, 'MainJob returned an unexpected value.');
    assert(player:GetMainJobLevel() == p.MainJobLevel, 'MainJobLevel returned an unexpected value.');
    assert(player:GetSubJob() == p.SubJob, 'SubJob returned an unexpected value.');
    assert(player:GetSubJobLevel() == p.SubJobLevel, 'SubJobLevel returned an unexpected value.');
    assert(player:GetExpCurrent() == p.ExpCurrent, 'ExpCurrent returned an unexpected value.');
    assert(player:GetExpNeeded() == p.ExpNeeded, 'ExpNeeded returned an unexpected value.');
    assert(player:GetStat(0) == p.Stats.Strength, 'Stats returned an unexpected value.');
    assert(player:GetStatModifier(0) == p.StatsModifiers.Strength, 'StatsModifiers returned an unexpected value.');
    assert(player:GetAttack() == p.Attack, 'Attack returned an unexpected value.');
    assert(player:GetDefense() == p.Defense, 'Defense returned an unexpected value.');
    assert(player:GetResist(0) == p.Resists.Fire, 'Resists returned an unexpected value.');
    assert(player:GetTitle() == p.Title, 'Title returned an unexpected value.');
    assert(player:GetRank() == p.Rank, 'Rank returned an unexpected value.');
    assert(player:GetRankPoints() == p.RankPoints, 'RankPoints returned an unexpected value.');
    assert(player:GetNation() == p.Nation, 'Nation returned an unexpected value.');
    assert(player:GetResidence() == p.Residence, 'Residence returned an unexpected value.');
    assert(player:GetSuLevel() == p.SuLevel, 'SuLevel returned an unexpected value.');
    assert(player:GetHomepoint() == p.Homepoint, 'Homepoint returned an unexpected value.');
    assert(player:GetCombatSkill(1).Raw == p.CombatSkills.HandToHand.Raw, 'CombatSkills returned an unexpected value.');
    assert(player:GetCraftSkill(0).Raw == p.CraftSkills.Fishing.Raw, 'CraftSkills returned an unexpected value.');
    assert(player:GetAbilityRecast(0) == p.AbilityInfo[1].Recast, 'AbilityInfo returned an unexpected value.');
    assert(player:GetAbilityRecastTimerId(0) == p.AbilityInfo[1].TimerId, 'AbilityInfo returned an unexpected value.');
    assert(player:GetMountRecast() == p.MountRecast.Recast, 'MountRecast returned an unexpected value.');
    assert(player:GetMountRecastTimerId() == p.MountRecast.TimerId, 'MountRecast returned an unexpected value.');
    assert(player:GetHighestItemLevel() == p.HighestItemLevel, 'HighestItemLevel returned an unexpected value.');
    assert(player:GetItemLevel() == p.ItemLevel, 'ItemLevel returned an unexpected value.');
    assert(player:GetMainHandItemLevel() == p.MainHandItemLevel, 'MainHandItemLevel returned an unexpected value.');
    assert(player:GetUnityFaction() == p.UnityInfo.Faction, 'UnityInfo returned an unexpected value.');
    assert(player:GetUnityPoints() == p.UnityInfo.Points, 'UnityInfo returned an unexpected value.');
    assert(player:GetUnityPartialPersonalEvalutionPoints() == p.UnityPartialPersonalEvalutionPoints, 'UnityPartialPersonalEvalutionPoints returned an unexpected value.');
    assert(player:GetUnityPersonalEvaluationPoints() == p.UnityPersonalEvaluationPoints, 'UnityPersonalEvaluationPoints returned an unexpected value.');
    assert(player:GetUnityChatColorFlag() == p.UnityChatColorFlag, 'UnityChatColorFlag returned an unexpected value.');
    assert(player:GetDataLoadedFlags() == p.DataLoadedFlags, 'DataLoadedFlags returned an unexpected value.');
    assert(player:GetLimitPoints() == p.LimitPoints, 'LimitPoints returned an unexpected value.');
    assert(player:GetMeritPoints() == p.MeritPoints, 'MeritPoints returned an unexpected value.');
    assert(player:GetLimitMode() == p.LimitMode, 'LimitMode returned an unexpected value.');
    assert(player:GetMeritPointsMax() == p.MeritPointsMax, 'MeritPointsMax returned an unexpected value.');
    assert(player:GetHomepointMasks() == p.HomepointMasks, 'HomepointMasks returned an unexpected value.');
    assert(player:GetIsZoning() == p.IsZoning, 'IsZoning returned an unexpected value.');

    assert(player:GetCapacityPoints(0) == p.JobPoints.Jobs[1].CapacityPoints, 'CapacityPoints returned an unexpected value.');
    assert(player:GetJobPoints(0) == p.JobPoints.Jobs[1].Points, 'Points returned an unexpected value.');
    assert(player:GetJobPointsSpent(0) == p.JobPoints.Jobs[1].PointsSpent, 'PointsSpent returned an unexpected value.');

    assert(player:GetStatusIcons()[1] == p.StatusIcons[1], 'StatusIcons returned an unexpected value.');
    assert(player:GetStatusTimers()[1] == p.StatusTimers[1], 'StatusTimers returned an unexpected value.');
    assert(player:GetBuffs()[1] == p.Buffs[1], 'Buffs returned an unexpected value.');
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

--]]