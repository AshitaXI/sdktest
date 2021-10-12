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
    local config = [[
--
[sdktest_bool]
b1 = false
b2 = true
b3 = 0
b4 = 1
b5 = 'false'
b6 = 'true'
b7 = 1337

--
[sdktest_uint]
uint8_max   = 255
uint16_max  = 65535
uint32_max  = 4294967295
uint64_max  = 18014398509481982

--
[sdktest_int]
int8_max    = 127
int16_max   = 32767
int32_max   = 2147483647
int64_max   = 18014398509481982

--
[sdktest_int_overflow]
int8_max    = 128
int16_max   = 32768
int32_max   = 2147483648
int8_min    = -128
int16_min   = -32768
int32_min   = -2147483648

--
[sdktest_str]
str1 = Single.
str2 = Two words.
str3 = "Quoted words."
str4 = "Quoted words ' with ' other symbols."]];

    -- Create a basic configuration script to be used..
    local f = io.open(string.format('%s/config/sdktest.ini', AshitaCore:GetInstallPath()), 'w');
    assert(f ~= nil, 'failed to create test configuration file.');
    f:write(config);
    f:close();
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local configManager = AshitaCore:GetConfigurationManager();
    assert(configManager ~= nil, 'GetConfigurationManager returned an unexpected value.');

    -- Test loading the configuration file..
    local ret = configManager:Load('sdktest', 'sdktest.ini');
    assert(ret == true, 'failed to load test configuration file.');

    --[[ Note:

        Lua does not fully handle 64bit / double value sizes. Instead, Lua is only able to handle
        interger precision of 52bits. (2^52) This means that the max value Lua can support is:

        0x3FFFFFFFFFFFFF (18014398509481983) [But technically -1 of this value.]

        Because of this, GetUInt64 and GetInt64 can return the same max value.
    --]]

    -- Test reading booleans..
    local b1 = configManager:GetBool('sdktest', 'sdktest_bool', 'b1', false);
    local b2 = configManager:GetBool('sdktest', 'sdktest_bool', 'b2', false);
    local b3 = configManager:GetBool('sdktest', 'sdktest_bool', 'b3', false);
    local b4 = configManager:GetBool('sdktest', 'sdktest_bool', 'b4', false);
    local b5 = configManager:GetBool('sdktest', 'sdktest_bool', 'b5', false);
    local b6 = configManager:GetBool('sdktest', 'sdktest_bool', 'b6', false);
    local b7 = configManager:GetBool('sdktest', 'sdktest_bool', 'b7', false);

    assert(b1 == false, 'GetBool returned an unexpected value.');
    assert(b2 == true, 'GetBool returned an unexpected value.');
    assert(b3 == false, 'GetBool returned an unexpected value.');
    assert(b4 == true, 'GetBool returned an unexpected value.');
    assert(b5 == false, 'GetBool returned an unexpected value.');
    assert(b6 == false, 'GetBool returned an unexpected value.');
    assert(b7 == true, 'GetBool returned an unexpected value.');

    -- Test reading unsigned values..
    local ui8   = configManager:GetUInt8('sdktest', 'sdktest_uint', 'uint8_max', 0);
    local ui16  = configManager:GetUInt16('sdktest', 'sdktest_uint', 'uint16_max', 0);
    local ui32  = configManager:GetUInt32('sdktest', 'sdktest_uint', 'uint32_max', 0);
    local ui64  = configManager:GetUInt64('sdktest', 'sdktest_uint', 'uint64_max', 0);

    assert(ui8 == 255, 'GetUInt8 returned an unexpected value.');
    assert(ui16 == 65535, 'GetUInt16 returned an unexpected value.');
    assert(ui32 == 4294967295, 'GetUInt32 returned an unexpected value.');
    assert(ui64 == 18014398509481982, 'GetUInt64 returned an unexpected value.');

    -- Test reading signed values..
    local i8   = configManager:GetInt8('sdktest', 'sdktest_int', 'int8_max', 0);
    local i16  = configManager:GetInt16('sdktest', 'sdktest_int', 'int16_max', 0);
    local i32  = configManager:GetInt32('sdktest', 'sdktest_int', 'int32_max', 0);
    local i64  = configManager:GetInt64('sdktest', 'sdktest_int', 'int64_max', 0);

    assert(i8 == 127, 'GetInt8 returned an unexpected value.');
    assert(i16 == 32767, 'GetInt16 returned an unexpected value.');
    assert(i32 == 2147483647, 'GetInt32 returned an unexpected value.');
    assert(i64 == 18014398509481982, 'GetInt64 returned an unexpected value.');

    -- Test reading signed values (overflow)..
    i8  = configManager:GetInt8('sdktest', 'sdktest_int_overflow', 'int8_max', 0);
    i16 = configManager:GetInt16('sdktest', 'sdktest_int_overflow', 'int16_max', 0);
    i32 = configManager:GetInt32('sdktest', 'sdktest_int_overflow', 'int32_max', 0);

    assert(i8 == -128, 'GetInt8 returned an unexpected value.');
    assert(i16 == -32768, 'GetInt16 returned an unexpected value.');
    assert(i32 == -2147483648, 'GetInt32 returned an unexpected value.');

    i8  = configManager:GetInt8('sdktest', 'sdktest_int_overflow', 'int8_min', 0);
    i16 = configManager:GetInt16('sdktest', 'sdktest_int_overflow', 'int16_min', 0);
    i32 = configManager:GetInt32('sdktest', 'sdktest_int_overflow', 'int32_min', 0);

    assert(i8 == -128, 'GetInt8 returned an unexpected value.');
    assert(i16 == -32768, 'GetInt16 returned an unexpected value.');
    assert(i32 == -2147483648, 'GetInt32 returned an unexpected value.');

    -- Test reading string values..
    local str1 = configManager:GetString('sdktest', 'sdktest_str', 'str1');
    local str2 = configManager:GetString('sdktest', 'sdktest_str', 'str2');
    local str3 = configManager:GetString('sdktest', 'sdktest_str', 'str3');
    local str4 = configManager:GetString('sdktest', 'sdktest_str', 'str4');
    local str5 = configManager:GetString('sdktest', 'sdktest_str', 'str5');

    assert(str1 == 'Single.', 'GetString returned an unexpected value.');
    assert(str2 == 'Two words.', 'GetString returned an unexpected value.');
    assert(str3 == '"Quoted words."', 'GetString returned an unexpected value.');
    assert(str4 == '"Quoted words \' with \' other symbols."', 'GetString returned an unexpected value.');
    assert(str5 == nil, 'GetString returned an unexpected value.');

    -- Test setting values..
    configManager:SetValue('sdktest', 'sdktest_str', 'str1', 'Changed.');
    str1 = configManager:GetString('sdktest', 'sdktest_str', 'str1');
    assert(str1 == 'Changed.', 'GetString returned an unexpected value. (SetValue failed.)');

    -- Test deleting the configurations from Ashita's internal cache..
    configManager:Delete('sdktest');
    str1 = configManager:GetString('sdktest', 'sdktest_str', 'str1');
    assert(str1 == nil, 'GetString returned an unexpected value. (Delete failed.)');

    -- Test reloading the configurations without saving..
    ret = configManager:Load('sdktest', 'sdktest.ini');
    assert(ret == true, 'failed to load test configuration file..');
    str1 = configManager:GetString('sdktest', 'sdktest_str', 'str1');
    assert(str1 == 'Changed.', 'GetString returned an unexpected value.');

    -- Test changing and saving values then reloading..
    configManager:SetValue('sdktest', 'sdktest_str', 'str1', 'Changed.');
    configManager:Save('sdktest', 'sdktest.ini');
    configManager:Delete('sdktest');
    configManager:Load('sdktest', 'sdktest.ini');
    str1 = configManager:GetString('sdktest', 'sdktest_str', 'str1');
    assert(str1 == 'Changed.', 'GetString returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Cleanup the test configuration..
    local configManager = AshitaCore:GetConfigurationManager();
    if (configManager ~= nil) then
        configManager:Delete('sdktest');
    end

    -- Delete the test configuration file..
    ashita.fs.remove(string.format('%s/config/sdktest.ini', AshitaCore:GetInstallPath()));
end

-- Return the test module table..
return test;