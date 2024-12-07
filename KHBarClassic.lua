SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

-- Hide the old health bar
PlayerFrame:Hide()

-- Create the health bar frame
local Health = CreateFrame("StatusBar", "hiuiPlayerHealthBar", UIParent)
Health:SetSize(200, 20)  -- Set size for health bar (adjust as needed)
Health:SetPoint("CENTER", UIParent, "CENTER")  -- Position the health bar relative to UIParent

-- Set health bar texture (Classic uses a valid texture path)
Health:SetStatusBarTexture("Interface\\Addons\\KHBar\\media\\HealthbarMask1")  -- Provide the correct texture path

-- Create the health border texture
local HealthBorder = Health:CreateTexture("hiuiPlayerHealthArt", "ARTWORK")
HealthBorder:SetTexture("Interface\\Addons\\KHBar\\media\\KHPspritez")
HealthBorder:SetTexCoord(0, 1, 0, 1)  -- Use full texture

-- Now that Health is positioned, position the HealthBorder texture relative to Health
HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", -5, 5)  -- Position HealthBorder relative to Health
HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", 5, -5)  -- Add some padding to the border

-- Create the health bar background texture
local HealthBg = Health:CreateTexture("hiuiPlayerHealthBg", "ARTWORK", nil, -1)
HealthBg:SetTexture("Interface\\Addons\\KHBar\\media\\HealthbarMask1")  -- Set your background texture here
HealthBg:SetPoint("TOPLEFT", Health, "TOPLEFT", 0, 0)  -- Position the background texture relative to Health
HealthBg:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", 0, 0)

-- Set health bar properties
Health:SetMinMaxValues(0, 100)  -- Set the min and max health values (adjust as needed)
Health:SetValue(75)  -- Set current health value (adjust as needed)

-- Fix inner element positions (optional, based on your design)
local function fixInnerElementsPos()
    -- Calculate positioning offsets based on the size of the HealthBorder
    local l = 29 / 377 * HealthBorder:GetWidth()
    local t = 14 / 60 * HealthBorder:GetHeight()

    -- Position Health and HealthBg within HealthBorder
    Health:SetPoint("TOPLEFT", HealthBorder, "TOPLEFT")
    Health:SetPoint("BOTTOMRIGHT", HealthBorder, "BOTTOMRIGHT")

    HealthBg:SetPoint("TOPLEFT", HealthBorder, "TOPLEFT")
    HealthBg:SetPoint("BOTTOMRIGHT", HealthBorder, "BOTTOMRIGHT")
end

-- Apply the position adjustments after a small delay
C_Timer.After(0.8, fixInnerElementsPos)

-- Show the health bar and textures
Health:Show()
HealthBorder:Show()
HealthBg:Show()
