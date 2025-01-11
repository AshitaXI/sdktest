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
require 'win32types';

local ffi = require 'ffi';

ffi.cdef[[
    HMODULE GetModuleHandleA(const char* lpModuleName);
    DWORD   GetModuleFileNameA(HMODULE hModule, char* lpFilename, DWORD nSize);
]];

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
    -- Validate the main object..
    local core = AshitaCore;
    assert(core ~= nil, 'AshitaCore was nil; this is a critical error!');

    -- Validate the handle..
    local a_handle = core:GetHandle();
    local c_handle = ffi.cast('uint32_t', ffi.C.GetModuleHandleA('Ashita.dll'));

    assert(a_handle ~= nil, 'GetHandle returned an unexpected value.');
    assert(type(a_handle) == 'number', 'GetHandle returned an unexpected value.');
    assert(tonumber(c_handle) == a_handle, 'GetHandle returned an unexpected value.');

    -- Validate the install path..
    local a_path    = core:GetInstallPath();
    local buff      = ffi.new('char[?]', 260);
    local ret       = ffi.C.GetModuleFileNameA(ffi.C.GetModuleHandleA('Ashita.dll'), buff, 260);
    assert(a_path ~= nil, 'GetInstallPath returned an unexpected value.');
    assert(type(a_path) == 'string', 'GetInstallPath returned an unexpected value.');
    assert(#a_path > 0, 'GetInstallPath returned an unexpected value.');
    assert(ret > 0, 'GetInstallPath returned an unexpected value.');
    local str       = ffi.string(buff, 260);
    local part      = str:sub(0, str:find('Ashita.dll') - 1);
    assert(a_path == part, 'GetInstallPath returned an unexpected value.');

    -- Validate Direct3D device..
    local device = core:GetDirect3DDevice();
    assert(device ~= nil, 'GetDirect3DDevice returned an unexpected value.');
    assert(type(device) == 'number', 'GetDirect3DDevice returned an unexpected value.');

    -- Validate the properties..
    local props = core:GetProperties();
    assert(props ~= nil, 'GetProperties returned an unexpected value.');

    --[[
    Validate the various property objects..

    Note:   This is not a proper means of using these property functions. This is simply being done as a means
            to write a smaller and cleaner test file. Do not use the properties like this!
    --]]

    local hwnds     = T{ 'GetPlayOnlineHwnd',   'GetPlayOnlineMaskHwnd',    'GetFinalFantasyHwnd', };
    local styles    = T{ 'GetPlayOnlineStyle',  'GetPlayOnlineMaskStyle',   'GetFinalFantasyStyle', };
    local stylesex  = T{ 'GetPlayOnlineStyleEx','GetPlayOnlineMaskStyleEx', 'GetFinalFantasyStyleEx', };
    local rects     = T{ 'GetPlayOnlineRect',   'GetPlayOnlineMaskRect',    'GetFinalFantasyRect', };

    hwnds:each(function (v)
        assert(type(props[v](props)) == 'number', ('%s returned an unexpected value.'):fmt(v));
    end);
    styles:each(function (v)
        assert(type(props[v](props)) == 'number', ('%s returned an unexpected value.'):fmt(v));
    end);
    stylesex:each(function (v)
        assert(type(props[v](props)) == 'number', ('%s returned an unexpected value.'):fmt(v));
    end);
    rects:each(function (v)
        local rect = props[v](props);
        assert(type(rect) == 'userdata', ('%s returned an unexpected value.'):fmt(v));
        assert(type(rect.left) == 'number', ('%s returned an unexpected value.'):fmt(v));
        assert(type(rect.top) == 'number', ('%s returned an unexpected value.'):fmt(v));
        assert(type(rect.right) == 'number', ('%s returned an unexpected value.'):fmt(v));
        assert(type(rect.bottom) == 'number', ('%s returned an unexpected value.'):fmt(v));
    end);

    --[[
    Validate the various manager objects exist..

    Note:   This is not a proper means of pulling a manager object from the core. This is simply being done as a means
            to write a smaller and cleaner test file. Do not get manager objects from AshitaCore like this!
    --]]

    local managers = T{
        'GetChatManager',
        'GetConfigurationManager',
        'GetFontManager',
        'GetGuiManager',
        'GetInputManager',
        'GetMemoryManager',
        'GetOffsetManager',
        'GetPacketManager',
        'GetPluginManager',
        'GetPolPluginManager',
        'GetPointerManager',
        'GetPrimitiveManager',
        'GetResourceManager',
    };

    managers:each(function (v)
        local mgr = core[v](core);
        assert(mgr ~= nil, ('%s returned an unexpected value.'):fmt(v));
        assert(type(mgr) == 'userdata', ('%s returned an unexpected value.'):fmt(v));
    end);

    --[[
    Validate pointer exposure..

    Note:   Depending on the version of Ashita users are playing with, this may not exist.
    --]]

    if (core.GetPointer == nil) then
        return;
    end

    assert(type(core.GetPointer) == 'function', 'GetPointer returned an unexpected value.');
    local ptr = core:GetPointer();
    assert(type(ptr) == 'number', 'GetPointer returned an unexpected value.');
    assert(ptr > 0, 'GetPointer returned an unexpected value.');
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetProperties():SetPlayOnlineHwnd()
    AshitaCore:GetProperties():SetPlayOnlineStyle()
    AshitaCore:GetProperties():SetPlayOnlineStyleEx()
    AshitaCore:GetProperties():SetPlayOnlineRect()
    AshitaCore:GetProperties():SetPlayOnlineMaskHwnd()
    AshitaCore:GetProperties():SetPlayOnlineMaskStyle()
    AshitaCore:GetProperties():SetPlayOnlineMaskStyleEx()
    AshitaCore:GetProperties():SetPlayOnlineMaskRect()
    AshitaCore:GetProperties():SetFinalFantasyHwnd()
    AshitaCore:GetProperties():SetFinalFantasyStyle()
    AshitaCore:GetProperties():SetFinalFantasyStyleEx()
    AshitaCore:GetProperties():SetFinalFantasyRect()

        These 'setters' are intended for internal use of Ashita only. Addons should not be calling these unless you
        absolutely understand what you're doing. These are just the properties each window was initialized with, they
        do not update the current values / alter the windows in any way. (Modding these can have undesired affects!)

Additionally, there are also hooked API forwards that are part of the AshitaCore object. These are not tested but include:

    AshitaCore:Direct3DCreate8(...)
    AshitaCore:DirectInput8Create(...)

    AshitaCore:CreateMutexA(...)
    AshitaCore:CreateMutexW(...)
    AshitaCore:OpenMutexA(...)
    AshitaCore:OpenMutexW(...)

    AshitaCore:RegQueryValueExA(...)

    AshitaCore:CreateWindowExA(...)
    AshitaCore:CreateWindowExW(...)
    AshitaCore:ExitProcess(...)
    AshitaCore:GetSystemMetrics(...)
    AshitaCore:GetWindowTextA(...)
    AshitaCore:GetWindowTextW(...)
    AshitaCore:LoadBitmapW(...)
    AshitaCore:RegisterClassA(...)
    AshitaCore:RegisterClassW(...)
    AshitaCore:RegisterClassExA(...)
    AshitaCore:RegisterClassExW(...)
    AshitaCore:RemoveMenu(...)
    AshitaCore:SendMessageA(...)
    AshitaCore:SetCursorPos(...)
    AshitaCore:SetForegroundWindow(...)
    AshitaCore:SetPriorityClass(...)
    AshitaCore:SetWindowsHookExA(...)
    AshitaCore:SetWindowTextA(...)
    AshitaCore:SetWindowTextW(...)
--]]