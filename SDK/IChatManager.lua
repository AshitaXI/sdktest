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
]]--

local flags = require('flags');

--[[
* The main test module table.
--]]
local test = { };

--[[
* Event called when the addon is processing incoming text.
*
* @param {object} args - The event arguments.
--]]
local function text_in_callback(args)
    -- Scan for known flags based on text being pumped to the log..
    for _, v in pairs(flags.flags) do
        if (v.name == string.lower(args.message)) then
            -- Block the event..
            args.blocked = true;

            -- Set the test flag..
            flags.set(v.name);
            return;
        end
    end
end

--[[
* Event called when the addon is processing keyboard input. (WNDPROC)
*
* @param {object} args - The event arguments.
--]]
local function key_callback(args)
    -- Do nothing if the test state isn't ready..
    if (not flags.is_set('sdktest:input_state_1')) then
        return;
    end

    -- Look for F9 key presses..
    if (args.wparam == 0x78) then
        flags.set('sdktest:input_state_2');
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init()
    -- Register the test flags..
    local test_flags = {
        { name = 'sdktest:addchatmessage',      seen = false },
        { name = 'sdktest:executescript',       seen = false },
        { name = 'sdktest:executescriptstring', seen = false },
        { name = 'sdktest:queuecommand',        seen = false },
        { name = 'sdktest:write',               seen = false },
        { name = 'sdktest:input_state_1',       seen = false },
        { name = 'sdktest:input_state_2',       seen = false },
    };
    flags.register(test_flags);

    -- Register event callbacks..
    ashita.events.register('text_in', 'text_in_callback', text_in_callback);
    ashita.events.register('key', 'key_callback', key_callback);

    -- Create a basic script to be executed..
    local f = io.open(string.format('%s/scripts/sdktest.txt', AshitaCore:GetInstallPath()), 'w');
    assert(f ~= nil, 'failed to create test script file.');
    f:write('/echo sdktest:executescript');
    f:close();
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager object..
    local chatManager = AshitaCore:GetChatManager();
    assert(chatManager ~= nil, 'GetChatManager returned an unexpected value.');

    -- Test writing to the chat log..
    chatManager:Write(1, false, 'sdktest:write');
    chatManager:AddChatMessage(1, false, 'sdktest:addchatmessage');

    -- Test parsing auto-translate strings..
    local s1 = chatManager:ParseAutoTranslate('Hello world!', false);           -- Hello world! -> Hello world!
    local s2 = chatManager:ParseAutoTranslate('\253\02\02\01\11\253', false);   -- {Hello!} -> Hello!
    assert(s1 == 'Hello world!', 'ParseAutoTranslate returned an unexpected value.');
    assert(s2 == 'Hello!', 'ParseAutoTranslate returned an unexpected value.');

    local s3 = chatManager:ParseAutoTranslate('\253\02\02\01\11\253', true);    -- {Hello!} -> {Hello!}
    local expected = { 0xEF, 0x27, 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0xEF, 0x28 };
    local t = { string.byte( s3, 1, -1) };
    assert(table.concat(expected) == table.concat(t), 'ParseAutoTranslate returned an unexpected value.');

    -- Test executing a script and script string..
    chatManager:ExecuteScript('sdktest.txt', '', true);
    chatManager:ExecuteScriptString('/echo sdktest:executescriptstring', '', true);

    -- Give tests time to complete and be processed by the client..
    coroutine.sleep(2);

    --[[
    Test input text..

    Note:   This part of the tests requires user interaction. To accomplish this, we will use flags to create mini
            states that tell the addon what to do next based on expected input.
    --]]

    print("\30\81[\30\06SDKTest\30\81] \30\81(\30\06IChatManager\30\81) \30\106Please open the chat input and enter the text: /sdktest 1234\30\01");
    print("\30\81[\30\06SDKTest\30\81] \30\81(\30\06IChatManager\30\81) \30\106Do not press enter! Instead, press \30\06F9\30\106 when ready.\30\01");

    -- Set the test state and wait for the user to press F9..
    flags.set('sdktest:input_state_1');
    while (not flags.is_set('sdktest:input_state_2')) do
        coroutine.sleepf(5);
    end

    -- Test if the input is open..
    assert(chatManager:IsInputOpen() ~= 0, 'IsInputOpen returned an unexpected value.');

    -- Test the input text..
    local txt = chatManager:GetInputTextRaw();
    assert(txt == '/sdktest 1234', 'GetInputTextRaw returned an unexpected value.');
    local len = chatManager:GetInputTextRawLength();
    assert(len == 13, 'GetInputTextRawLength returned an unexpected value.');
    local pos = chatManager:GetInputTextRawCaretPosition();
    assert(pos == 13, 'GetInputTextRawCaretPosition returned an unexpected value.');
    txt = chatManager:GetInputTextParsed();
    assert(txt == '/sdktest 1234', 'GetInputTextParsed returned an unexpected value.');
    len = chatManager:GetInputTextParsedLength();
    assert(len == 13, 'GetInputTextParsedLength returned an unexpected value.');
    len = chatManager:GetInputTextParsedLengthMax();
    assert(len == 120, 'GetInputTextParsedLengthMax returned an unexpected value.');
    txt = chatManager:GetInputTextDisplay();
    assert(txt == '/sdktest 1234\127\255', 'GetInputTextDisplay returned an unexpected value.'); -- \127\255 is the caret display.

    -- Test setting the input text..
    chatManager:SetInputText('/sdktest 54321');

    -- Test the input text..
    txt = chatManager:GetInputTextRaw();
    assert(txt == '/sdktest 54321', 'GetInputTextRaw returned an unexpected value.');
    len = chatManager:GetInputTextRawLength();
    assert(len == 14, 'GetInputTextRawLength returned an unexpected value.');
    pos = chatManager:GetInputTextRawCaretPosition();
    assert(pos == 14, 'GetInputTextRawCaretPosition returned an unexpected value.');
    txt = chatManager:GetInputTextParsed();
    assert(txt == '/sdktest 54321', 'GetInputTextParsed returned an unexpected value.');
    len = chatManager:GetInputTextParsedLength();
    assert(len == 14, 'GetInputTextParsedLength returned an unexpected value.');
    len = chatManager:GetInputTextParsedLengthMax();
    assert(len == 120, 'GetInputTextParsedLengthMax returned an unexpected value.');
    txt = chatManager:GetInputTextDisplay();
    assert(txt == '/sdktest 54321\127\255', 'GetInputTextDisplay returned an unexpected value.'); -- \127\255 is the caret display.
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

-- Return the test module table..
return test;

--[[
Untested Functions:

    AshitaCore:GetChatManager():SetInputTextRaw
    AshitaCore:GetChatManager():SetInputTextParsed
    AshitaCore:GetChatManager():SetInputTextDisplay

        If developers need/want to set the input text, they should use the SetInputText function specifically instead
        of any of these helper functions. The SetInputText function will deal with all the buffers and caret for you.
--]]