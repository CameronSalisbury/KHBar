
----------------------------------------------------------------------------------------------

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI


--------------------------------------------------------------------------------------------------
--[[
local UIConfig = CreateFrame("Frame", ShowUF, UIParent)

local KHBar = UIConfig:CreateTexture()
KHBar:SetTexture("Interface\\Addons\\KHBar\\media\\KHPspritez")
KHBar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT")
KHBar:SetSize(512,286)
UIConfig.texture = KHBar
]]

local Health = CreateFrame("StatusBar", "hiuiPlayerHealthBar", self)
--[[        Player Health Border (Art)
            Art frame keeping the health bar in check.
--]]
local HealthBorder = Health:CreateTexture("hiuiPlayerHealthArt", "ARTWORK", nil, 1)
HealthBorder:SetTexture(defaults.player.textures.border)
HealthBorder:SetTexCoord(0, 377/512, 0, 60/64)
HealthBorder:SetPoint("TOPLEFT", self, "TOPLEFT")
HealthBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")


--[[        Player Health Status Bar
            Dark bar that moves when you take damage.
--]]
local mask = Health:CreateMaskTexture()
mask:SetTexture("Interface\\Addons\\KHBar\\media\\HealthbarMasked")
mask:SetPoint("TOPLEFT", Health, "TOPLEFT", 0, 0)
mask:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", 0, 0)
 
health:GetStatusBarTexture():AddMaskTexture(mask)

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

--[[
local function CreateBar(name, previous) -- Create StatusBar with a text overlay
	local f = CreateFrame("StatusBar", "Fizzle"..name, UIParent)
	f:SetSize(300, 30)
	if not previous then
		f:SetPoint("BOTTOMRIGHT", -100, 200)
	else
		f:SetPoint("TOP", previous, "BOTTOM")
	end
	f:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	f.Text = f:CreateFontString()
	f.Text:SetFontObject(GameFontNormal)
	f.Text:SetPoint("CENTER")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("CENTER")
	return f
end

local function UpdateHealth(self, unit) -- Update the health bar
	local health = UnitHealth(unit)
	self:SetValue(health)
	self.Text:SetText(FormatLargeNumber(health) .. "/" .. FormatLargeNumber(self.healthMax))
end
local function UpdatePower(self, unit) -- Update the power bar
	local power = UnitPower(unit)
	self:SetValue(power)
	self.Text:SetText(FormatLargeNumber(power) .. "/" .. FormatLargeNumber(self.powerMax))
end
local function UpdateHealthMax(self, unit) -- Update min./max. health values
	self.healthMax = UnitHealthMax(unit)
	self:SetMinMaxValues(0, self.healthMax)
	UpdateHealth(self, unit)
end
local function UpdatePowerMax(self, unit) -- Update min./max. power values
	self.powerMax = UnitPowerMax(unit)
	self:SetMinMaxValues(0, self.powerMax)
	UpdatePower(self, unit)
end
local HealthBar = CreateBar("PlayerHealth") -- Create the health bar
HealthBar:SetStatusBarColor(0, 1, 0) -- make it green
local PowerBar = CreateBar("PlayerPower", HealthBar) -- Create the power bar (set to anchor below Health)
PowerBar:SetStatusBarColor(0, 0, 1) -- make it blue
HealthBar:SetScript("OnEvent", function(self, event, ...)
	local unit = ... -- For events starting with UNIT_ the first parameter is the unit
	if unit ~= "player" then  -- We"re only updating the player status ATM
		return -- So ignore any other unit
	end
	if event == "UNIT_HEALTH_FREQUENT" then -- Fired when health changes
		UpdateHealth(self, unit)
	elseif event == "UNIT_POWER_FREQUENT" then -- Fired when power changes
		UpdatePower(PowerBar, unit)
	elseif event == "UNIT_MAXHEALTH" then -- Fired when max. health changes
		UpdateHealthMax(self, unit)
	elseif event == "UNIT_MAXPOWER" then -- Fired when max. power changes
		UpdatePowerMax(PowerBar, unit)
	end
end)


UpdateHealthMax(HealthBar, "player") -- initialise the health bar for Player health
UpdatePowerMax(PowerBar, "player") -- initialise the power bar for Player power
HealthBar:RegisterEvent("UNIT_HEALTH") -- register the events to be used (UNIT_HEALTH_FREQUENT only exists in old versions these days
HealthBar:RegisterEvent("UNIT_POWER_FREQUENT") -- Health bar is handling events for both bars
HealthBar:RegisterEvent("UNIT_MAXHEALTH")
HealthBar:RegisterEvent("UNIT_MAXPOWER")

]]

