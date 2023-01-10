local Focus = BlokyUI:NewModule("Focus")

function Focus:OnEnable()
  hooksecurefunc(FocusFrame, "Update", function(self)
    self.name:ClearAllPoints()
    self.name:SetFont(BlokyUI.font, 10, "OUTLINE")
    self.name:SetJustifyH("CENTER")
    self.name:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0)
    self.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
    self.name:SetShadowOffset(0, 0)

    self.healthbar:SetFrameLevel(1)
    self.TargetFrameContent:SetFrameLevel(1)

    self.TargetFrameContent.TargetFrameContentContextual:Hide()
    self.TargetFrameContent.TargetFrameContentMain.LevelText:Hide()
    self.TargetFrameContent.TargetFrameContentMain.LevelText:SetAlpha(0)
    self.TargetFrameContainer:Hide()
    self.healthbar.HealthBarMask:Hide()

    -- hide damage text on portrait
    self.portrait:Hide()

    self.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()

    local width = 200
    local healthBarHeight = 38
    local manabarHeight = 10
    local totalFrameHeight = healthBarHeight + manabarHeight
    if not InCombatLockdown() then
      self:SetSize(width + 48, totalFrameHeight * 2 - 5)
    end

    self.healthbar:ClearAllPoints();
    self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 24, -21.5)

    --   -- health bar styling
    -- self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    -- self.TargetFrameContent:ClearAllPoints()
    -- self.TargetFrameContent:SetPoint("TOPLEFT", self, "TOPLEFT", 40, 0)
    self.healthbar:SetSize(width, healthBarHeight)
    self.healthbar.HealthBarMask:SetSize(width, healthBarHeight)
    self.healthbar:SetStatusBarTexture(BlokyUI.statusbarTexture)

    local r, g, b = BlokyUI.getUnitColor(self.unit)
    self.healthbar:SetStatusBarColor(r, g, b)

    self.healthbar.LeftText:SetPoint("RIGHT", self.healthbar, "RIGHT", -8, 0);
    self.healthbar.LeftText:SetJustifyH("RIGHT")
    self.healthbar.LeftText:SetFont(BlokyUI.font, 10, "OUTLINE")
    self.TargetFrameContent.TargetFrameContentMain.HealthBar.TotalAbsorbBar:SetTexture(BlokyUI.statusbarTexture)
    self.TargetFrameContent.TargetFrameContentMain.HealthBar.OverAbsorbGlow:SetAlpha(0)

    if FocusFrameBackground == nil then
      CreateFrame("StatusBar", "FocusFrameBackground",
        self.TargetFrameContent.TargetFrameContentMain)
    end

    local borderSize = 2
    -- -- Set the size and position of the frame
    FocusFrameBackground:SetPoint("TOPLEFT", self.healthbar, "TOPLEFT", -2, 2.5)
    FocusFrameBackground:SetWidth(width + borderSize * 2 + .5)
    FocusFrameBackground:SetHeight(totalFrameHeight + 5)
    FocusFrameBackground:SetStatusBarTexture(BlokyUI.statusbarTexture)
    FocusFrameBackground:SetStatusBarColor(0, 0, 0, 1)
    FocusFrameBackground:SetFrameLevel(0)

    self.healthbar.RightText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
    self.healthbar.RightText:SetJustifyH("LEFT")
    self.healthbar.RightText:SetFont(BlokyUI.font, 10, "OUTLINE")

    if self.healthbar.DeadText ~= nil then
      self.healthbar.DeadText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
    end

    -- manabar styling
    self.manabar:SetSize(width, manabarHeight)
    self.manabar.ManaBarMask:Hide()
    self.manabar:ClearAllPoints()
    self.manabar:SetPoint("TOPLEFT", self.healthbar, "BOTTOMLEFT", 0, 0)
    self.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    self.manabar.LeftText:SetFont(BlokyUI.font, 8, "OUTLINE")
    self.manabar.LeftText:SetJustifyH("LEFT")
    self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 1, -0.49);
    self.manabar.LeftText:SetShadowOffset(0, 0)
    self.manabar.RightText:SetFont(BlokyUI.font, 8, "OUTLINE")
    self.manabar.RightText:SetJustifyH("RIGHT")
    self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", 0, -0.49);
    self.manabar.RightText:SetShadowOffset(0, 0)
    -- local power = self.manabar.powerToken

    --   -- the mana bar texture resets sometimes, so this is needed to make sure the texture stays the same
    --   hooksecurefunc("UnitFrameManaBar_UpdateType", function(manabar)
    --     if manabar.unit ~= "player" then return end
    --     manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    --     local color = PowerBarColor[self.manabar.powerToken]
    --     self.manabar:SetStatusBarColor(color.r, color.g, color.b)
    --   end)

    --   -- disable the mana bar animations
    -- self.TargetFrameContent.TargetFrameContentMain.ManaBar:Hide()
    -- self.TargetFrameContent.TargetFrameContentMain.ManaBar.FeedbackFrame:Hide()
    -- self.TargetFrameContent.TargetFrameContentMain.ManaBar.FullPowerFrame:Hide()

    self.manabar:Show()
    self.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    self.TargetFrameContent.TargetFrameContentMain.ManaBar.texture:SetTexture(BlokyUI.statusbarTexture)
    local powerColor = GetPowerBarColor(self.manabar.powerType)
    if self.manabar.powerType == 0 then
      self.manabar:SetStatusBarColor(0, 0.5, 1)
    else
      self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
    end
  end)
end
