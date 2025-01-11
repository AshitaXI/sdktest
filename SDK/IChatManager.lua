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

local chat  = require 'chat';
local flags = require 'flags';

--[[
* The main test module table.
--]]
local test = T{};

--[[
* Event called when the addon is processing incoming text.
*
* @param {object} e - The event arguments.
--]]
local function text_in_callback(e)
    if (flags.has(e.message)) then
        flags.set(e.message);
        e.blocked = true;
    end
end

--[[
* Event called when the addon is processing keyboard input. (WNDPROC)
*
* @param {object} e - The event arguments.
--]]
local function key_callback(e)
    -- Look for F9 key presses..
    local isF9      = e.wparam == 0x78;
    local isKeyDown = not (bit.band(e.lparam, bit.lshift(0x8000, 0x10)) == bit.lshift(0x8000, 0x10));

    if (not isF9 or not isKeyDown) then
        return;
    end

    -- Check if in the first input wait state..
    if (flags.is_set('sdktest:input_state_1') and not flags.is_set('sdktest:input_state_2')) then
        flags.set('sdktest:input_state_2');
        e.blocked = true;
    end

    -- Check if in the second input wait state..
    if (flags.is_set('sdktest:input_state_3') and not flags.is_set('sdktest:input_state_4')) then
        flags.set('sdktest:input_state_4');
        e.blocked = true;
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = T{
        T{ name = 'sdktest:addchatmessage',         seen = false },
        T{ name = 'sdktest:executescript',          seen = false },
        T{ name = 'sdktest:executescriptstring',    seen = false },
        T{ name = 'sdktest:queuecommand',           seen = false },
        T{ name = 'sdktest:write',                  seen = false },
        T{ name = 'sdktest:input_state_1',          seen = false },
        T{ name = 'sdktest:input_state_2',          seen = false },
        T{ name = 'sdktest:input_state_3',          seen = false },
        T{ name = 'sdktest:input_state_4',          seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('key', 'key_callback', key_callback);
    ashita.events.register('text_in', 'text_in_callback', text_in_callback);

    -- Create a basic script to be executed..
    local f = io.open(string.format('%s/scripts/sdktest.txt', AshitaCore:GetInstallPath()), 'w');
    assert(f ~= nil, 'failed to create test script file.');
    f:write('/echo sdktest:executescript');
    f:close();
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Delete the test script file..
    ashita.fs.remove(string.format('%s/scripts/sdktest.txt', AshitaCore:GetInstallPath()));

    -- Unregister event callbacks..
    ashita.events.unregister('text_in', 'text_in_callback');
    ashita.events.unregister('key', 'key_callback');

    -- Ensure all flags were seen..
    flags.validate();
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local mgr = AshitaCore:GetChatManager();
    assert(mgr ~= nil, 'GetChatManager returned an unexpected value.');

    --[[
    Note:   Some of the below tests are making use of the 'flags' module and some event callbacks to 'abuse' a method
            of testing that allows the output of the ChatManager commands to be hidden. Due to how this works, it is
            required that some of the tests yield between frames to ensure that they execute and their output has time
            to be sent through the game client functions!
    --]]

    -- Test queueing a command..
    mgr:QueueCommand(1, '/echo sdktest:queuecommand');
    coroutine.sleepf(1);

    -- Test writing to the chat log..
    mgr:Write(1, false, 'sdktest:write');
    mgr:AddChatMessage(1, false, 'sdktest:addchatmessage');
    coroutine.sleepf(1);

    -- Test parsing auto-translate strings..
    local s1 = mgr:ParseAutoTranslate('Hello world!', false);           -- Hello world! -> Hello world!
    local s2 = mgr:ParseAutoTranslate('\253\02\02\01\11\253', false);   -- {Hello!} -> Hello!
    local s3 = mgr:ParseAutoTranslate('\253\02\02\01\11\253', true);    -- {Hello!} -> {Hello!}
    local s4 = T{ 0xEF, 0x27, 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0xEF, 0x28 }:concat();
    local s5 = T{ s3:byte(1, -1) }:concat();
    assert(s1 == 'Hello world!', 'ParseAutoTranslate returned an unexpected value.');
    assert(s2 == 'Hello!', 'ParseAutoTranslate returned an unexpected value.');
    assert(s4 == s5, 'ParseAutoTranslate returned an unexpected value.');

    -- Test executing a script and script string..
    mgr:ExecuteScript('sdktest.txt', '', true);
    mgr:ExecuteScriptString('/echo sdktest:executescriptstring', '', true);
    coroutine.sleepf(2);

    --[[
    Note:   The next set of tests are used to test the chat input. These tests require user interaction in order to
            be properly tested. Due to this, it is required that the test wait for user interaction. To accomplish
            this, we will make use of flags again to create mini-states that the test will wait for before continuing.
    --]]

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IChatManager\30\81\' ')
        :append(chat.message('The next set of tests will require you to interact with the game client!')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IChatManager\30\81\' ')
        :append(chat.message('Be sure to read the instructions carefully before continuing with the tests!')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IChatManager\30\81\' ')
        :append(chat.message('Please open the chat input and clear all current text so it is blank/empty.')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IChatManager\30\81\' ')
        :append(chat.error('DO NOT '))
        :append(chat.message('press enter or close the chat input when you are done, instead press \''))
        :append(chat.color1(6, 'F9'))
        :append(chat.message('\' when ready.')));

    -- Wait for the user to press 'F9' for the first set of input tests..
    flags.set('sdktest:input_state_1');
    while (not flags.is_set('sdktest:input_state_2')) do
        coroutine.sleepf(5);
    end

    -- Test if the chat input is open currently..
    assert(mgr:IsInputOpen() ~= 0, 'IsInputOpen returned an unexpected value.');

    -- Test to ensure the chat input is empty..
    local val1 = mgr:GetInputTextRaw();
    local val2 = mgr:GetInputTextRawLength();
    local val3 = mgr:GetInputTextRawCaretPosition();
    local val4 = mgr:GetInputTextParsed();
    local val5 = mgr:GetInputTextParsedLength();
    local val6 = mgr:GetInputTextParsedLengthMax();
    local val7 = mgr:GetInputTextDisplay();

    assert(type(val1) == 'string', 'GetInputTextRaw returned an unexpected value.');
    assert(#val1 == 0, 'GetInputTextRaw returned an unexpected value.');
    assert(type(val2) == 'number', 'GetInputTextRawLength returned an unexpected value.');
    assert(val2 == 0, 'GetInputTextRawLength returned an unexpected value.');
    assert(type(val3) == 'number', 'GetInputTextRawCaretPosition returned an unexpected value.');
    assert(val3 == 0, 'GetInputTextRawCaretPosition returned an unexpected value.');
    assert(type(val4) == 'string', 'GetInputTextParsed returned an unexpected value.');
    assert(#val4 == 0, 'GetInputTextParsed returned an unexpected value.');
    assert(type(val5) == 'number', 'GetInputTextParsedLength returned an unexpected value.');
    assert(val5 == 0, 'GetInputTextParsedLength returned an unexpected value.');
    assert(type(val6) == 'number', 'GetInputTextParsedLengthMax returned an unexpected value.');
    assert(val6 == 120, 'GetInputTextParsedLengthMax returned an unexpected value.');
    -- Note: The display text includes the caret which is two bytes long!
    assert(type(val7) == 'string', 'GetInputTextDisplay returned an unexpected value. 1');
    assert(#val7 == 2, 'GetInputTextDisplay returned an unexpected value. 2');

    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IChatManager\30\81\' ')
        :append(chat.message('Next, open the chat input and type the following string: '))
        :append(chat.color1(6, '/sdktest 1234')));
    print(chat.header('SDKTest')
        :append('\30\81\'\30\06IChatManager\30\81\' ')
        :append(chat.error('DO NOT '))
        :append(chat.message('press enter or close the chat input when you are done, instead press \''))
        :append(chat.color1(6, 'F9'))
        :append(chat.message('\' when ready.')));

    -- Wait for the user to press 'F9' for the second set of input tests..
    flags.set('sdktest:input_state_3');
    while (not flags.is_set('sdktest:input_state_4')) do
        coroutine.sleepf(5);
    end

    -- Test if the chat input is open currently..
    assert(mgr:IsInputOpen() ~= 0, 'IsInputOpen returned an unexpected value.');

    -- Test to ensure the chat input is set properly..
    val1 = mgr:GetInputTextRaw();
    val2 = mgr:GetInputTextRawLength();
    val3 = mgr:GetInputTextRawCaretPosition();
    val4 = mgr:GetInputTextParsed();
    val5 = mgr:GetInputTextParsedLength();
    val6 = mgr:GetInputTextParsedLengthMax();
    val7 = mgr:GetInputTextDisplay();

    assert(type(val1) == 'string', 'GetInputTextRaw returned an unexpected value.');
    assert(val1 == '/sdktest 1234', 'GetInputTextRaw returned an unexpected value.');
    assert(#val1 == 13, 'GetInputTextRaw returned an unexpected value.');
    assert(type(val2) == 'number', 'GetInputTextRawLength returned an unexpected value.');
    assert(val2 == 13, 'GetInputTextRawLength returned an unexpected value.');
    assert(type(val3) == 'number', 'GetInputTextRawCaretPosition returned an unexpected value.');
    assert(val3 == 13, 'GetInputTextRawCaretPosition returned an unexpected value.');
    assert(type(val4) == 'string', 'GetInputTextParsed returned an unexpected value.');
    assert(val4 == '/sdktest 1234', 'GetInputTextParsed returned an unexpected value.');
    assert(#val4 == 13, 'GetInputTextParsed returned an unexpected value.');
    assert(type(val5) == 'number', 'GetInputTextParsedLength returned an unexpected value.');
    assert(val5 == 13, 'GetInputTextParsedLength returned an unexpected value.');
    assert(type(val6) == 'number', 'GetInputTextParsedLengthMax returned an unexpected value.');
    assert(val6 == 120, 'GetInputTextParsedLengthMax returned an unexpected value.');
    -- Note: The display text includes the caret which is two bytes long!
    assert(type(val7) == 'string', 'GetInputTextDisplay returned an unexpected value. 1');
    assert(val7 == '/sdktest 1234\127\255', 'GetInputTextDisplay returned an unexpected value. 2');
    assert(#val7 == 15, 'GetInputTextDisplay returned an unexpected value. 2');

    -- Test setting the input text..
    mgr:SetInputText('/sdktest 54321');

    -- Test to ensure the chat input is set properly..
    val1 = mgr:GetInputTextRaw();
    val2 = mgr:GetInputTextRawLength();
    val3 = mgr:GetInputTextRawCaretPosition();
    val4 = mgr:GetInputTextParsed();
    val5 = mgr:GetInputTextParsedLength();
    val6 = mgr:GetInputTextParsedLengthMax();
    val7 = mgr:GetInputTextDisplay();

    assert(type(val1) == 'string', 'GetInputTextRaw returned an unexpected value.');
    assert(val1 == '/sdktest 54321', 'GetInputTextRaw returned an unexpected value.');
    assert(#val1 == 14, 'GetInputTextRaw returned an unexpected value.');
    assert(type(val2) == 'number', 'GetInputTextRawLength returned an unexpected value.');
    assert(val2 == 14, 'GetInputTextRawLength returned an unexpected value.');
    assert(type(val3) == 'number', 'GetInputTextRawCaretPosition returned an unexpected value.');
    assert(val3 == 14, 'GetInputTextRawCaretPosition returned an unexpected value.');
    assert(type(val4) == 'string', 'GetInputTextParsed returned an unexpected value.');
    assert(val4 == '/sdktest 54321', 'GetInputTextParsed returned an unexpected value.');
    assert(#val4 == 14, 'GetInputTextParsed returned an unexpected value.');
    assert(type(val5) == 'number', 'GetInputTextParsedLength returned an unexpected value.');
    assert(val5 == 14, 'GetInputTextParsedLength returned an unexpected value.');
    assert(type(val6) == 'number', 'GetInputTextParsedLengthMax returned an unexpected value.');
    assert(val6 == 120, 'GetInputTextParsedLengthMax returned an unexpected value.');
    -- Note: The display text includes the caret which is two bytes long!
    assert(type(val7) == 'string', 'GetInputTextDisplay returned an unexpected value. 1');
    assert(val7 == '/sdktest 54321\127\255', 'GetInputTextDisplay returned an unexpected value. 2');
    assert(#val7 == 16, 'GetInputTextDisplay returned an unexpected value. 2');
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetChatManager():SetInputTextRaw(...)
    AshitaCore:GetChatManager():SetInputTextParsed(...)
    AshitaCore:GetChatManager():SetInputTextDisplay(...)

        If developers need/want to set the input text, they should use the SetInputText function specifically instead
        of any of these helper functions. The SetInputText function will deal with all the buffers and caret for you.

    AshitaCore:GetChatManager():GetSilentAliases()
    AshitaCore:GetChatManager():SetSilentAliases()
--]]