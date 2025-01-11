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

    -- Validate the player object..
    local player = mgr:GetPlayer();
    assert(player ~= nil, 'GetPlayer returned an unexpected value.');

    -- Validate the raw player object..
    local raw = player:GetRawStructure();
    assert(raw ~= nil, 'GetRawStructure returned an unexpected value.');

    -- Test the raw player structure fields..
    assert(raw.HPMax ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MPMax ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MainJob ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MainJobLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.SubJob ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.SubJobLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ExpCurrent ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ExpNeeded ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Strength ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Dexterity ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Vitality ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Agility ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Intelligence ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Mind ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Stats.Charisma ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Strength ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Dexterity ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Vitality ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Agility ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Intelligence ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Mind ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatsModifiers.Charisma ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Attack ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Defense ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Fire ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Ice ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Wind ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Earth ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Lightning ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Water ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Light ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Resists.Dark ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Title ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Rank ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.RankPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Homepoint ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Nation ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Residence ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.SuLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.HighestItemLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.ItemLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MainHandItemLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.RangedItemLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityInfo ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityInfo.Raw ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityInfo.Bits ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityInfo.Faction ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityInfo.Unknown ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityInfo.Points ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityPartialPersonalEvalutionPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityPersonalEvaluationPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.UnityChatColorFlag ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MasteryJob ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MasteryJobLevel ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MasteryFlags ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MasteryUnknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MasteryExp ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MasteryExpNeeded ~= nil, 'GetRawStructure returned an unexpected value.');

    local combat_skills = T{
        'Unknown', 'HandToHand', 'Dagger', 'Sword', 'GreatSword', 'Axe', 'GreatAxe', 'Scythe', 'Polearm', 'Katana', 'GreatKatana', 'Club', 'Staff',
        'Unused0000', 'Unused0001', 'Unused0002', 'Unused0003', 'Unused0004', 'Unused0005', 'Unused0006', 'Unused0007', 'Unused0008',
        'AutomatonMelee', 'AutomatonRanged', 'AutomatonMagic', 'Archery', 'Marksmanship', 'Throwing', 'Guarding', 'Evasion', 'Shield', 'Parrying',
        'Divine', 'Healing', 'Enhancing', 'Enfeebling', 'Elemental', 'Dark', 'Summon', 'Ninjutsu', 'Singing', 'String', 'Wind', 'BlueMagic',
        'Geomancy', 'Handbell', 'Unused0009', 'Unused0010',
    };
    local craft_skills = T{
        'Fishing', 'Woodworking', 'Smithing', 'Goldsmithing', 'Clothcraft', 'Leathercraft', 'Bonecraft', 'Alchemy', 'Cooking', 'Synergy', 'Riding',
        'Digging', 'Unused0000', 'Unused0001', 'Unused0002', 'Unused0003',
    };

    assert(raw.CombatSkills ~= nil, 'GetRawStructure returned an unexpected value.');
    combat_skills:each(function (v)
        assert(raw.CombatSkills[v] ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CombatSkills[v].Raw ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CombatSkills[v]:GetSkill() ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CombatSkills[v]:IsCapped() ~= nil, 'GetRawStructure returned an unexpected value.');
    end);

    assert(raw.CraftSkills ~= nil, 'GetRawStructure returned an unexpected value.');
    craft_skills:each(function (v)
        assert(raw.CraftSkills[v] ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CraftSkills[v].Raw ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CraftSkills[v]:GetSkill() ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CraftSkills[v]:GetRank() ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.CraftSkills[v]:IsCapped() ~= nil, 'GetRawStructure returned an unexpected value.');
    end);

    assert(raw.AbilityInfo ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.AbilityInfo == 31, 'GetRawStructure returned an unexpected value.');
    for x = 1, 31 do
        assert(raw.AbilityInfo[x] ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.AbilityInfo[x].Recast ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.AbilityInfo[x].RecastCalc1 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.AbilityInfo[x].TimerId ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.AbilityInfo[x].RecastCalc2 ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.AbilityInfo[x].Unknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
    end

    assert(raw.MountRecast ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MountRecast.Recast ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MountRecast.TimerId ~= nil, 'GetRawStructure returned an unexpected value.');

    assert(raw.DataLoadedFlags ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0001 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.LimitPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MeritPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.AssimilationPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsLimitBreaker ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsExperiencePointsLocked ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsLimitModeEnabled ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.MeritPointsMax ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0002 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0003 ~= nil, 'GetRawStructure returned an unexpected value.');

    assert(raw.JobPoints ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.JobPoints.Unknown0000 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.JobPoints.Jobs ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.JobPoints.Jobs == 24, 'GetRawStructure returned an unexpected value.');

    for x = 1, 24 do
        assert(raw.JobPoints.Jobs[x].CapacityPoints ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.JobPoints.Jobs[x].Points ~= nil, 'GetRawStructure returned an unexpected value.');
        assert(raw.JobPoints.Jobs[x].PointsSpent ~= nil, 'GetRawStructure returned an unexpected value.');
    end

    assert(raw.HomepointMasks ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.HomepointMasks == 64, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusIcons ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.StatusIcons == 32, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusTimers ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.StatusTimers == 32, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0004 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.Unknown0004 == 32, 'GetRawStructure returned an unexpected value.');
    assert(raw.IsZoning ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset1 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset1.X ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset1.Z ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset1.Y ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset1.W ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset2 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset2.X ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset2.Z ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset2.Y ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset2.W ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset3 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset3.X ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset3.Z ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset3.Y ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset3.W ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset4 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset4.X ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset4.Z ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset4.Y ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.StatusOffset4.W ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0005 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Unknown0006 ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(raw.Buffs ~= nil, 'GetRawStructure returned an unexpected value.');
    assert(#raw.Buffs == 32, 'GetRawStructure returned an unexpected value.');

    --[[
    Function Testing
    --]]

    assert(player:GetHPMax() ~= nil, 'GetHPMax returned an unexpected value.');
    assert(player:GetMPMax() ~= nil, 'GetMPMax returned an unexpected value.');
    assert(player:GetMainJob() ~= nil, 'GetMainJob returned an unexpected value.');
    assert(player:GetMainJobLevel() ~= nil, 'GetMainJobLevel returned an unexpected value.');
    assert(player:GetSubJob() ~= nil, 'GetSubJob returned an unexpected value.');
    assert(player:GetSubJobLevel() ~= nil, 'GetSubJobLevel returned an unexpected value.');
    assert(player:GetExpCurrent() ~= nil, 'GetExpCurrent returned an unexpected value.');
    assert(player:GetExpNeeded() ~= nil, 'GetExpNeeded returned an unexpected value.');
    assert(player:GetStat(0) ~= nil, 'GetStat returned an unexpected value.');
    assert(player:GetStatModifier(0) ~= nil, 'GetStatModifier returned an unexpected value.');
    assert(player:GetAttack() ~= nil, 'GetAttack returned an unexpected value.');
    assert(player:GetDefense() ~= nil, 'GetDefense returned an unexpected value.');
    assert(player:GetResist(0) ~= nil, 'GetResist returned an unexpected value.');
    assert(player:GetTitle() ~= nil, 'GetTitle returned an unexpected value.');
    assert(player:GetRank() ~= nil, 'GetRank returned an unexpected value.');
    assert(player:GetRankPoints() ~= nil, 'GetRankPoints returned an unexpected value.');
    assert(player:GetHomepoint() ~= nil, 'GetHomepoint returned an unexpected value.');
    assert(player:GetNation() ~= nil, 'GetNation returned an unexpected value.');
    assert(player:GetResidence() ~= nil, 'GetResidence returned an unexpected value.');
    assert(player:GetSuLevel() ~= nil, 'GetSuLevel returned an unexpected value.');
    assert(player:GetHighestItemLevel() ~= nil, 'GetHighestItemLevel returned an unexpected value.');
    assert(player:GetItemLevel() ~= nil, 'GetItemLevel returned an unexpected value.');
    assert(player:GetMainHandItemLevel() ~= nil, 'GetMainHandItemLevel returned an unexpected value.');
    assert(player:GetRangedItemLevel() ~= nil, 'GetRangedItemLevel returned an unexpected value.');
    assert(player:GetUnityFaction() ~= nil, 'GetUnityFaction returned an unexpected value.');
    assert(player:GetUnityPoints() ~= nil, 'GetUnityPoints returned an unexpected value.');
    assert(player:GetUnityPartialPersonalEvalutionPoints() ~= nil, 'GetUnityPartialPersonalEvalutionPoints returned an unexpected value.');
    assert(player:GetUnityPersonalEvaluationPoints() ~= nil, 'GetUnityPersonalEvaluationPoints returned an unexpected value.');
    assert(player:GetUnityChatColorFlag() ~= nil, 'GetUnityChatColorFlag returned an unexpected value.');
    assert(player:GetMasteryJob() ~= nil, 'GetMasteryJob returned an unexpected value.');
    assert(player:GetMasteryJobLevel() ~= nil, 'GetMasteryJobLevel returned an unexpected value.');
    assert(player:GetMasteryFlags() ~= nil, 'GetMasteryFlags returned an unexpected value.');
    assert(player:GetMasteryUnknown0000() ~= nil, 'GetMasteryUnknown0000 returned an unexpected value.');
    assert(player:GetMasteryExp() ~= nil, 'GetMasteryExp returned an unexpected value.');
    assert(player:GetMasteryExpNeeded() ~= nil, 'GetMasteryExpNeeded returned an unexpected value.');
    assert(player:GetCombatSkill(0) ~= nil, 'GetCombatSkill returned an unexpected value.')
    assert(player:GetCraftSkill(0) ~= nil, 'GetCraftSkill returned an unexpected value.')
    assert(player:GetAbilityRecast(0) ~= nil, 'GetAbilityRecast returned an unexpected value.')
    assert(player:GetAbilityRecastCalc1(0) ~= nil, 'GetAbilityRecastCalc1 returned an unexpected value.')
    assert(player:GetAbilityRecastTimerId(0) ~= nil, 'GetAbilityRecastTimerId returned an unexpected value.')
    assert(player:GetAbilityRecastCalc2(0) ~= nil, 'GetAbilityRecastCalc2 returned an unexpected value.')
    assert(player:GetMountRecast() ~= nil, 'GetMountRecast returned an unexpected value.')
    assert(player:GetMountRecastTimerId() ~= nil, 'GetMountRecastTimerId returned an unexpected value.')
    assert(player:GetDataLoadedFlags() ~= nil, 'GetDataLoadedFlags returned an unexpected value.')
    assert(player:GetLimitPoints() ~= nil, 'GetLimitPoints returned an unexpected value.')
    assert(player:GetMeritPoints() ~= nil, 'GetMeritPoints returned an unexpected value.')
    assert(player:GetAssimilationPoints() ~= nil, 'GetAssimilationPoints returned an unexpected value.')
    assert(player:GetIsLimitBreaker() ~= nil, 'GetIsLimitBreaker returned an unexpected value.')
    assert(player:GetIsExperiencePointsLocked() ~= nil, 'GetIsExperiencePointsLocked returned an unexpected value.')
    assert(player:GetIsLimitModeEnabled() ~= nil, 'GetIsLimitModeEnabled returned an unexpected value.')
    assert(player:GetMeritPointsMax() ~= nil, 'GetMeritPointsMax returned an unexpected value.')
    assert(player:GetHomepointMasks() ~= nil, 'GetHomepointMasks returned an unexpected value.')
    assert(player:GetIsZoning() ~= nil, 'GetIsZoning returned an unexpected value.')
    assert(player:GetStatusOffset1X() ~= nil, 'GetStatusOffset1X returned an unexpected value.');
    assert(player:GetStatusOffset1Z() ~= nil, 'GetStatusOffset1Z returned an unexpected value.');
    assert(player:GetStatusOffset1Y() ~= nil, 'GetStatusOffset1Y returned an unexpected value.');
    assert(player:GetStatusOffset1W() ~= nil, 'GetStatusOffset1W returned an unexpected value.');
    assert(player:GetStatusOffset2X() ~= nil, 'GetStatusOffset2X returned an unexpected value.');
    assert(player:GetStatusOffset2Z() ~= nil, 'GetStatusOffset2Z returned an unexpected value.');
    assert(player:GetStatusOffset2Y() ~= nil, 'GetStatusOffset2Y returned an unexpected value.');
    assert(player:GetStatusOffset2W() ~= nil, 'GetStatusOffset2W returned an unexpected value.');
    assert(player:GetStatusOffset3X() ~= nil, 'GetStatusOffset3X returned an unexpected value.');
    assert(player:GetStatusOffset3Z() ~= nil, 'GetStatusOffset3Z returned an unexpected value.');
    assert(player:GetStatusOffset3Y() ~= nil, 'GetStatusOffset3Y returned an unexpected value.');
    assert(player:GetStatusOffset3W() ~= nil, 'GetStatusOffset3W returned an unexpected value.');
    assert(player:GetStatusOffset4X() ~= nil, 'GetStatusOffset4X returned an unexpected value.');
    assert(player:GetStatusOffset4Z() ~= nil, 'GetStatusOffset4Z returned an unexpected value.');
    assert(player:GetStatusOffset4Y() ~= nil, 'GetStatusOffset4Y returned an unexpected value.');
    assert(player:GetStatusOffset4W() ~= nil, 'GetStatusOffset4W returned an unexpected value.');

    assert(player:GetCapacityPoints(0) ~= nil, 'GetCapacityPoints returned an unexpected value.');
    assert(player:GetJobPoints(0) ~= nil, 'GetJobPoints returned an unexpected value.');
    assert(player:GetJobPointsSpent(0) ~= nil, 'GetJobPointsSpent returned an unexpected value.');

    assert(player:GetStatusIcons() ~= nil, 'GetStatusIcons returned an unexpected value.');
    assert(player:GetStatusTimers() ~= nil, 'GetStatusTimers returned an unexpected value.');
    assert(player:GetBuffs() ~= nil, 'GetBuffs returned an unexpected value.');

    assert(player:GetPetMPPercent() ~= nil, 'GetPetMPPercent returned an unexpected value.');
    assert(player:GetPetTP() ~= nil, 'GetPetTP returned an unexpected value.');

    assert(player:GetJobLevel(0) ~= nil, 'GetJobLevel returned an unexpected value.');
    assert(player:GetJobMasterFlags() ~= nil, 'GetJobMasterFlags returned an unexpected value.');
    assert(player:GetJobMasterLevel(0) ~= nil, 'GetJobMasterLevel returned an unexpected value.');
    assert(player:GetLoginStatus() ~= nil, 'GetLoginStatus returned an unexpected value.');

    assert(player:HasAbilityData() ~= nil, 'HasAbilityData returned an unexpected value.');
    assert(player:HasSpellData() ~= nil, 'HasSpellData returned an unexpected value.');
    assert(player:HasAbility(0) ~= nil, 'HasAbility returned an unexpected value.');
    assert(player:HasPetCommand(0) ~= nil, 'HasPetCommand returned an unexpected value.');
    assert(player:HasSpell(0) ~= nil, 'HasSpell returned an unexpected value.');
    assert(player:HasTrait(0) ~= nil, 'HasTrait returned an unexpected value.');
    assert(player:HasWeaponSkill(0) ~= nil, 'HasWeaponSkill returned an unexpected value.');
    assert(player:HasKeyItem(0) ~= nil, 'HasKeyItem returned an unexpected value.');
end

-- Return the test module table..
return test;