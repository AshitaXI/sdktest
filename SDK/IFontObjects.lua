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

--[[
* The main test module table.
--]]
local test = { };

--[[
* Test properties.
--]]
test.uniqueSuffix = '';

--[[
* Cleans up an object until it is completely gone.
*
* @param {object} manager - The manager that owns the object to be cleaned up.
* @param {string} alias - The alias of the object to cleanup.
--]]
local function cleanup_object(manager, alias)
    assert(manager ~= nil, 'manager must not be nil.');
    assert(alias ~= nil, 'expected a valid object alias.')

    local o = manager:Get(alias);
    while (o ~= nil) do
        manager:Delete(alias);
        o = manager:Get(alias);
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init(cnt)
    -- Create a randomized seed to help generate unique entry names..
    math.randomseed(os.time() + cnt);
    math.random(0, 100000);
    math.random(0, 100000);
    local rnd = math.random(0, 100000);
    math.randomseed(os.time() + rnd + cnt);
    rnd = math.random(100000, 900000);

    -- Create a unique suffix for the objects to be used with these tests..
    test.uniqueSuffix = string.format('_%d_%d_%d', addon.instance.current_frame, rnd, cnt);
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager objects..
    local fontManager = AshitaCore:GetFontManager();
    local primManager = AshitaCore:GetPrimitiveManager();
    assert(fontManager ~= nil, 'GetFontManager returned an unexpected value.');
    assert(primManager ~= nil, 'GetPrimitiveManager returned an unexpected value.');

    -- Create two unique object names to use with the tests..
    local uniqueName1 = string.format('sdktest1%s', test.uniqueSuffix);
    local uniqueName2 = string.format('sdktest2%s', test.uniqueSuffix);

    --[[
    Font Manager Testing
    --]]

    -- Test creating a font object..
    local f1 = fontManager:Create(uniqueName1);
    assert(f1 ~= nil, 'Create returned an unexpected value.');

    -- Test getting a font object..
    local f2 = fontManager:Get(uniqueName1);
    assert(f2 ~= nil, 'Get returned an unexpected value.');
    assert(f1 == f2, 'Get returned an unexpected value.');

    -- Test deleting a font object..
    fontManager:Delete(uniqueName1);
    f1 = fontManager:Get(uniqueName1);
    assert(f1 == nil, 'Get returned an unexpected value.');

    -- Test setting the focused font object..
    f1 = fontManager:Create(uniqueName1);
    assert(f1 ~= nil, 'Create returned an unexpected value.');
    fontManager:SetFocusedObject('');
    f2 = fontManager:GetFocusedObject();
    assert(f2 == nil, 'GetFocusedObject returned an unexpected value.');
    fontManager:SetFocusedObject(f1:GetAlias());
    f2 = fontManager:GetFocusedObject();
    assert(f2 == f1, 'GetFocusedObject returned an unexpected value.');

    fontManager:Delete(uniqueName1);

    --[[
    Font Object Testing

    Note:   The below tests are to attempt to call the Get/Set handlers of a font object. Please note the comments next to
            some of the calls. Calls like SetAlias should never happen manually by a user/developer! This is just for testing.
    --]]

    f1 = fontManager:Create(uniqueName1);
    assert(f1 ~= nil, 'Create returned an unexpected value.');
    f1:SetAlias(uniqueName2); -- Warning: Developers should never call this!
    f1:SetVisible(true);
    f1:SetCanFocus(false);
    f1:SetLocked(true);
    f1:SetLockedZ(true);
    f1:SetIsDirty(true); -- This will be automatically reset internally next-frame when the font is rebuilt.
    f1:SetWindowWidth(1920);
    f1:SetWindowHeight(1024);
    f1:SetFontFamily('Arial');
    f1:SetFontHeight(12);
    f1:SetCreateFlags(FontCreateFlags.Bold); -- Setting to bold; but then we will call 'SetBold' to false and ensure it is honored.
    f1:SetDrawFlags(FontDrawFlags.Outlined);
    f1:SetBold(false); -- Overriding the 'SetCreateFlags' call above.
    f1:SetItalic(false);
    f1:SetRightJustified(false);
    f1:SetStrikeThrough(false);
    f1:SetUnderlined(false);
    f1:SetColor(0xFFFF0000);         -- Color: Red
    f1:SetColorOutline(0xFF00FF00);  -- Color: Green
    f1:SetPadding(0);
    f1:SetPositionX(2); -- Set the position to 2x2 for 'HitTest' call testing.
    f1:SetPositionY(2);
    f1:SetAutoResize(true);
    f1:SetAnchor(FrameAnchor.TopRight);
    f1:SetAnchorParent(FrameAnchor.BottomLeft);
    f1:SetText('Hello world!');
    f1:SetParent(nil);

    -- Allow the font to rebuild..
    coroutine.sleepf(2);

    -- Test the font values were properly set..
    local v = f1:GetAlias();
    assert(v == uniqueName2, 'GetAlias returned an unexpected value.');
    v = f1:GetVisible();
    assert(v == true, 'GetVisible returned an unexpected value.');
    v = f1:GetCanFocus();
    assert(v == false, 'GetCanFocus returned an unexpected value.');
    v = f1:GetLocked();
    assert(v == true, 'GetLocked returned an unexpected value.');
    v = f1:GetLockedZ();
    assert(v == true, 'GetLockedZ returned an unexpected value.');
    v = f1:GetIsDirty();
    assert(v == false, 'GetIsDirty returned an unexpected value.');
    v = f1:GetWindowWidth();
    assert(v == 1920, 'GetWindowWidth returned an unexpected value.');
    v = f1:GetWindowHeight();
    assert(v == 1024, 'GetWindowHeight returned an unexpected value.');
    v = f1:GetFontFile();
    assert(v == '', 'GetFontFile returned an unexpected value.');
    v = f1:GetFontFamily();
    assert(v == 'Arial', 'GetFontFamily returned an unexpected value.');
    v = f1:GetFontHeight();
    assert(v == 12, 'GetFontHeight returned an unexpected value.');
    v = f1:GetCreateFlags();
    assert(v == FontCreateFlags.None, 'GetCreateFlags returned an unexpected value.');
    v = f1:GetDrawFlags();
    assert(v == FontDrawFlags.Outlined, 'GetDrawFlags returned an unexpected value.');
    v = f1:GetBold();
    assert(v == false, 'GetBold returned an unexpected value.');
    v = f1:GetItalic();
    assert(v == false, 'GetItalic returned an unexpected value.');
    v = f1:GetRightJustified();
    assert(v == false, 'GetRightJustified returned an unexpected value.');
    v = f1:GetStrikeThrough();
    assert(v == false, 'GetStrikeThrough returned an unexpected value.');
    v = f1:GetUnderlined();
    assert(v == false, 'GetUnderlined returned an unexpected value.');
    v = f1:GetColor();
    assert(v == 0xFFFF0000, 'GetColor returned an unexpected value.');
    v = f1:GetColorOutline();
    assert(v == 0xFF00FF00, 'GetColorOutline returned an unexpected value.');
    v = f1:GetPadding();
    assert(v == 0.0, 'GetPadding returned an unexpected value.');
    v = f1:GetPositionX();
    assert(v == 2.0, 'GetPositionX returned an unexpected value.');
    v = f1:GetPositionY();
    assert(v == 2.0, 'GetPositionY returned an unexpected value.');
    v = f1:GetAutoResize();
    assert(v == true, 'GetAutoResize returned an unexpected value.');
    v = f1:GetAnchor();
    assert(v == FrameAnchor.TopRight, 'GetAnchor returned an unexpected value.');
    v = f1:GetAnchorParent();
    assert(v == FrameAnchor.BottomLeft, 'GetAnchorParent returned an unexpected value.');
    v = f1:GetText();
    assert(v == 'Hello world!', 'GetText returned an unexpected value.');
    v = f1:GetParent();
    assert(v == nil, 'GetParent returned an unexpected value.');
    v = f1:GetRealPositionX();
    assert(v == 2, 'GetRealPositionX returned an unexpected value.');
    v = f1:GetRealPositionY();
    assert(v == 2, 'GetRealPositionY returned an unexpected value.');

    --[[
    Test the font size..

    Note:   This is a calculated assumption/size. The users system can cause this to not always be exactly the same
            as the expected values. Because of this, we will only warn if they don't match instead of error.
    --]]

    local size = SIZE.new();
    f1:GetTextSize(size);
    assert(size.cx ~= 0 and size.cy ~= 0, 'GetTextSize returned an unexpected value.');

    if (size.cx ~= 81 or size.cy ~= 18) then
        print("\30\81[\30\06SDKTest\30\81] \30\104Warning: \30\106GetTextSize returned an unexpected value; but this is not considered critical.\30\01");
    end

    --[[
    Test the font location..

    Note:   Fonts are rendered as a rect regardless of the characters used. The position is treated as the top-left most point
            the font object. In this test, we moved the font to 2x2, so it should be the first position that is valid.
    --]]

    v = f1:HitTest(0, 0);
    assert(v == false, 'HitTest was expected to fail.');
    v = f1:HitTest(1, 1);
    assert(v == false, 'HitTest was expected to fail.');
    v = f1:HitTest(2, 2);
    assert(v == true, 'HitTest was expected to succeed.');

    --[[
    Primitive Object Testing (Font Background)

    Note:   The below tests are to attempt to call the Get/Set handlers of a fonts background primitive object. Please note 
            the comments next to some of the calls. Calls like SetAlias should never happen manually by a user/developer! 
            This is just for testing.
    --]]

    local b = f1:GetBackground();
    assert(v ~= nil, 'GetBackground returned an unexpected value.');

    b:SetAlias(string.format('notused%s', uniqueName1)); -- Warning: Developers should never call this! (Font backgrounds don't use an alias anyway.)
    b:SetTextureOffsetX(13);
    b:SetTextureOffsetY(37);
    b:SetBorderVisible(true);
    b:SetBorderColor(0xFF0000FF); -- Color: Blue
    b:SetBorderFlags(15);

    local r     = RECT.new();
    r.left      = 1;
    r.top       = 2;
    r.right     = 3;
    r.bottom    = 4;

    b:SetBorderSizes(r);
    b:SetVisible(true);
    b:SetPositionX(1);
    b:SetPositionY(2);
    b:SetCanFocus(false);   -- Not used; the font itself controls its focus ability.
    b:SetLocked(true);      -- Not used; the font itself controls its locked status.
    b:SetLockedZ(true);     -- Not used; the font itself controls its locked z status.
    b:SetScaleX(1);
    b:SetScaleY(1);
    b:SetWidth(123);
    b:SetHeight(123);
    b:SetColor(0xFFFFFFFF); -- Color: White

    -- Allow the font (and its background) to rebuild..
    coroutine.sleepf(2);

    -- Test the primitive values were properly set..
    v = b:GetAlias();
    assert(v == string.format('notused%s', uniqueName1), 'GetAlias returned an unexpected value.');
    v = b:GetTextureOffsetX();
    assert(v == 13, 'GetTextureOffsetX returned an unexpected value.');
    v = b:GetTextureOffsetY();
    assert(v == 37, 'GetTextureOffsetY returned an unexpected value.');
    v = b:GetBorderVisible();
    assert(v == true, 'GetBorderVisible returned an unexpected value.');
    v = b:GetBorderColor();
    assert(v == 0xFF0000FF, 'GetBorderColor returned an unexpected value.');
    v = b:GetBorderFlags();
    assert(v == 15, 'GetBorderFlags returned an unexpected value.');
    v = b:GetBorderSizes();
    assert(v.left == 1, 'GetBorderSizes returned an unexpected value.');
    assert(v.top == 2, 'GetBorderSizes returned an unexpected value.');
    assert(v.right == 3, 'GetBorderSizes returned an unexpected value.');
    assert(v.bottom == 4, 'GetBorderSizes returned an unexpected value.');
    v = b:GetVisible();
    assert(v == true, 'GetVisible returned an unexpected value.');
    v = b:GetPositionX();
    assert(v == 1.0, 'GetPositionX returned an unexpected value.');
    v = b:GetPositionY();
    assert(v == 2.0, 'GetPositionY returned an unexpected value.');
    v = b:GetCanFocus();
    assert(v == false, 'GetCanFocus returned an unexpected value.');
    v = b:GetLocked();
    assert(v == true, 'GetLocked returned an unexpected value.');
    v = b:GetLockedZ();
    assert(v == true, 'GetLockedZ returned an unexpected value.');
    v = b:GetScaleX();
    assert(v == 1, 'GetScaleX returned an unexpected value.');
    v = b:GetScaleY();
    assert(v == 1, 'GetScaleY returned an unexpected value.');
    v = b:GetWidth();
    assert(v == 123, 'GetWidth returned an unexpected value.');
    v = b:GetHeight();
    assert(v == 123, 'GetHeight returned an unexpected value.');
    v = b:GetColor();
    assert(v == 0xFFFFFFFF, 'GetColor returned an unexpected value.');

    -- Cleanup the used font objects..
    cleanup_object(fontManager, uniqueName1);
    cleanup_object(fontManager, uniqueName2);
    coroutine.sleepf(2);

    --[[
    Primitive Manager Testing
    --]]

    -- Test creating a primitive object..
    local p1 = primManager:Create(uniqueName1);
    assert(p1 ~= nil, 'Create returned an unexpected value.');

    -- Test getting a primitive object..
    local p2 = primManager:Get(uniqueName1);
    assert(p2 ~= nil, 'Get returned an unexpected value.');
    assert(p1 == p2, 'Get returned an unexpected value.');

    -- Test deleting a primitive object..
    primManager:Delete(uniqueName1);
    p1 = primManager:Get(uniqueName1);
    assert(p1 == nil, 'Get returned an unexpected value.');

    -- Test setting the focused primitive object..
    p1 = primManager:Create(uniqueName1);
    assert(p1 ~= nil, 'Create returned an unexpected value.');
    primManager:SetFocusedObject('');
    p2 = primManager:GetFocusedObject();
    assert(p2 == nil, 'GetFocusedObject returned an unexpected value.');
    primManager:SetFocusedObject(p1:GetAlias());
    p2 = primManager:GetFocusedObject();
    assert(p2 == p1, 'GetFocusedObject returned an unexpected value.');

    primManager:Delete(uniqueName1);

    --[[
    Primitive Object Testing

    Note:   The below tests are to attempt to call the Get/Set handlers of a primitive object. Please note the
            comments next to some of the calls. Calls like SetAlias should never happen manually by a user/developer! 
            This is just for testing.
    --]]

    p1 = primManager:Create(uniqueName1);
    p1:SetAlias(uniqueName2); -- Warning: Developers should never call this!
    p1:SetTextureOffsetX(13);
    p1:SetTextureOffsetY(37);
    p1:SetBorderVisible(true);
    p1:SetBorderColor(0xFF0000FF); -- Color: Blue
    p1:SetBorderFlags(15);

    r           = RECT.new();
    r.left      = 1;
    r.top       = 2;
    r.right     = 3;
    r.bottom    = 4;

    p1:SetBorderSizes(r);
    p1:SetVisible(true);
    p1:SetPositionX(1);
    p1:SetPositionY(2);
    p1:SetCanFocus(false);
    p1:SetLocked(true);
    p1:SetLockedZ(true);
    p1:SetScaleX(1);
    p1:SetScaleY(1);
    p1:SetWidth(123);
    p1:SetHeight(123);
    p1:SetColor(0xFFFFFFFF); -- Color: White

    -- Allow the primitive to rebuild..
    coroutine.sleepf(2);

    -- Test the primitive values were properly set..
    v = p1:GetAlias();
    assert(v == uniqueName2, 'GetAlias returned an unexpected value.');
    v = p1:GetTextureOffsetX();
    assert(v == 13, 'GetTextureOffsetX returned an unexpected value.');
    v = p1:GetTextureOffsetY();
    assert(v == 37, 'GetTextureOffsetY returned an unexpected value.');
    v = p1:GetBorderVisible();
    assert(v == true, 'GetBorderVisible returned an unexpected value.');
    v = p1:GetBorderColor();
    assert(v == 0xFF0000FF, 'GetBorderColor returned an unexpected value.');
    v = p1:GetBorderFlags();
    assert(v == 15, 'GetBorderFlags returned an unexpected value.');
    v = p1:GetBorderSizes();
    assert(v.left == 1, 'GetBorderSizes returned an unexpected value.');
    assert(v.top == 2, 'GetBorderSizes returned an unexpected value.');
    assert(v.right == 3, 'GetBorderSizes returned an unexpected value.');
    assert(v.bottom == 4, 'GetBorderSizes returned an unexpected value.');
    v = p1:GetVisible();
    assert(v == true, 'GetVisible returned an unexpected value.');
    v = p1:GetPositionX();
    assert(v == 1.0, 'GetPositionX returned an unexpected value.');
    v = p1:GetPositionY();
    assert(v == 2.0, 'GetPositionY returned an unexpected value.');
    v = p1:GetCanFocus();
    assert(v == false, 'GetCanFocus returned an unexpected value.');
    v = p1:GetLocked();
    assert(v == true, 'GetLocked returned an unexpected value.');
    v = p1:GetLockedZ();
    assert(v == true, 'GetLockedZ returned an unexpected value.');
    v = p1:GetScaleX();
    assert(v == 1, 'GetScaleX returned an unexpected value.');
    v = p1:GetScaleY();
    assert(v == 1, 'GetScaleY returned an unexpected value.');
    v = p1:GetWidth();
    assert(v == 123, 'GetWidth returned an unexpected value.');
    v = p1:GetHeight();
    assert(v == 123, 'GetHeight returned an unexpected value.');
    v = p1:GetColor();
    assert(v == 0xFFFFFFFF, 'GetColor returned an unexpected value.');

    --[[
    Test the primitive location..

    Note:   Primitives are rendered as a rect regardless of the settings used. The position is treated as the top-left most point
            the primitive object. In this test, we moved the object to 2x2, so it should be the first position that is valid.
    --]]

    v = p1:HitTest(0, 0);
    assert(v == false, 'HitTest was expected to fail.');
    v = p1:HitTest(1, 1);
    assert(v == false, 'HitTest was expected to fail.');
    v = p1:HitTest(2, 2);
    assert(v == true, 'HitTest was expected to succeed.');

    --[[
    Test setting the primitive texture..

    Note: Ashita.dll has two embedded images inside of it. One is the Moogle icon Ashita uses. We will be using that icon for this test.
    --]]

    v = p1:SetTextureFromResource('Ashita.dll', '1002');
    assert(v == true, 'SetTextureFromResource returned an unexpected value.');

    -- Allow the primitive to rebuild..
    coroutine.sleepf(2);

    v = p1:GetWidth();
    assert(v == 256, 'GetWidth returned an unexpected value.');
    v = p1:GetHeight();
    assert(v == 256, 'GetHeight returned an unexpected value.');

    -- Cleanup the used primitive objects..
    cleanup_object(primManager, uniqueName1);
    cleanup_object(primManager, uniqueName2);

    --[[
    Test manager visibility..
    --]]

    local prev = fontManager:GetVisible();
    fontManager:SetVisible(false);
    local curr = fontManager:GetVisible();
    fontManager:SetVisible(prev);

    assert(curr == false, 'GetVisible returned an unexpected value.');

    prev = primManager:GetVisible();
    primManager:SetVisible(false);
    curr = primManager:GetVisible();
    primManager:SetVisible(prev);

    assert(curr == false, 'GetVisible returned an unexpected value.');
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Validate the manager objects..
    local fontManager = AshitaCore:GetFontManager();
    local primManager = AshitaCore:GetPrimitiveManager();
    assert(fontManager ~= nil, 'GetFontManager returned an unexpected value.');
    assert(primManager ~= nil, 'GetPrimitiveManager returned an unexpected value.');

    -- Cleanup the objects used by the tests..
    cleanup_object(fontManager, string.format('sdktest1%s', test.uniqueSuffix));
    cleanup_object(fontManager, string.format('sdktest2%s', test.uniqueSuffix));
    cleanup_object(primManager, string.format('sdktest1%s', test.uniqueSuffix));
    cleanup_object(primManager, string.format('sdktest2%s', test.uniqueSuffix));
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    FontObject:SetFontFile()

    PrimitiveObject:SetTextureFromFile()
    PrimitiveObject:SetTextureFromMemory()

--]]