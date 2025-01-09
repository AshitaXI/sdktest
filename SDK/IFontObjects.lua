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
local test = T{
    unique_suffix = '',
};

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
        coroutine.sleepf(1);
    end
end

--[[
* Initializes the test, preparing it for usage.
--]]
function test.init(cnt)
    -- Create a randomized seed to help generate unique entry names..
    math.randomseed(os.time() + cnt);
    _ = math.random(0, 100000);
    _ = math.random(0, 100000);
    local rnd = math.random(0, 100000);
    math.randomseed(os.time() + rnd + cnt);
    rnd = math.random(100000, 900000);

    -- Create a unique suffix for the objects to be used with these tests..
    test.unique_suffix = ('_%d_%d_%d'):fmt(addon.instance.current_frame, rnd, cnt);
end

--[[
* Invoked after the test has completed; allowing it to cleanup any generated resources.
--]]
function test.cleanup()
    -- Validate the manager objects..
    local fmgr = AshitaCore:GetFontManager();
    local pmgr = AshitaCore:GetPrimitiveManager();
    assert(fmgr ~= nil, 'GetFontManager returned an unexpected value.');
    assert(pmgr ~= nil, 'GetPrimitiveManager returned an unexpected value.');

    -- Cleanup the objects used by the tests..
    cleanup_object(fmgr, ('sdktest1%s'):fmt(test.unique_suffix));
    cleanup_object(fmgr, ('sdktest2%s'):fmt(test.unique_suffix));
    cleanup_object(pmgr, ('sdktest1%s'):fmt(test.unique_suffix));
    cleanup_object(pmgr, ('sdktest2%s'):fmt(test.unique_suffix));
end

