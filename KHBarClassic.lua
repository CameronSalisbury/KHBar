
----------------------------------------------------------------------------------------------

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

--------------------------------------------------------------------------------------------------
--[[
--This will work on its own. just displays the art i made	
local UIConfig = CreateFrame("Frame", ShowUF, UIParent)

local KHBar = UIConfig:CreateTexture()
KHBar:SetTexture("Interface\\Addons\\KHBar\\media\\KHPspritez")
KHBar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT")
KHBar:SetSize(512,286)
UIConfig.texture = KHBar
--]]

-- hide the old health bar
PlayerFrame:Hide()



local Health = CreateFrame("StatusBar", "hiuiPlayerHealthBar", self)
--[[        Player Health Border (Art)
            Art frame keeping the health bar in check.
--]]

local HealthBorder = Health:CreateTexture("hiuiPlayerHealthArt", "ARTWORK", nil, 1)
HealthBorder:SetTexture("Interface\\Addons\\KHBar\\media\\KHPspritez")
HealthBorder:SetTexCoord(0, 512/512, 0, 286/286)
--HealthBorder:SetPoint("TOPLEFT", self, "TOPLEFT")	-- Commented out because im confused on how this texcord command works
HealthBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")


--[[        Player Health Status Bar
            Dark bar that moves when you take damage.
--]]
local mask = Health:CreateMaskTexture()
mask:SetTexture("Interface\\Addons\\KHBar\\media\\HealthbarMask1", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
mask:SetPoint("TOPLEFT", Health, "TOPLEFT", 0, 0)
mask:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", 0, 0)

Health:GetStatusBarTexture():AddMaskTexture(mask)

-----------------------------------------
Health:SetStatusBarTexture(defaults.player.textures.healthBarStretch)
-- The border art on +1 and the bg on -1, so don't need this.
--Health:GetStatusBarTexture():SetDrawLayer("ARTWORK", 0)

Health:SetPoint("TOPLEFT", HealthBorder, "TOPLEFT", 0, 0)
Health:SetPoint("BOTTOMRIGHT", HealthBorder, "BOTTOMRIGHT", 0, 0)
Health:SetReverseFill(defaults.player.reverseFill);
Health.frequentUpdates = defaults.player.frequent



--[[        Player Health Bar Background
            Bright background that's revealed as damage is taken.
--]]
local HealthBg = Health:CreateTexture("hiuiPlayerHealthBg", "ARTWORK", nil, -1)
HealthBg:SetTexture(defaults.player.textures.healthBgStretch)

HealthBg:SetPoint("TOPLEFT", HealthBorder, "TOPLEFT", 0, 0)
HealthBg:SetPoint("BOTTOMRIGHT", HealthBorder, "BOTTOMRIGHT", 0, 0)


self.Health = Health


do -- bad practice, code abuse, programming under the influence
    local function fixInnerElementsPos()
        local l = 29/377 * hiuiPlayerHealthArt:GetWidth()
        local t = 14/60 * hiuiPlayerHealthArt:GetHeight()

        hiuiPlayerHealthBar:SetPoint("TOPLEFT", "hiuiPlayerHealthArt", "TOPLEFT", l, -t)
        hiuiPlayerHealthBar:SetPoint("BOTTOMRIGHT", "hiuiPlayerHealthArt", "BOTTOMRIGHT", -l, t)

        hiuiPlayerHealthBg:SetPoint("TOPLEFT", "hiuiPlayerHealthArt", "TOPLEFT", l, -t)
        hiuiPlayerHealthBg:SetPoint("BOTTOMRIGHT", "hiuiPlayerHealthArt", "BOTTOMRIGHT", -l, t)
    end

    C_Timer.After(0.8, fixInnerElementsPos)
end
