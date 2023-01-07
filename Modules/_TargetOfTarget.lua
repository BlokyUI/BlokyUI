local function handleToTFrame(self, type)
  self.FrameTexture:SetAlpha(0)
  self.FrameTexture:Hide()
  self.portrait:Hide()

  local width = 84
  local healthBarHeight = 20
  local manabarHeight = 4
  local totalFrameHeight = healthBarHeight + manabarHeight

  self.healthbar:SetWidth(width)
  self.healthbar:SetHeight(healthBarHeight)

  self.healthbar:SetStatusBarTexture(BUI.statusbarTexture)
  local r, g, b = BUI.getUnitColor(self.unit)
  self.healthbar:SetStatusBarColor(r, g, b)
  self.healthbar:ClearAllPoints()
  self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)

  self.HealthBar.HealthBarMask:Hide()
  self.ManaBar.ManaBarMask:Hide()


  local backgroundKey = type .. "ToTFrameBackground"

  if _G[backgroundKey] == nil then
    CreateFrame("StatusBar", backgroundKey, self)
  end

  local borderSize = 2
  -- -- Set the size and position of the frame
  _G[backgroundKey]:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2.5)
  _G[backgroundKey]:SetWidth(width + borderSize * 2)
  _G[backgroundKey]:SetHeight(totalFrameHeight + 5)
  _G[backgroundKey]:SetStatusBarTexture(BUI.statusbarTexture)
  _G[backgroundKey]:SetStatusBarColor(0, 0, 0, 1)
  _G[backgroundKey]:SetFrameLevel(0)

  self.manabar:SetSize(width, manabarHeight)
  self.manabar:ClearAllPoints()
  self.manabar:SetPoint("TOPLEFT", self.healthbar, "BOTTOMLEFT", 0, 0)
  self.manabar:SetStatusBarTexture(BUI.statusbarTexture)

  local powerColor = GetPowerBarColor(self.manabar.powerType)
  if self.manabar.powerType == 0 then
    self.manabar:SetStatusBarColor(0, 0.5, 1)
  else
    self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
  end
  self.healthbar:SetFrameLevel(1)


  self.name:ClearAllPoints()
  self.name:SetPoint("LEFT", self.healthbar, "LEFT", 4, 0.5);
  self.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
  self.name:SetShadowOffset(0, 0)
  self.name:SetFont(BUI.font, 8, "OUTLINE")
end

hooksecurefunc(TargetFrameToT, "Update", function(self)
  handleToTFrame(self, "Target")
end)

hooksecurefunc(FocusFrameToT, "Update", function(self)
  handleToTFrame(self, "Focus")
end)
