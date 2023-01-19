local Pet = BlokyUI:NewModule("Pet", "AceHook-3.0")

function Pet:OnEnable()
  self:SecureHookScript(PetFrame, "OnShow", "handlePetFrame")
  self:SecureHookScript(PetFrame, "OnEvent", "handlePetFrame")
end

function Pet:handlePetFrame(self, event)
  if event == "UNIT_PET" or event == "UNIT_EXITED_VEHICLE" or event == "PET_UI_UPDATE" or event == nil then
    if not InCombatLockdown() then
      self:ClearAllPoints()
      self:SetPoint("BOTTOMLEFT", PlayerFrame, "BOTTOMLEFT", 24, -29)
      self:SetSize(100, 40)
      self.SetPoint = function() end
      self.SetSize = function() end
      self.ClearAllPoints = function() end
    end


    self.portrait:Hide()
    PetFrameTexture:Hide()

    local width = 100
    local healthBarHeight = 20
    local manabarHeight = 4
    local totalFrameHeight = healthBarHeight + manabarHeight

    self.healthbar:SetWidth(width)
    self.healthbar:SetHeight(healthBarHeight)

    PetFrameHealthBarMask:Hide()
    PetFrameManaBarMask:Hide()
    self.healthbar.RightText:SetAlpha(0)
    self.healthbar.RightText:Hide()

    self.healthbar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    self.healthbar:GetStatusBarTexture():SetDrawLayer("BORDER")
    self.healthbar:SetStatusBarColor(0.05, 0.5, 0.05)
    self.healthbar:ClearAllPoints()
    self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)

    self.healthbar.LeftText:ClearAllPoints()
    self.healthbar.LeftText:SetPoint("RIGHT", self.healthbar, "RIGHT", -3, -0.5);
    self.healthbar.LeftText:SetJustifyH("RIGHT")
    self.healthbar.LeftText:SetFont(BlokyUI.font, 8, "OUTLINE")

    if PetFrameBackground == nil then
      CreateFrame("StatusBar", "PetFrameBackground", self)
    end

    local borderSize = 2
    -- -- Set the size and position of the frame
    PetFrameBackground:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2.5)
    PetFrameBackground:SetWidth(width + borderSize * 2)
    PetFrameBackground:SetHeight(totalFrameHeight + 5)
    PetFrameBackground:SetStatusBarTexture(BlokyUI.statusbarTexture)
    PetFrameBackground:SetStatusBarColor(0, 0, 0, 1)
    PetFrameBackground:SetFrameLevel(0)


    self.manabar:SetSize(width, manabarHeight)
    self.manabar:ClearAllPoints()
    self.manabar:SetPoint("TOPLEFT", self.healthbar, "BOTTOMLEFT", 0, 0)
    self.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)

    local powerColor = GetPowerBarColor(self.manabar.powerType)
    if self.manabar.powerType == 0 then
      self.manabar:SetStatusBarColor(0, 0.5, 1)
    else
      self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
    end

    self.manabar.RightText:SetFont(BlokyUI.font, 8, "OUTLINE")
    self.manabar.RightText:SetJustifyH("RIGHT")
    self.manabar.RightText:ClearAllPoints()
    self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", 0, -0.49);
    self.manabar.RightText:SetShadowOffset(0, 0)
    self.manabar.RightText:SetAlpha(0)

    -- move the name into the healthbar frame
    self.name:ClearAllPoints()
    self.name:SetPoint("LEFT", self.healthbar, "LEFT", 4, 0.5);
    self.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
    self.name:SetShadowOffset(0, 0)
    self.name:SetFont(BlokyUI.font, 8, "OUTLINE")

    PetFrameFlash:ClearAllPoints()

    PetAttackModeTexture:Hide()
    PetAttackModeTexture:SetAlpha(0)
    PetAttackModeTexture:ClearAllPoints()
  end

  PetHitIndicator:SetText(nil)
  PetHitIndicator.SetText = function() end
end
