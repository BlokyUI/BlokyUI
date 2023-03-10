local TargetOfTarget = BlokyUI:NewModule("TargetOfTarget", "AceHook-3.0")

local healthTextureId
local manaTextureId
function TargetOfTarget:OnEnable()
  local function handleToTFrame(self, type)
    if not self:IsShown() then
      return
    end

    local width = 84
    local healthBarHeight = 20
    local manabarHeight = 4
    local totalFrameHeight = healthBarHeight + manabarHeight

    self.FrameTexture:SetAlpha(0)
    self.FrameTexture:Hide()
    self.portrait:Hide()
    self.healthbar:SetSize(width, healthBarHeight)

    if self.healthbar:GetStatusBarTexture():GetTexture() ~= healthTextureId then
      self.healthbar:SetStatusBarTexture(BlokyUI.statusbarTexture)
      healthTextureId = self.healthbar:GetStatusBarTexture():GetTexture()
      self.healthbar:ClearAllPoints()
      self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
      self.healthbar:SetFrameLevel(1)
      if self.HealthBar.HealthBarMask:IsShown() then
        self.HealthBar.HealthBarMask:Hide()
      end
      if self.ManaBar.ManaBarMask:IsShown() then
        self.ManaBar.ManaBarMask:Hide()
      end

      local backgroundKey = type .. "ToTFrameBackground"

      if _G[backgroundKey] == nil then
        CreateFrame("StatusBar", backgroundKey, self)
      end

      local borderSize = 2
      -- -- Set the size and position of the frame
      _G[backgroundKey]:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2.5)
      _G[backgroundKey]:SetWidth(width + borderSize * 2)
      _G[backgroundKey]:SetHeight(totalFrameHeight + 5)
      _G[backgroundKey]:SetStatusBarTexture(BlokyUI.statusbarTexture)
      _G[backgroundKey]:SetStatusBarColor(0, 0, 0, 1)
      _G[backgroundKey]:SetFrameLevel(0)
    end

    if self.manabar:GetStatusBarTexture():GetTexture() ~= manaTextureId then
      self.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
      manaTextureId = self.manabar:GetStatusBarTexture():GetTexture()

      self.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
      local r, g, b = BlokyUI.getUnitColor(self.unit)
      self.healthbar:SetStatusBarColor(r, g, b)

      self.manabar:SetSize(width, manabarHeight)
      self.manabar:ClearAllPoints()
      self.manabar:SetPoint("TOPLEFT", self.healthbar, "BOTTOMLEFT", 0, 0)

      local powerColor = GetPowerBarColor(self.manabar.powerType)
      if self.manabar.powerType == 0 then
        self.manabar:SetStatusBarColor(0, 0.5, 1)
      else
        self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
      end
    end

    self.name:ClearAllPoints()
    self.name:SetPoint("LEFT", self.healthbar, "LEFT", 4, 0.5);
    self.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
    self.name:SetShadowOffset(0, 0)
    self.name:SetFont(BlokyUI.font, 8, "OUTLINE")
  end

  hooksecurefunc(TargetFrameToT, "Update", function(self, event)
    handleToTFrame(self, "Target")
  end)

  hooksecurefunc(FocusFrameToT, "Update", function(self)
    handleToTFrame(self, "Focus")
  end)
end
