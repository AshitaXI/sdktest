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
    local resManager = AshitaCore:GetResourceManager();
    assert(resManager ~= nil, 'GetResourceManager returned an unexpected value.');

    --[[
    IAbility resource tests..
    --]]

    -- Test requesting an ability..
    local a1 = resManager:GetAbilityById(547);              -- Provoke
    local a2 = resManager:GetAbilityByName('Provoke', 0);   -- Default
    local a3 = resManager:GetAbilityByName('Provoke', 2);   -- English
    local a4 = resManager:GetAbilityByTimerId(5);           -- Provoke Timer Id

    assert(a1 ~= nil, 'GetAbilityById returned an unexpected value.');
    assert(a2 ~= nil, 'GetAbilityByName returned an unexpected value.');
    assert(a3 ~= nil, 'GetAbilityByName returned an unexpected value.');
    assert(a4 ~= nil, 'GetAbilityByTimerId returned an unexpected value.');

    --[[
    * Validates the given ability against known information for the 'Provoke' ability.
    *
    * @param {IAbility} a - The ability object to test.
    --]]
    local function test_ability_info(a)
        assert(a ~= nil, 'invalid argument passed to test function.');
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

    -- Validate all returned data is for Provoke..
    test_ability_info(a1);
    test_ability_info(a2);
    test_ability_info(a3);
    test_ability_info(a4);

    --[[
    ISpell resource tests..
    --]]

    -- Test requesting a spell..
    local s1 = resManager:GetSpellById(1);              -- Cure
    local s2 = resManager:GetSpellByName('Cure', 0);    -- Default
    local s3 = resManager:GetSpellByName('Cure', 2);    -- English

    assert(s1 ~= nil, 'GetSpellById returned an unexpected value.');
    assert(s2 ~= nil, 'GetSpellByName returned an unexpected value.');
    assert(s3 ~= nil, 'GetSpellByName returned an unexpected value.');

    --[[
    * Validates the given spell against known information for the 'Cure' spell.
    *
    * @param {ISpell} s - The spell object to test.
    --]]
    local function test_spell_info(s)
        assert(s ~= nil, 'invalid argument passed to test function.');
        assert(s.Index == 1, 'Index returned an unexpected value.');
        assert(s.Type == 1, 'Type returned an unexpected value.');
        assert(s.Element == 6, 'Element returned an unexpected value.');
        assert(s.Targets == 63, 'Targets returned an unexpected value.');
        assert(s.Skill == 33, 'Skill returned an unexpected value.');
        assert(s.ManaCost == 8, 'ManaCost returned an unexpected value.');
        assert(s.CastTime == 8, 'CastTime returned an unexpected value.');
        assert(s.RecastDelay == 20, 'RecastDelay returned an unexpected value.');

        local levels = {-1, -1, -1, 1, -1, 3, -1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 5, -1, -1, 1};
        for x = 1, #s.LevelRequired do
            assert(levels[x] == s.LevelRequired[x], 'LevelRequired returned an unexpected value.');
        end

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

    -- Validate all returned data is for Cure..
    test_spell_info(s1);
    test_spell_info(s2);
    test_spell_info(s3);

    --[[
    IItem resource tests..
    --]]

    -- Test requesting an armor item.. (Dalmatica)
    local i1 = resManager:GetItemById(13787);               -- Dalmatica
    local i2 = resManager:GetItemByName('Dalmatica', 0);    -- Default
    local i3 = resManager:GetItemByName('Dalmatica', 2);    -- English

    assert(i1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(i2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(i3 ~= nil, 'GetItemByName returned an unexpected value.');

    --[[
    * Validates the given item against known information for the 'Dalmatica' item.
    *
    * @param {IItem} i - The item object to test.
    --]]
    local function test_armor_item_info(i)
        assert(i ~= nil, 'invalid argument passed to test function.');
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
        assert(i.WeaponUnknown0000 == 0, 'WeaponUnknown0000 returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 1, 'AreaCursorTargetType returned an unexpected value.');
        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');
        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');
        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');
        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');
        assert(i.Name[3] == 'Dalmatica', 'Name returned an unexpected value.');
        assert(string.sub(i.Description[3], 1, 6) == 'DEF:45', 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == 'dalmatica', 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == 'dalmaticas', 'LogNamePlural returned an unexpected value.');
    end

    -- Validate all returned data is for Dalmatica..
    test_armor_item_info(i1);
    test_armor_item_info(i2);
    test_armor_item_info(i3);

    -- Test requesting a weapon item.. (Kraken Club)
    i1 = resManager:GetItemById(17440);               -- Kraken Club
    i2 = resManager:GetItemByName('Kraken Club', 0);  -- Default
    i3 = resManager:GetItemByName('Kraken Club', 2);  -- English

    assert(i1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(i2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(i3 ~= nil, 'GetItemByName returned an unexpected value.');

    --[[
    * Validates the given item against known information for the 'Kraken Club' item.
    *
    * @param {IItem} i - The item object to test.
    --]]
    local function test_weapon_item_info(i)
        assert(i ~= nil, 'invalid argument passed to test function.');
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
        assert(i.WeaponUnknown0000 == 0, 'WeaponUnknown0000 returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 1, 'AreaCursorTargetType returned an unexpected value.');
        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');
        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
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

    -- Validate all returned data is for Kraken Club..
    test_weapon_item_info(i1);
    test_weapon_item_info(i2);
    test_weapon_item_info(i3);

    -- Test requesting a usable item.. (Kraken Club)
    i1 = resManager:GetItemById(4395);                    -- Galkan Sausage
    i2 = resManager:GetItemByName('Galkan Sausage', 0);   -- Default
    i3 = resManager:GetItemByName('Galkan Sausage', 2);   -- English

    assert(i1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(i2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(i3 ~= nil, 'GetItemByName returned an unexpected value.');

    --[[
    * Validates the given item against known information for the 'Galkan Sausage' item.
    *
    * @param {IItem} i - The item object to test.
    --]]
    local function test_usable_item_info(i)
        assert(i ~= nil, 'invalid argument passed to test function.');
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
        assert(i.WeaponUnknown0000 == 0, 'WeaponUnknown0000 returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 0, 'AreaCursorTargetType returned an unexpected value.');
        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');
        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
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

    -- Validate all returned data is for Galkan Sausage..
    test_usable_item_info(i1);
    test_usable_item_info(i2);
    test_usable_item_info(i3);

    -- Test requesting a monstrosity item.. (Behemoth)
    i1 = resManager:GetItemById(61442);           -- Behemoth (Monstrosity)
    i2 = resManager:GetItemByName('Behemoth', 0); -- Default
    i3 = resManager:GetItemByName('Behemoth', 2); -- English

    assert(i1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(i2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(i3 ~= nil, 'GetItemByName returned an unexpected value.');

    --[[
    * Validates the given item against known information for the 'Behemoth' monstrosity item.
    *
    * @param {IItem} i - The item object to test.
    --]]
    local function test_monstrosity_item_info(i)
        assert(i ~= nil, 'invalid argument passed to test function.');
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
        assert(i.WeaponUnknown0000 == 0, 'WeaponUnknown0000 returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 0, 'AreaCursorTargetType returned an unexpected value.');
        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');
        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 2, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == 'Behemoth', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');

        local monData = { 0x0D, 0x00, 0x02, 0x00, 0x05, 0x00, 0x02, 0x00, 0x02, 0x00 };
        for x = 1, #i.MonstrosityData do
            assert(string.byte(i.MonstrosityData, x) == monData[x], 'MonstrosityData returned an unexpected value.');
        end

        local monAbilities = {
            [1]  = { id=444,   lvl=1,  unk=255 },
            [2]  = { id=445,   lvl=40, unk=255 },
            [3]  = { id=446,   lvl=10, unk=255 },
            [4]  = { id=447,   lvl=20, unk=255 },
            [5]  = { id=448,   lvl=30, unk=255 },
            [6]  = { id=449,   lvl=50, unk=255 },
            [7]  = { id=0,     lvl=0,  unk=0   },
            [8]  = { id=0,     lvl=0,  unk=0   },
            [9]  = { id=0,     lvl=0,  unk=0   },
            [10] = { id=0,     lvl=0,  unk=0   },
            [11] = { id=0,     lvl=0,  unk=0   },
            [12] = { id=0,     lvl=0,  unk=0   },
            [13] = { id=0,     lvl=0,  unk=0   },
            [14] = { id=0,     lvl=0,  unk=0   },
            [15] = { id=0,     lvl=0,  unk=0   },
            [16] = { id=0,     lvl=0,  unk=0   },
        };

        for x = 1, #i.MonstrosityAbilities do
            assert(i.MonstrosityAbilities[x].AbilityId == monAbilities[x].id, 'AbilityId returned an unexpected value');
            assert(i.MonstrosityAbilities[x].Level == monAbilities[x].lvl, 'Level returned an unexpected value');
            assert(i.MonstrosityAbilities[x].Unknown0000 == monAbilities[x].unk, 'Unknown0000 returned an unexpected value');
        end

        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');
        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');
        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');
        assert(i.Name[3] == 'Behemoth', 'Name returned an unexpected value.');
        assert(i.Description[3] ==  nil, 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == nil, 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == nil, 'LogNamePlural returned an unexpected value.');
    end

    -- Validate all returned data is for Behemoth..
    test_monstrosity_item_info(i1);
    test_monstrosity_item_info(i2);
    test_monstrosity_item_info(i3);

    -- Test requesting a currency item.. (Gil)
    i1 = resManager:GetItemById(65535);       -- Gil
    i2 = resManager:GetItemByName('Gil', 0);  -- Default
    i3 = resManager:GetItemByName('Gil', 2);  -- English

    assert(i1 ~= nil, 'GetItemById returned an unexpected value.');
    assert(i2 ~= nil, 'GetItemByName returned an unexpected value.');
    assert(i3 ~= nil, 'GetItemByName returned an unexpected value.');

    --[[
    * Validates the given item against known information for the 'Gil' currency item.
    *
    * @param {IItem} i - The item object to test.
    --]]
    local function test_currency_item_info(i)
        assert(i ~= nil, 'invalid argument passed to test function.');
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
        assert(i.WeaponUnknown0000 == 0, 'WeaponUnknown0000 returned an unexpected value.');
        assert(i.Range == 0, 'Range returned an unexpected value.');
        assert(i.AreaRange == 0, 'AreaRange returned an unexpected value.');
        assert(i.AreaShapeType == 0, 'AreaShapeType returned an unexpected value.');
        assert(i.AreaCursorTargetType == 0, 'AreaCursorTargetType returned an unexpected value.');
        assert(i.Element == 0, 'Element returned an unexpected value.');
        assert(i.Storage == 0, 'Storage returned an unexpected value.');
        assert(i.AttachmentFlags == 0, 'AttachmentFlags returned an unexpected value.');
        assert(i.InstinctCost == 0, 'InstinctCost returned an unexpected value.');
        assert(i.MonstrosityId == 0, 'MonstrosityId returned an unexpected value.');
        assert(i.MonstrosityName == '', 'MonstrosityName returned an unexpected value.');
        assert(type(i.MonstrosityData) == 'string', 'MonstrosityData returned an unexpected value.');
        assert(type(i.MonstrosityAbilities) == 'userdata', 'MonstrosityAbilities returned an unexpected value.');
        assert(i.PuppetSlotId == 0, 'PuppetSlotId returned an unexpected value.');
        assert(i.PuppetElements == 0, 'PuppetElements returned an unexpected value.');
        assert(type(i.SlipData) == 'string', 'SlipData returned an unexpected value.');
        assert(i.UsableData0000 == 0, 'UsableData0000 returned an unexpected value.');
        assert(i.UsableData0001 == 0, 'UsableData0001 returned an unexpected value.');
        assert(i.UsableData0002 == 0, 'UsableData0002 returned an unexpected value.');
        assert(i.Name[3] == 'Gil', 'Name returned an unexpected value.');
        assert(string.sub(i.Description[3], 1, 6) == 'The cu', 'Description returned an unexpected value.');
        assert(i.LogNameSingular[3] == 'Gil', 'LogNameSingular returned an unexpected value.');
        assert(i.LogNamePlural[3] == 'Gils', 'LogNamePlural returned an unexpected value.');
    end

    -- Validate all returned data is for Gil..
    test_currency_item_info(i1);
    test_currency_item_info(i2);
    test_currency_item_info(i3);

    -- Test the items bitmap data..
    assert(i1.ImageSize >= 2000, 'ImageSize returned an unexpected value.');
    assert(i1.ImageType == 145, 'ImageType returned an unexpected value.');
    assert(i1.ImageName == 'coin    coin    ', 'ImageName returned an unexpected value.');
    assert(#i1.Bitmap == 0x980, 'Bitmap returned an unexpected value.');

    --[[
    IStatusIcon resource tests..
    --]]

    -- Test requesting status icon information..
    s1 = resManager:GetStatusIconByIndex(1);    -- Weakness
    s2 = resManager:GetStatusIconById(1);       -- Weakness
    s3 = resManager:GetStatusIconByIndex(187);  -- Sublimation

    assert(s1 ~= nil, 'GetStatusIconByIndex returned an unexpected value.');
    assert(s2 ~= nil, 'GetStatusIconById returned an unexpected value.');
    assert(s3 ~= nil, 'GetStatusIconByIndex returned an unexpected value.');

    assert(s1.Index == 1, 'Index returned an unexpected value.');
    assert(s1.Id == 1, 'Id returned an unexpected value.');
    assert(s1.CanCancel == 0, 'CanCancel returned an unexpected value.');
    assert(s1.HideTimer == 0, 'HideTimer returned an unexpected value.');
    assert(s1.Description[3] == 'You are in a weakened state.', 'Description returned an unexpected value.');

    assert(s2.Index == 1, 'Index returned an unexpected value.');
    assert(s2.Id == 1, 'Id returned an unexpected value.');
    assert(s2.CanCancel == 0, 'CanCancel returned an unexpected value.');
    assert(s2.HideTimer == 0, 'HideTimer returned an unexpected value.');
    assert(s2.Description[3] == 'You are in a weakened state.', 'Description returned an unexpected value.');

    assert(s3.Index == 187, 'Index returned an unexpected value.');
    assert(s3.Id == 187, 'Id returned an unexpected value.');
    assert(s3.CanCancel == 0, 'CanCancel returned an unexpected value.');
    assert(s3.HideTimer == 1, 'HideTimer returned an unexpected value.');
    assert(s3.Description[3] == 'You are gradually losing HP while accumulating a store of MP.', 'Description returned an unexpected value.');

    --[[
    String resource tests..
    --]]

    -- Test requesting spell name strings..
    s1 = resManager:GetString('spells.names', 1);    -- Default
    s2 = resManager:GetString('spells.names', 1, 3); -- English

    assert(s1 == 'Cure', 'GetString returned an unexpected value.');
    assert(s2 == 'Cure', 'GetString returned an unexpected value.');

    -- Test requesting spell name string indices..
    s1 = resManager:GetString('spells.names', 'Cure');       -- Default
    s2 = resManager:GetString('spells.names', 'Cure', 3);    -- English

    assert(s1 == 1, 'GetString returned an unexpected value.');
    assert(s2 == 1, 'GetString returned an unexpected value.');

    --[[
    Texture resource tests..
    --]]

    -- Test requesting known registered textures..
    local t1 = resManager:GetTexture('ashita');
    local t2 = resManager:GetTexture('icons');

    assert(t1 ~= nil, 'GetTexture returned an unexpected value.');
    assert(t2 ~= nil, 'GetTexture returned an unexpected value.');

    --[[
    Helper function tests..
    --]]

    -- Test requesting ability ranges..
    local r1 = resManager:GetAbilityRange(547, false);  -- Provoke
    local r2 = resManager:GetAbilityRange(547, true);   -- Provoke (AoE)
    local r3 = resManager:GetAbilityRange(559, false);  -- Holy Circle
    local r4 = resManager:GetAbilityRange(559, true);   -- Holy Circle (AoE)

    assert(r1 == 16, 'GetAbilityRange returned an unexpected value.');
    assert(r2 == 0, 'GetAbilityRange returned an unexpected value.');
    assert(r3 == 0, 'GetAbilityRange returned an unexpected value.');
    assert(r4 == 10, 'GetAbilityRange returned an unexpected value.');

    -- Test requesting spell ranges..
    r1 = resManager:GetSpellRange(1, false);  -- Cure
    r2 = resManager:GetSpellRange(1, true);   -- Cure (AoE)
    r3 = resManager:GetSpellRange(7, false);  -- Curaga
    r4 = resManager:GetSpellRange(7, true);   -- Curaga (AoE)

    assert(r1 == 20, 'GetSpellRange returned an unexpected value.');
    assert(r2 == 0, 'GetSpellRange returned an unexpected value.');
    assert(r3 == 20, 'GetSpellRange returned an unexpected value.');
    assert(r4 == 10, 'GetSpellRange returned an unexpected value.');

    -- Test requesting ability types..
    t1 = resManager:GetAbilityType(547); -- Provoke
    t2 = resManager:GetAbilityType(559); -- Holy Circle

    assert(t1 == 3, 'GetAbilityType returned an unexpected value.');
    assert(t2 == 7, 'GetAbilityType returned an unexpected value.');

    --[[
    Resource image data tests..
    --]]

    -- Obtain the primitive manager..
    local primManager = AshitaCore:GetPrimitiveManager();
    assert(primManager ~= nil, 'GetPrimitiveManager returned an unexpected value.');

    -- Create a test primitive..
    local p = primManager:Create('sdktest_resourceprim');
    assert(p ~= nil, 'Create returned an unexpected value.');
    p:SetVisible(true);

    --[[
    * Renders an items icon via a primitive object.
    *
    * @param {number} id - The item id to render the icon of.
    --]]
    local function test_item_icon(id)
        local i = resManager:GetItemById(id);
        assert(i ~= nil, 'GetItemById returned an unexpected value.');

        p:SetTextureFromMemory(i.Bitmap, i.ImageSize, 0xFF000000);
        coroutine.sleep(0.2);
    end

    -- Render some item icons..
    local item_ids = { 13787, 17440, 4395, 61442, 65535, };
    for _, v in pairs(item_ids) do
        test_item_icon(v);
    end

    -- Obtain the weakness status icon..
    s1 = resManager:GetStatusIconByIndex(1);
    assert(s1 ~= nil, 'GetStatusIconByIndex returned an unexpected value.');

    -- Set the primitive to the weakness status icon..
    p:SetTextureFromMemory(s1.Bitmap, s1.ImageSize, 0xFF000000);
    coroutine.sleep(0.2);

    -- Set the primitive to the Ashita moogle icon that is cached..
    p:SetTextureFromResourceCache('ashita');
    coroutine.sleep(0.2);

    -- Cleanup the test primitive..
    primManager:Delete('sdktest_resourceprim');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Cleanup the test primitive..
    local primManager = AshitaCore:GetPrimitiveManager();
    if (primManager ~= nil) then
        primManager:Delete('sdktest_resourceprim');
    end
end

-- Return the test module table..
return test;