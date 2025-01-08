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
    -- Cleanup the test keybind..
    local inputManager = AshitaCore:GetInputManager();
    if (inputManager ~= nil) then
        local k = inputManager:GetKeyboard();
        if (k ~= nil) then
            k:Unbind(0x58, true, true, false, true, false, false);
        end
    end
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local inputManager = AshitaCore:GetInputManager();
    assert(inputManager ~= nil, 'GetInputManager returned an unexpected value.');

    -- Validate the sub-objects..
    local k = inputManager:GetKeyboard();
    local m = inputManager:GetMouse();
    assert(k ~= nil, 'GetKeyboard returned an unexpected value.');
    assert(m ~= nil, 'GetMouse returned an unexpected value.');

    --[[
    Input Manager Testing
    --]]

    local prev = inputManager:GetAllowGamepadInBackground();
    inputManager:SetAllowGamepadInBackground(not prev);
    local curr = inputManager:GetAllowGamepadInBackground();
    inputManager:SetAllowGamepadInBackground(prev);

    assert(prev ~= curr, 'GetAllowGamepadInBackground returned an unexpected value.');

    prev = inputManager:GetDisableGamepad();
    inputManager:SetDisableGamepad(not prev);
    curr = inputManager:GetDisableGamepad();
    inputManager:SetDisableGamepad(prev);

    assert(prev ~= curr, 'GetDisableGamepad returned an unexpected value.');

    --[[
    Keyboard Testing
    --]]

    -- Test binding a key-combination.. (CTRL+ALT+F10)
    k:Bind(0x58, true, true, false, true, false, false, '/echo sdktest bind was pressed.');
    local bound = k:IsBound(0x58, true, true, false, true, false, false);
    assert(bound == true, 'IsBound returned an unexpected value.');

    -- Test unbinding a key-combination..
    k:Unbind(0x58, true, true, false, true, false, false);
    bound = k:IsBound(0x58, true, true, false, true, false, false);
    assert(bound == false, 'IsBound returned an unexpected value.');

    -- Test key translations..
    local k1 = k:V2D(0x1B); -- Escape
    local k2 = k:D2V(0x01); -- Escape
    local k3 = k:S2D('ESCAPE');
    local k4 = k:D2S(0x01); -- Escape

    assert(k1 == 0x01, 'V2D returned an unexpected value.');
    assert(k2 == 0x1B, 'D2V returned an unexpected value.');
    assert(k3 == 0x01, 'S2D returned an unexpected value.');
    assert(string.lower(k4) == 'escape', 'D2S returned an unexpected value.');

    -- Test keyboard properties..
    prev = k:GetWindowsKeyEnabled();
    k:SetWindowsKeyEnabled(not prev);
    curr = k:GetWindowsKeyEnabled();
    k:SetWindowsKeyEnabled(prev);

    assert(prev ~= curr, 'GetWindowsKeyEnabled returned an unexpected value.');

    prev = k:GetBlockInput();
    k:SetBlockInput(not prev);
    curr = k:GetBlockInput();
    k:SetBlockInput(prev);

    assert(prev ~= curr, 'GetBlockInput returned an unexpected value.');

    prev = k:GetBlockBindsDuringInput();
    k:SetBlockBindsDuringInput(not prev);
    curr = k:GetBlockBindsDuringInput();
    k:SetBlockBindsDuringInput(prev);

    assert(prev ~= curr, 'GetBlockBindsDuringInput returned an unexpected value.');

    prev = k:GetSilentBinds();
    k:SetSilentBinds(not prev);
    curr = k:GetSilentBinds();
    k:SetSilentBinds(prev);

    assert(prev ~= curr, 'GetSilentBinds returned an unexpected value.');

    --[[
    Mouse Testing
    --]]

    -- Test mouse properties..
    prev = m:GetBlockInput();
    m:SetBlockInput(not prev);
    curr = m:GetBlockInput();
    m:SetBlockInput(prev);

    assert(prev ~= curr, 'GetBlockInput returned an unexpected value.');
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetInputManager():GetKeyboard():UnbindAll()

--]]