--[[
* Executes the test.
--]]
function test.exec()
    -- Validate the manager objects..
    local fmgr = AshitaCore:GetFontManager();
    local pmgr = AshitaCore:GetPrimitiveManager();
    assert(fmgr ~= nil, 'GetFontManager returned an unexpected value.');
    assert(pmgr ~= nil, 'GetPrimitiveManager returned an unexpected value.');

    -- Prepare two unique object names to use with the tests..
    local unique_name1 = ('sdktest1%s'):fmt(test.unique_suffix);
    local unique_name2 = ('sdktest2%s'):fmt(test.unique_suffix);

    --[[
    FontManager Testing
    --]]

    -- Test creating a font object..
    local font1 = fmgr:Create(unique_name1);
    assert(font1 ~= nil, 'Create returned an unexpected value.');

    -- Test getting a font object..
    local font2 = fmgr:Get(unique_name1);
    assert(font2 ~= nil, 'Get returned an unexpected value.');
    assert(font2 == font1, 'Get returned an unexpected value.');

    -- Test deleting a font object..
    fmgr:Delete(unique_name1);
    font1 = fmgr:Get(unique_name1);
    assert(font1 == nil, 'Get returned an unexpected value. (Delete)');

    -- Test the focused font object..
    font1 = fmgr:Create(unique_name1);
    assert(font1 ~= nil, 'Create returned an unexpected value.');
    fmgr:SetFocusedObject('');
    font2 = fmgr:GetFocusedObject();
    assert(font2 == nil, 'GetFocusedObject returned an unexpected value.');
    fmgr:SetFocusedObject(font1:GetAlias());
    font2 = fmgr:GetFocusedObject();
    assert(font2 ~= nil, 'GetFocusedObject returned an unexpected value.');
    assert(font2 == font1, 'GetFocusedObject returned an unexpected value.');
    fmgr:Delete(unique_name1);

    --[[
    FontObject Testing

    Note:   The below tests are to ensure the property settings of FontObjects are honored. Please be sure to read the comments regarding
            some of these property handlers as they are not all intended to be called by developers!
    --]]

    -- Create and adjust the properties of a font object..
    font1 = fmgr:Create(unique_name1);
    assert(font1 ~= nil, 'Create returned an unexpected value.');
    font1:SetAlias(unique_name2);               -- WARN: You should NEVER call this!
    font1:SetVisible(true);
    font1:SetCanFocus(false);
    font1:SetLocked(true);
    font1:SetLockedZ(true);
    font1:SetIsDirty(true);                     -- This will automatically reset internally on the next frame when the font is rebuilt.
    font1:SetWindowWidth(1920);
    font1:SetWindowHeight(1024);
    font1:SetFontFamily('Arial');
    font1:SetFontHeight(12);
    font1:SetCreateFlags(FontCreateFlags.Bold); -- Note: Setting to bold here but manually calling SetBold(false) to test if it is honored.
    font1:SetDrawFlags(FontDrawFlags.Outlined);
    font1:SetBold(false);                       -- Note: Overriding the 'SetCreateFlags' call above.
    font1:SetItalic(false);
    font1:SetRightJustified(false);
    font1:SetStrikeThrough(false);
    font1:SetUnderlined(false);
    font1:SetColor(0xFFFF0000);
    font1:SetColorOutline(0xFF00FF00);
    font1:SetPadding(0);
    font1:SetPositionX(2);
    font1:SetPositionY(2);
    font1:SetAutoResize(true);
    font1:SetAnchor(FrameAnchor.TopRight);
    font1:SetAnchorParent(FrameAnchor.BottomLeft);
    font1:SetText('Hello world!');
    font1:SetParent(nil);

    -- Yield to allow the font to rebuild based on our changes..
    coroutine.sleepf(2);

    -- Test if the properties of the font object match what is expected..
    assert(font1:GetAlias() == unique_name2, 'GetAlias returned an unexpected value.');
    assert(font1:GetVisible() == true, 'GetVisible returned an unexpected value.');
    assert(font1:GetCanFocus() == false, 'GetCanFocus returned an unexpected value.');
    assert(font1:GetLocked() == true, 'GetLocked returned an unexpected value.');
    assert(font1:GetLockedZ() == true, 'GetLockedZ returned an unexpected value.');
    assert(font1:GetIsDirty() == false, 'GetIsDirty returned an unexpected value.');
    assert(font1:GetWindowWidth() == 1920, 'GetWindowWidth returned an unexpected value.');
    assert(font1:GetWindowHeight() == 1024, 'GetWindowHeight returned an unexpected value.');
    assert(font1:GetFontFile() == '', 'GetFontFile returned an unexpected value.');
    assert(font1:GetFontFamily() == 'Arial', 'GetFontFamily returned an unexpected value.');
    assert(font1:GetFontHeight() == 12, 'GetFontHeight returned an unexpected value.');
    assert(font1:GetCreateFlags() == FontCreateFlags.None, 'GetCreateFlags returned an unexpected value.');
    assert(font1:GetDrawFlags() == FontDrawFlags.Outlined, 'GetDrawFlags returned an unexpected value.');
    assert(font1:GetBold() == false, 'GetBold returned an unexpected value.');
    assert(font1:GetItalic() == false, 'GetItalic returned an unexpected value.');
    assert(font1:GetRightJustified() == false, 'GetRightJustified returned an unexpected value.');
    assert(font1:GetStrikeThrough() == false, 'GetStrikeThrough returned an unexpected value.');
    assert(font1:GetUnderlined() == false, 'GetUnderlined returned an unexpected value.');
    assert(font1:GetColor() == 0xFFFF0000, 'GetColor returned an unexpected value.');
    assert(font1:GetColorOutline() == 0xFF00FF00, 'GetColorOutline returned an unexpected value.');
    assert(font1:GetPadding() == 0.0, 'GetPadding returned an unexpected value.');
    assert(font1:GetPositionX() == 2, 'GetPositionX returned an unexpected value.');
    assert(font1:GetPositionY() == 2, 'GetPositionY returned an unexpected value.');
    assert(font1:GetAutoResize() == true, 'GetAutoResize returned an unexpected value.');
    assert(font1:GetAnchor() == FrameAnchor.TopRight, 'GetAnchor returned an unexpected value.');
    assert(font1:GetAnchorParent() == FrameAnchor.BottomLeft, 'GetAnchorParent returned an unexpected value.');
    assert(font1:GetText() == 'Hello world!', 'GetText returned an unexpected value.');
    assert(font1:GetParent() == nil, 'GetParent returned an unexpected value.');
    assert(font1:GetBackground() ~= nil, 'GetBackground returned an unexpected value.');
    assert(font1:GetRealPositionX() == 2, 'GetRealPositionX returned an unexpected value.');
    assert(font1:GetRealPositionY() == 2, 'GetRealPositionY returned an unexpected value.');

    --[[
    Note:   The following test is to check the text size calculations. The users system settings (ie. DPI scaling) can
            cause this to not return the expected values. Due to this, instead of failing the test, we will simply warn
            the user if the sizes are unexpected.
    --]]

    local size = SIZE.new();
    font1:GetTextSize(size);
    assert(size.cx ~= 0 and size.cy ~= 0, 'GetTextSize returned an unexpected value.');

    -- Test the font size for known good values based on 100% DPI..
    if (size.cx ~= 81 or size.cy ~= 18) then
        print(chat.header('SDKTest'):append(chat.warn('Warning: ')):append(chat.message('GetTextSize returned an unexpected value; however this is not considered critical.')));
    end

    --[[
    Note:   The following test is to check for valid font hit testing. Fonts are rendered as a rect regardless of the
            characters used. The position is treated as the top-left most point of the font object. The current font
            being tested has been set to 2 x 2 for its x/y position, so the first valid hit should be there.
    --]]

    assert(font1:HitTest(0, 0) == false, 'HitTest returned an unexpected value. (HitTest was expected to fail.)');
    assert(font1:HitTest(1, 1) == false, 'HitTest returned an unexpected value. (HitTest was expected to fail.)');
    assert(font1:HitTest(2, 2) == true, 'HitTest returned an unexpected value. (HitTest was expected to succeed.)');

    --[[
    FontObject Background Testing (PrimitiveObject)

    Note:   The below tests are to ensure the property settings of the FontObjects' background primitive are honored.
            Please be sure to read the comments regarding some of these property handlers as they are not all intended
            to be called by developers!
    --]]

    font1:GetBackground():SetAlias(('notused%s'):fmt(unique_name1)); -- WARN: You should NEVER call this!
    font1:GetBackground():SetTextureOffsetX(13);
    font1:GetBackground():SetTextureOffsetY(37);
    font1:GetBackground():SetBorderVisible(true);
    font1:GetBackground():SetBorderColor(0xFF0000FF);
    font1:GetBackground():SetBorderFlags(15);

    local r = RECT.new();
    r.left  = 1;
    r.top   = 2;
    r.right = 3;
    r.bottom= 4;

    font1:GetBackground():SetBorderSizes(r);
    font1:GetBackground():SetVisible(true);
    font1:GetBackground():SetPositionX(1);
    font1:GetBackground():SetPositionY(2);
    font1:GetBackground():SetCanFocus(false);
    font1:GetBackground():SetLocked(true);
    font1:GetBackground():SetLockedZ(true);
    font1:GetBackground():SetScaleX(1);
    font1:GetBackground():SetScaleY(1);
    font1:GetBackground():SetWidth(123);
    font1:GetBackground():SetHeight(123);
    font1:GetBackground():SetDrawFlags(0);
    font1:GetBackground():SetColor(0xFFFFFFFF);

    -- Yield to allow the font to rebuild based on our changes..
    coroutine.sleepf(2);

    -- Test if the properties of the font object background match what is expected..
    assert(font1:GetBackground():GetAlias() == ('notused%s'):fmt(unique_name1), 'GetAlias returned an unexpected value.');
    assert(font1:GetBackground():GetTextureOffsetX() == 13, 'GetTextureOffsetX returned an unexpected value.');
    assert(font1:GetBackground():GetTextureOffsetY() == 37, 'GetTextureOffsetY returned an unexpected value.');
    assert(font1:GetBackground():GetBorderVisible() == true, 'GetBorderVisible returned an unexpected value.');
    assert(font1:GetBackground():GetBorderColor() == 0xFF0000FF, 'GetBorderColor returned an unexpected value.');
    assert(font1:GetBackground():GetBorderFlags() == 15, 'GetBorderFlags returned an unexpected value.');
    assert(font1:GetBackground():GetBorderSizes() ~= nil, 'GetBorderSizes returned an unexpected value.');
    r = font1:GetBackground():GetBorderSizes();
    assert(r.left == 1, 'GetBorderFlags returned an unexpected value.');
    assert(r.top == 2, 'GetBorderFlags returned an unexpected value.');
    assert(r.right == 3, 'GetBorderFlags returned an unexpected value.');
    assert(r.bottom == 4, 'GetBorderFlags returned an unexpected value.');
    assert(font1:GetBackground():GetVisible() == true, 'GetVisible returned an unexpected value.');
    assert(font1:GetBackground():GetPositionX() == 1, 'GetPositionX returned an unexpected value.');
    assert(font1:GetBackground():GetPositionY() == 2, 'GetPositionY returned an unexpected value.');
    assert(font1:GetBackground():GetCanFocus() == false, 'GetCanFocus returned an unexpected value.');
    assert(font1:GetBackground():GetLocked() == true, 'GetLocked returned an unexpected value.');
    assert(font1:GetBackground():GetLockedZ() == true, 'GetLockedZ returned an unexpected value.');
    assert(font1:GetBackground():GetScaleX() == 1, 'GetScaleX returned an unexpected value.');
    assert(font1:GetBackground():GetScaleY() == 1, 'GetScaleY returned an unexpected value.');
    assert(font1:GetBackground():GetWidth() == 123, 'GetWidth returned an unexpected value.');
    assert(font1:GetBackground():GetHeight() == 123, 'GetHeight returned an unexpected value.');
    assert(font1:GetBackground():GetDrawFlags() == 0, 'GetDrawFlags returned an unexpected value.');
    assert(font1:GetBackground():GetColor() == 0xFFFFFFFF, 'GetColor returned an unexpected value.');

    cleanup_object(fmgr, unique_name1);
    cleanup_object(fmgr, unique_name2);

    coroutine.sleepf(2);

    --[[
    PrimitiveManager Testing
    --]]

    -- Test creating a primitive object..
    local prim1 = pmgr:Create(unique_name1);
    assert(prim1 ~= nil, 'Create returned an unexpected value.');

    -- Test getting a primitive object..
    local prim2 = pmgr:Get(unique_name1);
    assert(prim2 ~= nil, 'Get returned an unexpected value.');
    assert(prim2 == prim1, 'Get returned an unexpected value.');

    -- Test deleting a primitive object..
    pmgr:Delete(unique_name1);
    prim1 = pmgr:Get(unique_name1);
    assert(prim1 == nil, 'Get returned an unexpected value. (Delete)');

    -- Test the focused primitive object..
    prim1 = pmgr:Create(unique_name1);
    assert(prim1 ~= nil, 'Create returned an unexpected value.');
    pmgr:SetFocusedObject('');
    prim2 = pmgr:GetFocusedObject();
    assert(prim2 == nil, 'GetFocusedObject returned an unexpected value.');
    pmgr:SetFocusedObject(prim1:GetAlias());
    prim2 = pmgr:GetFocusedObject();
    assert(prim2 ~= nil, 'GetFocusedObject returned an unexpected value.');
    assert(prim2 == prim1, 'GetFocusedObject returned an unexpected value.');
    pmgr:Delete(unique_name1);

    --[[
    PrimitiveObject Testing

    Note:   The below tests are to ensure the property settings of PrimitiveObjects are honored. Please be sure to read the comments regarding
            some of these property handlers as they are not all intended to be called by developers!
    --]]

    -- Create and adjust the properties of a font object..
    prim1 = pmgr:Create(unique_name1);
    assert(prim1 ~= nil, 'Create returned an unexpected value.');
    prim1:SetAlias(unique_name2); -- WARN: You should NEVER call this!
    prim1:SetTextureOffsetX(13);
    prim1:SetTextureOffsetY(37);
    prim1:SetBorderVisible(true);
    prim1:SetBorderColor(0xFF0000FF);
    prim1:SetBorderFlags(15);

    r       = RECT.new();
    r.left  = 1;
    r.top   = 2;
    r.right = 3;
    r.bottom= 4;

    prim1:SetBorderSizes(r);
    prim1:SetVisible(true);
    prim1:SetPositionX(1);
    prim1:SetPositionY(2);
    prim1:SetCanFocus(false);
    prim1:SetLocked(true);
    prim1:SetLockedZ(true);
    prim1:SetScaleX(1);
    prim1:SetScaleY(1);
    prim1:SetWidth(123);
    prim1:SetHeight(123);
    prim1:SetDrawFlags(0);
    prim1:SetColor(0xFFFFFFFF);

    -- Yield to allow the primitive to rebuild based on our changes..
    coroutine.sleepf(2);

    -- Test if the properties of the primitive object match what is expected..
    assert(prim1:GetAlias() == unique_name2, 'GetAlias returned an unexpected value.');
    assert(prim1:GetTextureOffsetX() == 13, 'GetTextureOffsetX returned an unexpected value.');
    assert(prim1:GetTextureOffsetY() == 37, 'GetTextureOffsetY returned an unexpected value.');
    assert(prim1:GetBorderVisible() == true, 'GetBorderVisible returned an unexpected value.');
    assert(prim1:GetBorderColor() == 0xFF0000FF, 'GetBorderColor returned an unexpected value.');
    assert(prim1:GetBorderFlags() == 15, 'GetBorderFlags returned an unexpected value.');
    assert(prim1:GetBorderSizes() ~= nil, 'GetBorderSizes returned an unexpected value.');
    r = prim1:GetBorderSizes();
    assert(r.left == 1, 'GetBorderFlags returned an unexpected value.');
    assert(r.top == 2, 'GetBorderFlags returned an unexpected value.');
    assert(r.right == 3, 'GetBorderFlags returned an unexpected value.');
    assert(r.bottom == 4, 'GetBorderFlags returned an unexpected value.');
    assert(prim1:GetVisible() == true, 'GetVisible returned an unexpected value.');
    assert(prim1:GetPositionX() == 1, 'GetPositionX returned an unexpected value.');
    assert(prim1:GetPositionY() == 2, 'GetPositionY returned an unexpected value.');
    assert(prim1:GetCanFocus() == false, 'GetCanFocus returned an unexpected value.');
    assert(prim1:GetLocked() == true, 'GetLocked returned an unexpected value.');
    assert(prim1:GetLockedZ() == true, 'GetLockedZ returned an unexpected value.');
    assert(prim1:GetScaleX() == 1, 'GetScaleX returned an unexpected value.');
    assert(prim1:GetScaleY() == 1, 'GetScaleY returned an unexpected value.');
    assert(prim1:GetWidth() == 123, 'GetWidth returned an unexpected value.');
    assert(prim1:GetHeight() == 123, 'GetHeight returned an unexpected value.');
    assert(prim1:GetDrawFlags() == 0, 'GetDrawFlags returned an unexpected value.');
    assert(prim1:GetColor() == 0xFFFFFFFF, 'GetColor returned an unexpected value.');

    --[[
    Note:   The following test is to check for valid primitive hit testing. Primitives are rendered as a rect regardless
            of the settings used. The position is treated as the top-left most point of the primitive object. The current
            primitive being tested has been set to 2 x 2 for its x/y position, so the first valid hit should be there.
    --]]

    assert(prim1:HitTest(0, 0) == false, 'HitTest returned an unexpected value. (HitTest was expected to fail.)');
    assert(prim1:HitTest(1, 1) == false, 'HitTest returned an unexpected value. (HitTest was expected to fail.)');
    assert(prim1:HitTest(2, 2) == true, 'HitTest returned an unexpected value. (HitTest was expected to succeed.)');

    --[[
    Note:   The following tests are used to ensure the primitive can be set to an image texture.
    --]]

    -- Test setting the primitive texture from a loaded module..
    assert(prim1:SetTextureFromResource('Ashita.dll', '1002') == true, 'SetTextureFromResource returned an unexpected value.');
    coroutine.sleepf(2);
    assert(prim1:GetWidth() == 256, 'GetWidth returned an unexpected value.');
    assert(prim1:GetHeight() == 256, 'GetHeight returned an unexpected value.');

    -- Test setting hte primitive texture from the Ashita resource cache..
    assert(prim1:SetTextureFromResourceCache('icons') == true, 'SetTextureFromResourceCache returned an unexpected value.');
    coroutine.sleepf(2);
    assert(prim1:GetWidth() == 512, 'GetWidth returned an unexpected value.');
    assert(prim1:GetHeight() == 512, 'GetHeight returned an unexpected value.');

    -- Cleanup..
    cleanup_object(pmgr, unique_name1);
    cleanup_object(pmgr, unique_name2);

    coroutine.sleepf(2);

    -- Test the manager visibility functions..
    local fprev = fmgr:GetVisible();
    local pprev = pmgr:GetVisible();

    fmgr:SetVisible(false);
    pmgr:SetVisible(false);

    coroutine.sleepf(2);

    assert(fmgr:GetVisible() == false, 'GetVisible returned an unexpected value. (Font)');
    assert(pmgr:GetVisible() == false, 'GetVisible returned an unexpected value. (Primitive)');

    fmgr:SetVisible(true);
    pmgr:SetVisible(true);

    coroutine.sleepf(2);

    assert(fmgr:GetVisible() == true, 'GetVisible returned an unexpected value. (Font)');
    assert(pmgr:GetVisible() == true, 'GetVisible returned an unexpected value. (Primitive)');

    fmgr:SetVisible(fprev);
    pmgr:SetVisible(pprev);
end

-- Return the test module table..
return test;

--[[
Untested Functions:

    PrimitiveObject:Render()
    PrimitiveObject:SetTextureFromFile()
    PrimitiveObject:SetTextureFromMemory()
    PrimitiveObject:SetTextureFromTexture()

    FontObject:Render()
    FontObject:GetFontFile()
    FontObject:SetFontFile()
--]]