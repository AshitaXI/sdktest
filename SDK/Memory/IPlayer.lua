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

    -- Table layout: T{ 'FuncName', OptionalArguments, ExpectedReturnIfNotNil }
    local funcs = T{
        -- Get Properties (Player Info)
        T{ 'GetHPMax',                                  nil,    nil },
        T{ 'GetMPMax',                                  nil,    nil },
        T{ 'GetMainJob',                                nil,    nil },
        T{ 'GetMainJobLevel',                           nil,    nil },
        T{ 'GetSubJob',                                 nil,    nil },
        T{ 'GetSubJobLevel',                            nil,    nil },
        T{ 'GetExpCurrent',                             nil,    nil },
        T{ 'GetExpNeeded',                              nil,    nil },
        T{ 'GetStat',                                   T{ 0 }, nil },
        T{ 'GetStatModifier',                           T{ 0 }, nil },
        T{ 'GetAttack',                                 nil,    nil },
        T{ 'GetDefense',                                nil,    nil },
        T{ 'GetResist',                                 T{ 0 }, nil },
        T{ 'GetTitle',                                  nil,    nil },
        T{ 'GetRank',                                   nil,    nil },
        T{ 'GetRankPoints',                             nil,    nil },
        T{ 'GetHomepoint',                              nil,    nil },
        T{ 'GetNation',                                 nil,    nil },
        T{ 'GetResidence',                              nil,    nil },
        T{ 'GetSuLevel',                                nil,    nil },
        T{ 'GetHighestItemLevel',                       nil,    nil },
        T{ 'GetItemLevel',                              nil,    nil },
        T{ 'GetMainHandItemLevel',                      nil,    nil },
        T{ 'GetUnityFaction',                           nil,    nil },
        T{ 'GetUnityPoints',                            nil,    nil },
        T{ 'GetUnityPartialPersonalEvalutionPoints',    nil,    nil },
        T{ 'GetUnityPersonalEvaluationPoints',          nil,    nil },
        T{ 'GetUnityChatColorFlag',                     nil,    nil },
        T{ 'GetMasteryJob',                             nil,    nil },
        T{ 'GetMasteryJobLevel',                        nil,    nil },
        T{ 'GetMasteryFlags',                           nil,    nil },
        T{ 'GetMasteryUnknown0000',                     nil,    nil },
        T{ 'GetMasteryExp',                             nil,    nil },
        T{ 'GetMasteryExpNeeded',                       nil,    nil },
        T{ 'GetCombatSkill',                            T{ 0 }, nil },
        T{ 'GetCraftSkill',                             T{ 0 }, nil },
        T{ 'GetAbilityRecast',                          T{ 0 }, nil },
        T{ 'GetAbilityRecastTimerId',                   T{ 0 }, nil },
        T{ 'GetMountRecast',                            nil,    nil },
        T{ 'GetMountRecastTimerId',                     nil,    nil },
        T{ 'GetDataLoadedFlags',                        nil,    nil },
        T{ 'GetLimitPoints',                            nil,    nil },
        T{ 'GetMeritPoints',                            nil,    nil },
        T{ 'GetAssimilationPoints',                     nil,    nil },
        T{ 'GetIsLimitBreaker',                         nil,    nil },
        T{ 'GetIsExperiencePointsLocked',               nil,    nil },
        T{ 'GetIsLimitModeEnabled',                     nil,    nil },
        T{ 'GetMeritPointsMax',                         nil,    nil },
        T{ 'GetHomepointMasks',                         nil,    nil },
        T{ 'GetIsZoning',                               nil,    0 },

        -- Get Properties (Job Points)
        T{ 'GetCapacityPoints', T{ 0 }, nil },
        T{ 'GetJobPoints',      T{ 0 }, nil },
        T{ 'GetJobPointsSpent', T{ 0 }, nil },

        -- Get Properties (Status Icons / Buffs)
        T{ 'GetStatusIcons',    nil,    nil },
        T{ 'GetStatusTimers',   nil,    nil },
        T{ 'GetBuffs',          nil,    nil },

        -- Get Properties (Pet Info)
        T{ 'GetPetMPPercent',   nil,    nil },
        T{ 'GetPetTP',          nil,    nil },

        -- Get Properties (Extra Info)
        T{ 'GetJobLevel',       T{ 1 }, nil },
        T{ 'GetJobMasterFlags', nil,    nil },
        T{ 'GetJobMasterLevel', T{ 1 }, nil },
        T{ 'GetLoginStatus',    nil,    2 },

        -- Helper Functions
        T{ 'HasAbilityData',    nil,    nil },
        T{ 'HasSpellData',      nil,    nil },
        T{ 'HasAbility',        T{ 5 }, nil },
        T{ 'HasPetCommand',     T{ 0 }, nil },
        T{ 'HasSpell',          T{ 0 }, nil },
        T{ 'HasTrait',          T{ 0 }, nil },
        T{ 'HasWeaponSkill',    T{ 0 }, nil },
        T{ 'HasKeyItem',        T{ 0 }, nil },
    };

    funcs:each(function (n)
        local f = player[n[1]];
        assert(f ~= nil, ('Failed to locate expected function: %s'):fmt(n[1]));

        -- Call the function..
        local v = nil;
        if (n[2] ~= nil) then
            v = f(player, n[2]:unpack());
        else
            v = f(player);
        end

        assert(v ~= nil, ('%s returned an unexpected value.'):fmt(n[1]));
        if (n[3] ~= nil) then
            assert(v == n[3], ('%s returned an unexpected value. (%s)'):fmt(n[1], tostring(v)));
        end
    end);


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
    assert(player:GetHomepoint() == p.Homepoint, 'Homepoint returned an unexpected value.');
    assert(player:GetNation() == p.Nation, 'Nation returned an unexpected value.');
    assert(player:GetResidence() == p.Residence, 'Residence returned an unexpected value.');
    assert(player:GetSuLevel() == p.SuLevel, 'SuLevel returned an unexpected value.');
    assert(player:GetHighestItemLevel() == p.HighestItemLevel, 'HighestItemLevel returned an unexpected value.');
    assert(player:GetItemLevel() == p.ItemLevel, 'ItemLevel returned an unexpected value.');
    assert(player:GetMainHandItemLevel() == p.MainHandItemLevel, 'MainHandItemLevel returned an unexpected value.');
    assert(player:GetUnityFaction() == p.UnityInfo.Faction, 'UnityInfo returned an unexpected value.');
    assert(player:GetUnityPoints() == p.UnityInfo.Points, 'UnityInfo returned an unexpected value.');
    assert(player:GetUnityPartialPersonalEvalutionPoints() == p.UnityPartialPersonalEvalutionPoints, 'UnityPartialPersonalEvalutionPoints returned an unexpected value.');
    assert(player:GetUnityPersonalEvaluationPoints() == p.UnityPersonalEvaluationPoints, 'UnityPersonalEvaluationPoints returned an unexpected value.');
    assert(player:GetUnityChatColorFlag() == p.UnityChatColorFlag, 'UnityChatColorFlag returned an unexpected value.');
    assert(player:GetMasteryJob() == p.MasteryJob, 'MasteryJob returned an unexpected value.');
    assert(player:GetMasteryJobLevel() == p.MasteryJobLevel, 'MasteryJobLeve returned an unexpected value.');
    assert(player:GetMasteryFlags() == p.MasteryFlags, 'MasteryFlags returned an unexpected value.');
    assert(player:GetMasteryUnknown0000() == p.MasteryUnknown0000, 'MasteryUnknown0000 returned an unexpected value.');
    assert(player:GetMasteryExp() == p.MasteryExp, 'MasteryExp returned an unexpected value.');
    assert(player:GetMasteryExpNeeded() == p.MasteryExpNeeded, 'MasteryExpNeeded returned an unexpected value.');
    assert(player:GetCombatSkill(1).Raw == p.CombatSkills.HandToHand.Raw, 'CombatSkills returned an unexpected value.');
    assert(player:GetCraftSkill(0).Raw == p.CraftSkills.Fishing.Raw, 'CraftSkills returned an unexpected value.');
    assert(player:GetAbilityRecast(0) == p.AbilityInfo[1].Recast, 'AbilityInfo returned an unexpected value.');
    assert(player:GetAbilityRecastTimerId(0) == p.AbilityInfo[1].TimerId, 'AbilityInfo returned an unexpected value.');
    assert(player:GetMountRecast() == p.MountRecast.Recast, 'MountRecast returned an unexpected value.');
    assert(player:GetMountRecastTimerId() == p.MountRecast.TimerId, 'MountRecast returned an unexpected value.');
    assert(player:GetDataLoadedFlags() == p.DataLoadedFlags, 'DataLoadedFlags returned an unexpected value.');
    assert(player:GetLimitPoints() == p.LimitPoints, 'LimitPoints returned an unexpected value.');
    assert(player:GetMeritPoints() == p.MeritPoints, 'MeritPoints returned an unexpected value.');
    assert(player:GetAssimilationPoints() == p.AssimilationPoints, 'AssimilationPoints returned an unexpected value.');
    assert(player:GetIsLimitBreaker() == p.IsLimitBreaker, 'IsLimitBreaker returned an unexpected value.');
    assert(player:GetIsExperiencePointsLocked() == p.IsExperiencePointsLocked, 'IsExperiencePointsLocked returned an unexpected value.');
    assert(player:GetIsLimitModeEnabled() == p.IsLimitModeEnabled, 'IsLimitModeEnabled returned an unexpected value.');
    assert(player:GetMeritPointsMax() == p.MeritPointsMax, 'MeritPointsMax returned an unexpected value.');
    assert(player:GetCapacityPoints(0) == p.JobPoints.Jobs[1].CapacityPoints, 'CapacityPoints returned an unexpected value.');
    assert(player:GetJobPoints(0) == p.JobPoints.Jobs[1].Points, 'Points returned an unexpected value.');
    assert(player:GetJobPointsSpent(0) == p.JobPoints.Jobs[1].PointsSpent, 'PointsSpent returned an unexpected value.');
    assert(player:GetHomepointMasks() == p.HomepointMasks, 'HomepointMasks returned an unexpected value.');
    assert(player:GetStatusIcons()[1] == p.StatusIcons[1], 'StatusIcons returned an unexpected value.');
    assert(player:GetStatusTimers()[1] == p.StatusTimers[1], 'StatusTimers returned an unexpected value.');
    assert(player:GetIsZoning() == p.IsZoning, 'IsZoning returned an unexpected value.');
    assert(player:GetBuffs()[1] == p.Buffs[1], 'Buffs returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
end

-- Return the test module table..
return test;