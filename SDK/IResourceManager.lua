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

local d3d8  = require 'd3d8';
local ffi   = require 'ffi';

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
    -- Cleanup the test primitive..
    local pmgr = AshitaCore:GetPrimitiveManager();
    if (pmgr ~= nil) then
        pmgr:Delete('sdktest_resourceprim');
    end
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local rmgr = AshitaCore:GetResourceManager();
    assert(rmgr ~= nil, 'GetResourceManager returned an unexpected value.');

    --[[
    IAbility Object Testing
    --]]

    -- Obtain the Provoke ability using the various functions..
    local ability1 = rmgr:GetAbilityById(547);
    local ability2 = rmgr:GetAbilityByName('Provoke', 0);
    local ability3 = rmgr:GetAbilityByName('Provoke', 2);
    local ability4 = rmgr:GetAbilityByTimerId(5);

    assert(ability1 ~= nil, 'GetAbilityById returned an unexpected value.');
    assert(ability2 ~= nil, 'GetAbilityByName returned an unexpected value.');
    assert(ability3 ~= nil, 'GetAbilityByName returned an unexpected value.');

    -- Validates the given ability against known information for the 'Provoke' ability..
    local function test_ability_info(a)
        assert(a.Id == 547, 'Id returned an unexpected value.');
        assert(a.Type == 1, 'Type returned an unexpected value.');
        assert(a.Element == 41, 'Element returned an unexpected value.');
        assert(a.ListIconId == 360, 'ListIconId returned an unexpected value.');
        assert(a.ManaCost == 0, 'ManaCost returned an unexpected value.');
        assert(a.RecastTimerId == 5, 'RecastTimerId returned an unexpected value.');
        assert(a.Targets == 32, 'Targets returned an unexpected value.');
        assert(a.TPCost == -1, 'TPCost returned an unexpected value.');
        assert(a.MenuCategoryId == 0, 'MenuCategoryId returned an unexpected value.');
        assert(a.MonsterLevel == 0, 'MonsterLevel returned an unexpected value.');
        assert(a.Range == 11, 'Range returned an unexpected value.');
        assert(a.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(a.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(a.CursorTargetType == 13, 'CursorTargetType returned an unexpected value.');
        assert(a.EOE == 255, 'EOE returned an unexpected value.');
        assert(a.Name[3] == 'Provoke', 'Name returned an unexpected value.');
        assert(a.Description[3] == 'Goads an enemy into attacking you.', 'Description returned an unexpected value.');
    end

    test_ability_info(ability1);
    test_ability_info(ability2);
    test_ability_info(ability3);
    test_ability_info(ability4);

    --[[
    ISpell Object Testing
    --]]

    -- Obtain the Cure spell using the various functions..
    local spell1 = rmgr:GetSpellById(1);
    local spell2 = rmgr:GetSpellByName('Cure', 0);
    local spell3 = rmgr:GetSpellByName('Cure', 2);

    assert(spell1 ~= nil, 'GetSpellById returned an unexpected value.');
    assert(spell2 ~= nil, 'GetSpellByName returned an unexpected value.');
    assert(spell3 ~= nil, 'GetSpellByName returned an unexpected value.');

    -- Validates the given spell against known information for the 'Cure' spell..
    local function test_spell_info(s)
        assert(s.Index == 1, 'Index returned an unexpected value.');
        assert(s.Type == 1, 'Type returned an unexpected value.');
        assert(s.Element == 6, 'Element returned an unexpected value.');
        assert(s.Targets == 63, 'Targets returned an unexpected value.');
        assert(s.Skill == 33, 'Skill returned an unexpected value.');
        assert(s.ManaCost == 8, 'ManaCost returned an unexpected value.');
        assert(s.CastTime == 8, 'CastTime returned an unexpected value.');
        assert(s.RecastDelay == 20, 'RecastDelay returned an unexpected value.');

        local levels    = T{ -1, -1, -1, 1, -1, 3, -1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 5, -1, -1, 1 };
        local slevels   = table.range(1, 25):map(function (v) return s.LevelRequired[v]; end);
        assert(levels:equals(slevels), 'LevelRequired returned an unexpected value.');

        assert(s.Id == 1, 'Id returned an unexpected value.');
        assert(s.ListIconNQ == 6, 'ListIconNQ returned an unexpected value.');
        assert(s.ListIconHQ == 86, 'ListIconHQ returned an unexpected value.');
        assert(s.Requirements == 1, 'Requirements returned an unexpected value.');
        assert(s.Range == 12, 'Range returned an unexpected value.');
        assert(s.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(s.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(s.CursorTargetType == 0, 'CursorTargetType returned an unexpected value.');
        assert(s.AreaFlags == 8388865, 'AreaFlags returned an unexpected value.');
        assert(s.JobPointMask == 0, 'JobPointMask returned an unexpected value.');
        assert(s.EOE == 255, 'EOE returned an unexpected value.');
        assert(s.Name[3] == 'Cure', 'Name returned an unexpected value.');
        assert(s.Description[3], 'Description returned an unexpected value.');
    end

    test_spell_info(spell1);
    test_spell_info(spell2);
    test_spell_info(spell3);

    --[[
    IItem Object Testing
    --]]

    -- Obtain the 'Dalmatica' item using the various functions..
    local item1 = rmgr:GetItemById(13787);
    local item2 = rmgr:GetItemByName('Dalmatica', 0);
    local item3 = rmgr:GetItemByName('Dalmatica', 2);

    assert(item1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(item2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(item3 ~= nil, 'GetItemByName returned an unexpected value.');

    -- Validates the given item against known information for the 'Dalmatica' item..
    local function test_armor_item_info(i)
        assert(i.Id == 13787, 'Id returned an unexpected value.');
        assert(i.Flags == 63572, 'Flags returned an unexpected value.');
        assert(i.StackSize == 1, 'StackSize returned an unexpected value.');
        assert(i.Type == 5, 'Type returned an unexpected value.');
        assert(i.ResourceId == 50227, 'ResourceId returned an unexpected value.');
        assert(i.Targets == 0, 'Targets returned an unexpected value.');

        assert(i.Level == 73, 'Level returned an unexpected value.');
        assert(i.Slots == 32, 'Slots returned an unexpected value.');
        assert(i.Races == 510, 'Races returned an unexpected value.');
        assert(i.Jobs == 2131000, 'Jobs returned an unexpected value.');
        assert(i.SuperiorLevel == 0, 'SuperiorLevel returned an unexpected value.');
        assert(i.ShieldSize == 0, 'ShieldSize returned an unexpected value.');
        assert(i.MaxCharges == 0, 'MaxCharges returned an unexpected value.');
        assert(i.CastTime == 0, 'CastTime returned an unexpected value.');
        assert(i.CastDelay == 0, 'CastDelay returned an unexpected value.');
        assert(i.RecastDelay == 0, 'RecastDelay returned an unexpected value.');
        assert(i.BaseItemId == 0, 'BaseItemId returned an unexpected value.');
        assert(i.ItemLevel == 0, 'ItemLevel returned an unexpected value.');
        assert(i.Damage == 0, 'Damage returned an unexpected value.');
        assert(i.Delay == 0, 'Delay returned an unexpected value.');
        assert(i.DPS == 0, 'DPS returned an unexpected value.');
        assert(i.Skill == 0, 'Skill returned an unexpected value.');
        assert(i.JugSize == 0, 'JugSize returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 1, 'AreaCursorTargetType returned an unexpected value.');

        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');

        local mon_data = T{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
        local mon_abilities = table.range(1, 16):map(function (v) local a = i.MonstrosityAbilities[v]; return a.AbilityId == 0 and a.Level == 0 and a.Unknown0000 == 0; end);

        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(i.MonstrosityData:bytes():equals(mon_data), 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(mon_abilities:all(), 'MonstrosityAbilities returned an unexpected value.');

        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');

        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');

        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');

        assert(i.Name[3] == 'Dalmatica', 'Name returned an unexpected value.');
        assert((i.Description[3]):sub(1, 6) == 'DEF:45', 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == 'dalmatica', 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == 'dalmaticas', 'LogNamePlural returned an unexpected value.');
    end

    test_armor_item_info(item1);
    test_armor_item_info(item2);
    test_armor_item_info(item3);

    -- Obtain the 'Kraken Club' item using the various functions..
    item1 = rmgr:GetItemById(17440);
    item2 = rmgr:GetItemByName('Kraken Club', 0);
    item3 = rmgr:GetItemByName('Kraken Club', 2);

    assert(item1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(item2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(item3 ~= nil, 'GetItemByName returned an unexpected value.');

    -- Validates the given item against known information for the 'Kraken Club' item..
    local function test_weapon_item_info(i)
        assert(i.Id == 17440, 'Id returned an unexpected value.');
        assert(i.Flags == 34816, 'Flags returned an unexpected value.');
        assert(i.StackSize == 1, 'StackSize returned an unexpected value.');
        assert(i.Type == 4, 'Type returned an unexpected value.');
        assert(i.ResourceId == 11037, 'ResourceId returned an unexpected value.');
        assert(i.Targets == 0, 'Targets returned an unexpected value.');

        assert(i.Level == 63, 'Level returned an unexpected value.');
        assert(i.Slots == 3, 'Slots returned an unexpected value.');
        assert(i.Races == 510, 'Races returned an unexpected value.');
        assert(i.Jobs == 65534, 'Jobs returned an unexpected value.');
        assert(i.SuperiorLevel == 0, 'SuperiorLevel returned an unexpected value.');
        assert(i.ShieldSize == 0, 'ShieldSize returned an unexpected value.');
        assert(i.MaxCharges == 0, 'MaxCharges returned an unexpected value.');
        assert(i.CastTime == 0, 'CastTime returned an unexpected value.');
        assert(i.CastDelay == 0, 'CastDelay returned an unexpected value.');
        assert(i.RecastDelay == 0, 'RecastDelay returned an unexpected value.');
        assert(i.BaseItemId == 0, 'BaseItemId returned an unexpected value.');
        assert(i.ItemLevel == 0, 'ItemLevel returned an unexpected value.');
        assert(i.Damage == 11, 'Damage returned an unexpected value.');
        assert(i.Delay == 264, 'Delay returned an unexpected value.');
        assert(i.DPS == 250, 'DPS returned an unexpected value.');
        assert(i.Skill == 11, 'Skill returned an unexpected value.');
        assert(i.JugSize == 0, 'JugSize returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 1, 'AreaCursorTargetType returned an unexpected value.');

        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');

        local mon_data = T{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
        local mon_abilities = table.range(1, 16):map(function (v) local a = i.MonstrosityAbilities[v]; return a.AbilityId == 0 and a.Level == 0 and a.Unknown0000 == 0; end);

        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(i.MonstrosityData:bytes():equals(mon_data), 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(mon_abilities:all(), 'MonstrosityAbilities returned an unexpected value.');

        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');

        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');

        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');

        assert(i.Name[3] == 'Kraken Club', 'Name returned an unexpected value.');
        assert(string.sub(i.Description[3], 1, 6) == 'DMG:11', 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == 'kraken club', 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == 'kraken clubs', 'LogNamePlural returned an unexpected value.');
    end

    test_weapon_item_info(item1);
    test_weapon_item_info(item2);
    test_weapon_item_info(item3);

    -- Obtain the 'Galkan Sausage' item using the various functions..
    item1 = rmgr:GetItemById(4395);
    item2 = rmgr:GetItemByName('Galkan Sausage', 0);
    item3 = rmgr:GetItemByName('Galkan Sausage', 2);

    assert(item1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(item2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(item3 ~= nil, 'GetItemByName returned an unexpected value.');

    -- Validates the given item against known information for the 'Galkan Sausage' item..
    local function test_usable_item_info(i)
        assert(i.Id == 4395, 'Id returned an unexpected value.');
        assert(i.Flags == 1548, 'Flags returned an unexpected value.');
        assert(i.StackSize == 12, 'StackSize returned an unexpected value.');
        assert(i.Type == 7, 'Type returned an unexpected value.');
        assert(i.ResourceId == 200, 'ResourceId returned an unexpected value.');
        assert(i.Targets == 1, 'Targets returned an unexpected value.');

        assert(i.Level == 0, 'Level returned an unexpected value.');
        assert(i.Slots == 0, 'Slots returned an unexpected value.');
        assert(i.Races == 0, 'Races returned an unexpected value.');
        assert(i.Jobs == 0, 'Jobs returned an unexpected value.');
        assert(i.SuperiorLevel == 0, 'SuperiorLevel returned an unexpected value.');
        assert(i.ShieldSize == 0, 'ShieldSize returned an unexpected value.');
        assert(i.MaxCharges == 0, 'MaxCharges returned an unexpected value.');
        assert(i.CastTime == 4, 'CastTime returned an unexpected value.');
        assert(i.CastDelay == 0, 'CastDelay returned an unexpected value.');
        assert(i.RecastDelay == 0, 'RecastDelay returned an unexpected value.');
        assert(i.BaseItemId == 0, 'BaseItemId returned an unexpected value.');
        assert(i.ItemLevel == 0, 'ItemLevel returned an unexpected value.');
        assert(i.Damage == 0, 'Damage returned an unexpected value.');
        assert(i.Delay == 0, 'Delay returned an unexpected value.');
        assert(i.DPS == 0, 'DPS returned an unexpected value.');
        assert(i.Skill == 0, 'Skill returned an unexpected value.');
        assert(i.JugSize == 0, 'JugSize returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 0, 'AreaCursorTargetType returned an unexpected value.');

        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');

        local mon_data = T{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
        local mon_abilities = table.range(1, 16):map(function (v) local a = i.MonstrosityAbilities[v]; return a.AbilityId == 0 and a.Level == 0 and a.Unknown0000 == 0; end);

        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(i.MonstrosityData:bytes():equals(mon_data), 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(mon_abilities:all(), 'MonstrosityAbilities returned an unexpected value.');

        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');

        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');

        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 1, 'UsableData0002 returned an unexpected value.');

        assert(i.Name[3] == 'Galkan Sausage', 'Name returned an unexpected value.');
        assert(string.sub(i.Description[3], 1, 6) == 'A trad', 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == 'Galkan sausage', 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == 'Galkan sausages', 'LogNamePlural returned an unexpected value.');
    end

    test_usable_item_info(item1);
    test_usable_item_info(item2);
    test_usable_item_info(item3);

    -- Obtain the 'Behemoth' monstrosity item using the various functions..
    item1 = rmgr:GetItemById(61442);
    item2 = rmgr:GetItemByName('Behemoth', 0);
    item3 = rmgr:GetItemByName('Behemoth', 2);

    assert(item1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(item2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(item3 ~= nil, 'GetItemByName returned an unexpected value.');

    -- Validates the given item against known information for the 'Behemoth' item..
    local function test_monstrosity_item_info(i)
        assert(i.Id == 61442, 'Id returned an unexpected value.');
        assert(i.Flags == 0, 'Flags returned an unexpected value.');
        assert(i.StackSize == 0, 'StackSize returned an unexpected value.');
        assert(i.Type == 0, 'Type returned an unexpected value.');
        assert(i.ResourceId == 0, 'ResourceId returned an unexpected value.');
        assert(i.Targets == 0, 'Targets returned an unexpected value.');

        assert(i.Level == 0, 'Level returned an unexpected value.');
        assert(i.Slots == 0, 'Slots returned an unexpected value.');
        assert(i.Races == 0, 'Races returned an unexpected value.');
        assert(i.Jobs == 0, 'Jobs returned an unexpected value.');
        assert(i.SuperiorLevel == 0, 'SuperiorLevel returned an unexpected value.');
        assert(i.ShieldSize == 0, 'ShieldSize returned an unexpected value.');
        assert(i.MaxCharges == 0, 'MaxCharges returned an unexpected value.');
        assert(i.CastTime == 0, 'CastTime returned an unexpected value.');
        assert(i.CastDelay == 0, 'CastDelay returned an unexpected value.');
        assert(i.RecastDelay == 0, 'RecastDelay returned an unexpected value.');
        assert(i.BaseItemId == 0, 'BaseItemId returned an unexpected value.');
        assert(i.ItemLevel == 0, 'ItemLevel returned an unexpected value.');
        assert(i.Damage == 0, 'Damage returned an unexpected value.');
        assert(i.Delay == 0, 'Delay returned an unexpected value.');
        assert(i.DPS == 0, 'DPS returned an unexpected value.');
        assert(i.Skill == 0, 'Skill returned an unexpected value.');
        assert(i.JugSize == 0, 'JugSize returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 0, 'AreaCursorTargetType returned an unexpected value.');

        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');

        local mon_data = T{ 0x0D, 0x00, 0x02, 0x00, 0x05, 0x00, 0x02, 0x00, 0x02, 0x00, };
        local mon_abilities = T{
            [1] = { id = 444,   lvl = 1,    unk = 255,  },
            [2] = { id = 445,   lvl = 40,   unk = 255,  },
            [3] = { id = 446,   lvl = 10,   unk = 255,  },
            [4] = { id = 447,   lvl = 20,   unk = 255,  },
            [5] = { id = 448,   lvl = 30,   unk = 255,  },
            [6] = { id = 449,   lvl = 50,   unk = 255,  },
            [7] = { id = 0,     lvl = 0,    unk = 0,    },
            [8] = { id = 0,     lvl = 0,    unk = 0,    },
            [9] = { id = 0,     lvl = 0,    unk = 0,    },
            [10]= { id = 0,     lvl = 0,    unk = 0,    },
            [11]= { id = 0,     lvl = 0,    unk = 0,    },
            [12]= { id = 0,     lvl = 0,    unk = 0,    },
            [13]= { id = 0,     lvl = 0,    unk = 0,    },
            [14]= { id = 0,     lvl = 0,    unk = 0,    },
            [15]= { id = 0,     lvl = 0,    unk = 0,    },
            [16]= { id = 0,     lvl = 0,    unk = 0,    },
        };
        local has_abilities = table.range(1, 16):all(function (v)
            local a = i.MonstrosityAbilities[v];
            return a.AbilityId == mon_abilities[v].id and a.Level == mon_abilities[v].lvl and a.Unknown0000 == mon_abilities[v].unk;
        end);

        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 2, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == 'Behemoth', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(i.MonstrosityData:bytes():equals(mon_data), 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(has_abilities == true, 'MonstrosityAbilities returned an unexpected value.');

        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');

        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');

        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');

        assert(i.Name[3] == 'Behemoth', 'Name returned an unexpected value.');
        assert(i.Description[3] == nil, 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == nil, 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == nil, 'LogNamePlural returned an unexpected value.');
    end

    test_monstrosity_item_info(item1);
    test_monstrosity_item_info(item2);
    test_monstrosity_item_info(item3);

    -- Obtain the 'Gil' item using the various functions..
    item1 = rmgr:GetItemById(65535);
    item2 = rmgr:GetItemByName('Gil', 0);
    item3 = rmgr:GetItemByName('Gil', 2);

    assert(item1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(item2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(item3 ~= nil, 'GetItemByName returned an unexpected value.');

    -- Validates the given item against known information for the 'Gil' item..
    local function test_currency_item_info(i)
        assert(i.Id == 65535, 'Id returned an unexpected value.');
        assert(i.Flags == 0, 'Flags returned an unexpected value.');
        assert(i.StackSize == 57599, 'StackSize returned an unexpected value.');
        assert(i.Type == 9, 'Type returned an unexpected value.');
        assert(i.ResourceId == 0, 'ResourceId returned an unexpected value.');
        assert(i.Targets == 0, 'Targets returned an unexpected value.');

        assert(i.Level == 0, 'Level returned an unexpected value.');
        assert(i.Slots == 0, 'Slots returned an unexpected value.');
        assert(i.Races == 0, 'Races returned an unexpected value.');
        assert(i.Jobs == 0, 'Jobs returned an unexpected value.');
        assert(i.SuperiorLevel == 0, 'SuperiorLevel returned an unexpected value.');
        assert(i.ShieldSize == 0, 'ShieldSize returned an unexpected value.');
        assert(i.MaxCharges == 0, 'MaxCharges returned an unexpected value.');
        assert(i.CastTime == 0, 'CastTime returned an unexpected value.');
        assert(i.CastDelay == 0, 'CastDelay returned an unexpected value.');
        assert(i.RecastDelay == 0, 'RecastDelay returned an unexpected value.');
        assert(i.BaseItemId == 0, 'BaseItemId returned an unexpected value.');
        assert(i.ItemLevel == 0, 'ItemLevel returned an unexpected value.');
        assert(i.Damage == 0, 'Damage returned an unexpected value.');
        assert(i.Delay == 0, 'Delay returned an unexpected value.');
        assert(i.DPS == 0, 'DPS returned an unexpected value.');
        assert(i.Skill == 0, 'Skill returned an unexpected value.');
        assert(i.JugSize == 0, 'JugSize returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 0, 'AreaCursorTargetType returned an unexpected value.');

        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');

        local mon_data = T{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
        local mon_abilities = table.range(1, 16):map(function (v) local a = i.MonstrosityAbilities[v]; return a.AbilityId == 0 and a.Level == 0 and a.Unknown0000 == 0; end);

        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(i.MonstrosityData:bytes():equals(mon_data), 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(mon_abilities:all(), 'MonstrosityAbilities returned an unexpected value.');

        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');

        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');

        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');

        assert(i.Name[3] == 'Gil', 'Name returned an unexpected value.');
        assert((i.Description[3]):sub(1, 6) == 'The cu', 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == 'Gil', 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == 'Gils', 'LogNamePlural returned an unexpected value.');
    end

    test_currency_item_info(item1);
    test_currency_item_info(item2);
    test_currency_item_info(item3);

    -- Test the 'Gil' item bitmap information..

    assert(item1.ImageSize >= 2000, 'ImageSize returned an unexpected value.');
    assert(item1.ImageType == 145, 'ImageType returned an unexpected value.');
    assert(item1.ImageName == 'coin    coin    ', 'ImageName returned an unexpected value.');
    assert(#item1.Bitmap == 2432, 'Bitmap returned an unexpected value.');

    --[[
    IStatusIcon Object Testing
    --]]

    sicon1 = rmgr:GetStatusIconByIndex(1);  -- Weakness
    sicon2 = rmgr:GetStatusIconById(1);     -- Weakness
    sicon3 = rmgr:GetStatusIconByIndex(187);-- Sublimation

    assert(sicon1 ~= nil, 'GetStatusIconByIndex returned an unexpected value.');
    assert(sicon2 ~= nil, 'GetStatusIconById returned an unexpected value.');
    assert(sicon3 ~= nil, 'GetStatusIconByIndex returned an unexpected value.');

    assert(sicon1.Index == 1, 'Index returned an unexpected value.');
    assert(sicon1.Id == 1, 'Id returned an unexpected value.');
    assert(sicon1.CanCancel == 0, 'CanCancel returned an unexpected value.');
    assert(sicon1.HideTimer == 0, 'HideTimer returned an unexpected value.');
    assert(sicon1.Description[3] == 'You are in a weakened state.', 'Description returned an unexpected value.');
    assert(sicon1.ImageSize == 4153, 'ImageSize returned an unexpected value.');
    assert(sicon1.ImageType == 145, 'ImageType returned an unexpected value.');
    assert(sicon1.ImageName == 'sts_iconst01_32 ', 'ImageName returned an unexpected value.');
    assert(#sicon1.Bitmap == 5482, 'Bitmap returned an unexpected value.');

    assert(sicon2.Index == 1, 'Index returned an unexpected value.');
    assert(sicon2.Id == 1, 'Id returned an unexpected value.');
    assert(sicon2.CanCancel == 0, 'CanCancel returned an unexpected value.');
    assert(sicon2.HideTimer == 0, 'HideTimer returned an unexpected value.');
    assert(sicon2.Description[3] == 'You are in a weakened state.', 'Description returned an unexpected value.');

    assert(sicon3.Index == 187, 'Index returned an unexpected value.');
    assert(sicon3.Id == 187, 'Id returned an unexpected value.');
    assert(sicon3.CanCancel == 0, 'CanCancel returned an unexpected value.');
    assert(sicon3.HideTimer == 1, 'HideTimer returned an unexpected value.');
    assert(sicon3.Description[3] == 'You are gradually losing HP while accumulating a store of MP.', 'Description returned an unexpected value.');

    --[[
    String Resource Testing
    --]]

    local str1 = rmgr:GetString('spells.names', 1);
    local str2 = rmgr:GetString('spells.names', 1, 3);

    assert(str1 == 'Cure', 'GetString returned an unexpected value.');
    assert(str2 == 'Cure', 'GetString returned an unexpected value.');

    str1 = rmgr:GetString('spells.names', 'Cure');
    str2 = rmgr:GetString('spells.names', 'Cure', 3);

    assert(str1 == 1, 'GetString returned an unexpected value.');
    assert(str2 == 1, 'GetString returned an unexpected value.');

    str1 = rmgr:GetStringLength('spells.names', 1);
    str2 = rmgr:GetStringLength('spells.names', 1, 3);

    assert(str1 == 4, 'GetStringLength returned an unexpected value.');
    assert(str2 == 4, 'GetStringLength returned an unexpected value.');

    --[[
    Helper Function Testing
    --]]

    -- Test file path helper..
    local path = rmgr:GetFilePath(55467); -- English Job Names
    assert(path ~= nil, 'GetFilePath returned an unexpected value.');
    assert(type(path) == 'string', 'GetFilePath returned an unexpected value.');
    -- Note: The returned path can be formatted differently based on the operating system being used!
    assert(ashita.fs.normalize(path):gsub('/', '\\'):lower():endswith('\\165\\86.dat'), 'GetFilePath returned an unexpected value.');

    -- Test ability range helper..
    local range1 = rmgr:GetAbilityRange(547, false);    -- Provoke
    local range2 = rmgr:GetAbilityRange(547, true);     -- Provoke (AoE)
    local range3 = rmgr:GetAbilityRange(559, false);    -- Holy Circle
    local range4 = rmgr:GetAbilityRange(559, true);     -- Holy Circle (AoE)

    assert(range1 == 16, 'GetAbilityRange returned an unexpected value.');
    assert(range2 == 0, 'GetAbilityRange returned an unexpected value.');
    assert(range3 == 0, 'GetAbilityRange returned an unexpected value.');
    assert(range4 == 10, 'GetAbilityRange returned an unexpected value.');

    -- Test ability type helper..
    local type1 = rmgr:GetAbilityType(547); -- Provoke
    local type2 = rmgr:GetAbilityType(559); -- Holy Circle

    assert(type1 == 3, 'GetAbilityType returned an unexpected value.');
    assert(type2 == 7, 'GetAbilityType returned an unexpected value.');

    -- Test spell range helper..
    range1 = rmgr:GetSpellRange(1, false);  -- Cure
    range2 = rmgr:GetSpellRange(1, true);   -- Cure (AoE)
    range3 = rmgr:GetSpellRange(7, false);  -- Curaga
    range4 = rmgr:GetSpellRange(7, true);   -- Curaga (AoE)

    assert(range1 == 20, 'GetSpellRange returned an unexpected value.');
    assert(range2 == 0, 'GetSpellRange returned an unexpected value.');
    assert(range3 == 20, 'GetSpellRange returned an unexpected value.');
    assert(range4 == 10, 'GetSpellRange returned an unexpected value.');

    --[[
    Resource Texture Testing
    --]]

    -- Test requesting known registered textures..
    local tex1 = rmgr:GetTexture('ashita');
    local tex2 = rmgr:GetTexture('icons');

    assert(tex1 ~= nil, 'GetTexture returned an unexpected value.');
    assert(tex2 ~= nil, 'GetTexture returned an unexpected value.');

    tex2 = rmgr:GetTextureInfo('icons');

    assert(tex2 ~= nil, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.width == 512, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.height == 512, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.depth == 1, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.mip_levels == 1, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.format == ffi.C.D3DFMT_A8R8G8B8, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.resource_type == ffi.C.D3DRTYPE_TEXTURE, 'GetTextureInfo returned an unexpected value.');
    assert(tex2.image_file_format == ffi.C.D3DXIFF_PNG, 'GetTextureInfo returned an unexpected value.');

    local pmgr = AshitaCore:GetPrimitiveManager();
    assert(pmgr ~= nil, 'GetPrimitiveManager returned an unexpected value.');

    -- Create a test primitive..
    local prim = pmgr:Create('sdktest_resourceprim');
    assert(prim ~= nil, 'Create returned an unexpected value.');
    prim:SetVisible(true);

    local function test_item_icon(id)
        local item = rmgr:GetItemById(id);
        assert(item ~= nil, 'GetItemById returned an unexpected value.');
        prim:SetTextureFromMemory(item.Bitmap, item.ImageSize, 0xFF000000);
        coroutine.sleepf(2);
    end

    -- Test using resource bitmap information with primitives..
    local item_ids = T{ 13787, 17440, 4395, 61442, 65535, };
    item_ids:each(test_item_icon);

    -- Test using status icon bitmap information with primitives..
    local sicon = rmgr:GetStatusIconByIndex(1);
    assert(sicon ~= nil, 'GetStatusIconByIndex returned an unexpected value.');
    prim:SetTextureFromMemory(sicon.Bitmap, sicon.ImageSize, 0xFF000000);
    coroutine.sleepf(2);

    -- Test using resource textures with primitives..
    prim:SetTextureFromResourceCache('ashita');
    coroutine.sleepf(2);
    prim:SetTextureFromResourceCache('icons');
    coroutine.sleepf(2);

    -- Cleanup..
    pmgr:Delete('sdktest_resourceprim');
end

-- Return the test module table..
return test;

--[[
Untested:

    IAbility::Unknown0000
    IAbility::Unknown0001
    IAbility::Unknown0002
    IAbility::Unknown0003
    IAbility::Unknown0004
    IAbility::Unknown0005
    IAbility::Unknown0006
    IAbility::Unknown0007
    IAbility::Unknown0008
    IAbility::Unknown0009

    ISpell::Unknown0000
    ISpell::Unknown0001
    ISpell::Unknown0002
    ISpell::Unknown0003
    ISpell::Unknown0004
    ISpell::Unknown0005

    IItem::WeaponUnknown0000
    IItem::SlipData
--]]