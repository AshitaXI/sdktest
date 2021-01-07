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

local ffi = require('ffi');

--[[
* The main test module table.
--]]
local test = { };

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Prepare FFI usages..
    ffi.cdef[[
        typedef char*           LPSTR;
        typedef const char*     LPCSTR;
        typedef void*           HMODULE;
        typedef unsigned long   DWORD;

        HMODULE GetModuleHandleA(LPCSTR lpModuleName);
        DWORD GetModuleFileNameA(HMODULE hModule, LPSTR lpFilename, DWORD nSize);
    ]];
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the main object..
    local core = AshitaCore;
    assert(core ~= nil, 'AshitaCore was nil; this is a critical error!');

    -- Validate the handle..
    local handle = core:GetHandle();
    assert(handle ~= nil, 'GetHandle returned an unexpected value.');
    assert(type(handle) == 'number', 'GetHandle returned an unexpected value.');

    -- Validate the handle via FFI..
    local c_handle = ffi.cast('uint32_t', ffi.C.GetModuleHandleA('Ashita.dll'));
    assert(tonumber(c_handle) == handle, 'GetHandle returned an unexpected value.');

    -- Validate the install path..
    local path = core:GetInstallPath();
    assert(path ~= nil, 'GetInstallPath returned an unexpected value.');
    assert(type(path) == 'string', 'GetInstallPath returned an unexpected value.');
    assert(#path > 0, 'GetInstallPath returned an unexpected value.');

    -- Validate the install path via FFI..
    local buff = ffi.new('char[?]', 260);
    local ret = ffi.C.GetModuleFileNameA(ffi.C.GetModuleHandleA('Ashita.dll'), buff, 260);
    assert(ret > 0, 'GetModuleHandleA returned an unexpected value.');

    -- Split the path from the module name..
    local str = ffi.string(buff, 260);
    local part = string.sub(str, 0, string.find(str, 'Ashita.dll') - 1);
    assert(path == part, 'Failed to validate install path via FFI.');

    -- Validate Direct3D device..
    local device = core:GetDirect3DDevice();
    assert(device ~= nil, 'GetDirect3DDevice returned an unexpected value.');
    assert(type(device) == 'userdata', 'GetDirect3DDevice returned an unexpected value.');

    -- Validate the properties..
    local props = core:GetProperties();
    assert(props ~= nil, 'GetProperties returned an unexpected value.');

    -- Note: Because private servers will not fully populate these properties, we don't validate them more thoroughly..
    local hwnd = props:GetPlayOnlineHwnd();
    local style = props:GetPlayOnlineStyle();
    local styleex = props:GetPlayOnlineStyleEx();
    local rect = props:GetPlayOnlineRect();

    assert(type(hwnd) == 'number', 'GetPlayOnlineHwnd returned an unexpected value.');
    assert(type(style) == 'number', 'GetPlayOnlineStyle returned an unexpected value.');
    assert(type(styleex) == 'number', 'GetPlayOnlineStyleEx returned an unexpected value.');
    assert(type(rect) == 'userdata', 'GetPlayOnlineRect returned an unexpected value.');
    assert(type(rect.left) == 'number', 'GetPlayOnlineRect returned an unexpected value.');
    assert(type(rect.top) == 'number', 'GetPlayOnlineRect returned an unexpected value.');
    assert(type(rect.right) == 'number', 'GetPlayOnlineRect returned an unexpected value.');
    assert(type(rect.bottom) == 'number', 'GetPlayOnlineRect returned an unexpected value.');

    hwnd = props:GetPlayOnlineMaskHwnd();
    style = props:GetPlayOnlineMaskStyle();
    styleex = props:GetPlayOnlineMaskStyleEx();
    rect = props:GetPlayOnlineMaskRect();

    assert(type(handle) == 'number', 'GetPlayOnlineMaskHwnd returned an unexpected value.');
    assert(type(style) == 'number', 'GetPlayOnlineMaskStyle returned an unexpected value.');
    assert(type(styleex) == 'number', 'GetPlayOnlineMaskStyleEx returned an unexpected value.');
    assert(type(rect) == 'userdata', 'GetPlayOnlineMaskRect returned an unexpected value.');
    assert(type(rect.left) == 'number', 'GetPlayOnlineMaskRect returned an unexpected value.');
    assert(type(rect.top) == 'number', 'GetPlayOnlineMaskRect returned an unexpected value.');
    assert(type(rect.right) == 'number', 'GetPlayOnlineMaskRect returned an unexpected value.');
    assert(type(rect.bottom) == 'number', 'GetPlayOnlineMaskRect returned an unexpected value.');

    handle = props:GetFinalFantasyHwnd();
    style = props:GetFinalFantasyStyle();
    styleex = props:GetFinalFantasyStyleEx();
    rect = props:GetFinalFantasyRect();

    assert(type(handle) == 'number', 'GetFinalFantasyHwnd returned an unexpected value.');
    assert(type(style) == 'number', 'GetFinalFantasyStyle returned an unexpected value.');
    assert(type(styleex) == 'number', 'GetFinalFantasyStyleEx returned an unexpected value.');
    assert(type(rect) == 'userdata', 'GetFinalFantasyRect returned an unexpected value.');
    assert(type(rect.left) == 'number', 'GetFinalFantasyRect returned an unexpected value.');
    assert(type(rect.top) == 'number', 'GetFinalFantasyRect returned an unexpected value.');
    assert(type(rect.right) == 'number', 'GetFinalFantasyRect returned an unexpected value.');
    assert(type(rect.bottom) == 'number', 'GetFinalFantasyRect returned an unexpected value.');

    --[[
    Validate the manager objects..

        Note:   This is not a proper means of pulling a manager object from the core. This is simply being done as a means
                to write a smaller and cleaner test file. Do not get manager objects from AshitaCore like this!
    --]]

    local managers = {
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
        'GetPrimitiveManager',
        'GetResourceManager',
    };

    for _, v in pairs(managers) do
        local m = core[v](core);
        assert(m ~= nil, string.format('%s returned an unexpected value.', v));
        assert(type(m) == 'userdata', string.format('%s returned an unexpected value.', v));
    end
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
--]]