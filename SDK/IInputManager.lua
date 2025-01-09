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

local chat = require 'chat';

--[[
* The main test module table.
--]]
local test = T{
    skip_bind_test = false,
};

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    if (test.skip_bind_test) then
        return;
    end

    local mgr = AshitaCore:GetInputManager();
    if (mgr == nil) then return; end
    local k = mgr:GetKeyboard();
    if (k == nil) then return; end

    -- Cleanup the test keybind..
    k:Unbind(0x58, true, true, false, true, false, false);
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetInputManager();
    assert(mgr ~= nil, 'GetInputManager returned an unexpected value.');

    -- Validate the manager sub-objects..
    local c = mgr:GetController();
    local k = mgr:GetKeyboard();
    local m = mgr:GetMouse();
    local x = mgr:GetXInput();

    assert(c ~= nil, 'GetController returned an unexpected value.');
    assert(k ~= nil, 'GetKeyboard returned an unexpected value.');
    assert(m ~= nil, 'GetMouse returned an unexpected value.');
    assert(x ~= nil, 'GetXInput returned an unexpected value.');

    --[[
    InputManager Testing
    --]]

    local prev = mgr:GetAllowGamepadInBackground();
    mgr:SetAllowGamepadInBackground(false);
    assert(mgr:GetAllowGamepadInBackground() == false, 'GetAllowGamepadInBackground returned an unexpected value.');
    mgr:SetAllowGamepadInBackground(true);
    assert(mgr:GetAllowGamepadInBackground() == true, 'GetAllowGamepadInBackground returned an unexpected value.');
    mgr:SetAllowGamepadInBackground(prev);

    prev = mgr:GetDisableGamepad();
    mgr:SetDisableGamepad(false);
    assert(mgr:GetDisableGamepad() == false, 'GetDisableGamepad returned an unexpected value.');
    mgr:SetDisableGamepad(true);
    assert(mgr:GetDisableGamepad() == true, 'GetDisableGamepad returned an unexpected value.');
    mgr:SetDisableGamepad(prev);

    --[[
    Keyboard Testing

    Note:   The keybind tests below will make use of the keybind 'CTRL+ALT+F12' when the key is released. However,
            if this key combination is already bound, then keybind testing will be skipped to not overwrite a users
            keybinds.
    --]]

    -- Test if CTRL+ALT+F12 (up) is bound..
    if (k:IsBound(0x58, false, true, false, true, false, false)) then
        print(chat.header('SDKTest')
            :append('\30\81\'\30\06IInputManager\30\81\' ')
            :append(chat.warning('Warning: '))
            :append(chat.message('Keybind tests will be skipped due to existing keybind! ('))
            :append(chat.color1(5, 'CTRL+ALT+F10'))
            :append(chat.message(')')));

        test.skip_bind_test = true;
    else
        -- Test setting a keybind.. (CTRL+ALT+F10)
        k:Bind(0x58, true, true, false, true, false, false, '/echo sdktest bind was pressed.');
        assert(k:IsBound(0x58, true, true, false, true, false, false) == true, 'IsBound returned an unexpected value.');

        -- Test removing a keybind..
        k:Unbind(0x58, true, true, false, true, false, false);
        assert(k:IsBound(0x58, true, true, false, true, false, false) == false, 'IsBound returned an unexpected value.');
    end

    -- Test key translations..
    local key1 = k:V2D(0x1B); -- Escape
    local key2 = k:D2V(0x01); -- Escape
    local key3 = k:S2D('ESCAPE');
    local key4 = k:D2S(0x01); -- Escape

    assert(key1 == 0x01, 'V2D returned an unexpected value.');
    assert(key2 == 0x1B, 'D2V returned an unexpected value.');
    assert(key3 == 0x01, 'S2D returned an unexpected value.');
    assert(key4:lower() == 'escape', 'D2S returned an unexpected value.');

    -- Test keyboard properties..
    prev = k:GetWindowsKeyEnabled();
    k:SetWindowsKeyEnabled(false);
    assert(k:GetWindowsKeyEnabled() == false, 'GetWindowsKeyEnabled returned an unexpected value.');
    k:SetWindowsKeyEnabled(true);
    assert(k:GetWindowsKeyEnabled() == true, 'GetWindowsKeyEnabled returned an unexpected value.');
    k:SetWindowsKeyEnabled(prev);

    prev = k:GetBlockInput();
    k:SetBlockInput(false);
    assert(k:GetBlockInput() == false, 'GetBlockInput returned an unexpected value.');
    k:SetBlockInput(true);
    assert(k:GetBlockInput() == true, 'GetBlockInput returned an unexpected value.');
    k:SetBlockInput(prev);

    prev = k:GetBlockBindsDuringInput();
    k:SetBlockBindsDuringInput(false);
    assert(k:GetBlockBindsDuringInput() == false, 'GetBlockBindsDuringInput returned an unexpected value.');
    k:SetBlockBindsDuringInput(true);
    assert(k:GetBlockBindsDuringInput() == true, 'GetBlockBindsDuringInput returned an unexpected value.');
    k:SetBlockBindsDuringInput(prev);

    prev = k:GetSilentBinds();
    k:SetSilentBinds(false);
    assert(k:GetSilentBinds() == false, 'GetSilentBinds returned an unexpected value.');
    k:SetSilentBinds(true);
    assert(k:GetSilentBinds() == true, 'GetSilentBinds returned an unexpected value.');
    k:SetSilentBinds(prev);

    --[[
    Mouse Testing
    --]]

    prev = m:GetBlockInput();
    m:SetBlockInput(false);
    assert(m:GetBlockInput() == false, 'GetBlockInput returned an unexpected value.');
    m:SetBlockInput(true);
    assert(m:GetBlockInput() == true, 'GetBlockInput returned an unexpected value.');
    m:SetBlockInput(prev);
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetInputManager():GetController():QueueButtonData()
    AshitaCore:GetInputManager():GetController():GetTrackDeadZone()
    AshitaCore:GetInputManager():GetController():SetTrackDeadZone()

    AshitaCore:GetInputManager():GetKeyboard():UnbindAll()

    AshitaCore:GetInputManager():GetXInput():QueueButtonData()
    AshitaCore:GetInputManager():GetXInput():GetTrackDeadZone()
    AshitaCore:GetInputManager():GetXInput():SetTrackDeadZone()
--]]