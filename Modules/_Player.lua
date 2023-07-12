local Player = BlokyUI:NewModule("Player")

function Player:OnEnable()
  local function UpdateBar()
    PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:Hide()
    PlayerFrame.PlayerFrameContainer:Hide()
    PlayerFrame.healthbar.HealthBarMask:Hide()
    PlayerLevelText:SetAlpha(0)
    PlayerLevelText:Hide()

    -- hide combat glow
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:SetAlpha(0)
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture.Show = function() end

    -- hide damage text on portrait
    PlayerFrame.portrait:Hide()

    -- offset the frame so it matches the edit mode
    PlayerFrame.PlayerFrameContent:SetPoint("TOPLEFT", -61, 20)

    local width = 200
    local healthBarHeight = 38
    local manabarHeight = 10
    local totalFrameHeight = healthBarHeight + manabarHeight
    if not InCombatLockdown() then
      PlayerFrame:SetSize(width + 45, totalFrameHeight * 2 - 7)
    end

    -- health bar styling
    PlayerFrame.healthbar:SetSize(width, healthBarHeight)
    PlayerFrame.healthbar.HealthBarMask:SetSize(width, healthBarHeight)
    PlayerFrame.healthbar:SetStatusBarTexture(BlokyUI.statusbarTexture)

    local _, classFileName = UnitClass(PlayerFrame.unit)
    local r, g, b = GetClassColor(classFileName)
    PlayerFrame.healthbar:SetStatusBarColor(r, g, b)
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.PlayerFrameHealthBarAnimatedLoss:SetAlpha(0)
    PlayerFrame.healthbar.LeftText:SetPoint("RIGHT", PlayerFrame.healthbar, "RIGHT", -8, 0);
    PlayerFrame.healthbar.LeftText:SetJustifyH("RIGHT")
    PlayerFrame.healthbar.LeftText:SetFont(BlokyUI.font, 10, "OUTLINE")
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.TotalAbsorbBar:SetTexture(BlokyUI.statusbarTexture)
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.OverAbsorbGlow:SetAlpha(0)

    if PlayerFrameBackground == nil then
      CreateFrame("StatusBar", "PlayerFrameBackground", PlayerFrame.PlayerFrameContent.PlayerFrameContentMain)
    end

    local borderSize = 2
    -- -- Set the size and position of the frame
    PlayerFrameBackground:SetPoint("TOPLEFT", PlayerFrame.healthbar, "TOPLEFT", -2, 2.5)
    PlayerFrameBackground:SetWidth(width + borderSize * 2 + .5)
    PlayerFrameBackground:SetHeight(totalFrameHeight + 4.5)
    PlayerFrameBackground:SetStatusBarTexture(BlokyUI.statusbarTexture)
    PlayerFrameBackground:SetStatusBarColor(0, 0, 0, 1)
    PlayerFrameBackground:SetFrameLevel(0)

    PlayerFrame.healthbar.RightText:SetPoint("LEFT", PlayerFrame.healthbar, "LEFT", 8, 0);
    PlayerFrame.healthbar.RightText:SetJustifyH("CENTER")
    PlayerFrame.healthbar.RightText:SetFont(BlokyUI.font, 10, "OUTLINE")

    -- when character panel is open
    PlayerFrame.healthbar.TextString:ClearAllPoints();
    PlayerFrame.healthbar.TextString:SetPoint("RIGHT", PlayerFrame.healthbar, "RIGHT", -4, 0);
    PlayerFrame.healthbar.TextString:SetJustifyH("RIGHT")
    PlayerFrame.manabar.TextString:ClearAllPoints();
    PlayerFrame.manabar.TextString:SetPoint("RIGHT", PlayerFrame.manabar, "RIGHT", 0, -0.49);
    PlayerFrame.manabar.TextString:SetJustifyH("RIGHT")
    PlayerFrame.manabar.TextString:SetFont(BlokyUI.font, 8, "OUTLINE")

    -- manabar styling
    PlayerFrame.manabar:SetSize(width, manabarHeight)
    PlayerFrame.manabar.ManaBarMask:Hide()
    PlayerFrame.manabar:ClearAllPoints()
    PlayerFrame.manabar:SetPoint("TOPLEFT", PlayerFrame.healthbar, "BOTTOMLEFT", 0, 0)
    PlayerFrame.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    if PlayerFrame.manabar.RightText then
      PlayerFrame.manabar.RightText:SetFont(BlokyUI.font, 8, "OUTLINE")
      PlayerFrame.manabar.RightText:SetJustifyH("RIGHT")
      PlayerFrame.manabar.RightText:SetPoint("RIGHT", PlayerFrame.manabar, "RIGHT", 0, -0.49);
      PlayerFrame.manabar.RightText:SetShadowOffset(0, 0)
    end
    if PlayerFrame.manabar.LeftText then
      PlayerFrame.manabar.LeftText:SetFont(BlokyUI.font, 8, "OUTLINE")
      PlayerFrame.manabar.LeftText:SetJustifyH("LEFT")
      PlayerFrame.manabar.LeftText:SetPoint("LEFT", PlayerFrame.manabar, "LEFT", 1, -0.49);
      PlayerFrame.manabar.LeftText:SetShadowOffset(0, 0)
    end

    local powerColor = GetPowerBarColor(PlayerFrame.manabar.powerType)
    if PlayerFrame.manabar.powerType == 0 then
      PlayerFrame.manabar:SetStatusBarColor(0, 0.5, 1)
    else
      PlayerFrame.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
    end


    -- disable the mana bar animations
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:Hide()
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.FeedbackFrame:Hide()
    PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.FullPowerFrame:Hide()

    -- move the name into the healthbar frame
    PlayerFrame.name:ClearAllPoints()
    PlayerFrame.name:SetPoint("LEFT", PlayerFrame.healthbar, "LEFT", 8, 0);
    PlayerFrame.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
    PlayerFrame.name:SetShadowOffset(0, 0)
    PlayerFrame.name:SetFont(BlokyUI.font, 10, "OUTLINE")

    -- style alternate mana frame
    -- PlayerFrameAlternateManaBarBorder:Hide()
    -- PlayerFrameAlternateManaBarRightBorder:Hide()
    -- PlayerFrameAlternateManaBarLeftBorder:Hide()

    PlayerFrameBottomManagedFramesContainer:ClearAllPoints()
    PlayerFrameBottomManagedFramesContainer:SetPoint("BOTTOMRIGHT", PlayerFrameBackground, "BOTTOMRIGHT", 25.5, -34)

    AlternatePowerBar.PowerBarMask:Hide()

    AlternatePowerBar:ClearAllPoints()
    AlternatePowerBar:SetWidth(100)
    AlternatePowerBar:SetPoint("BOTTOMRIGHT", PlayerFrameBackground, "BOTTOMRIGHT", -2, -30)
    AlternatePowerBar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    AlternatePowerBar:SetHeight(20)

    -- local powerColor = GetPowerBarColor(PlayerFrame.manabar.powerType)
    -- if PlayerFrame.manabar.powerType == 0 then
      AlternatePowerBar:SetStatusBarColor(0, 0.5, 1)
    -- else
    --   AlternatePowerBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
    -- end

    AlternatePowerBar.LeftText:SetFont(BlokyUI.font, 8, "OUTLINE")
    AlternatePowerBar.LeftText:ClearAllPoints();
    AlternatePowerBar.LeftText:SetJustifyH("LEFT")
    AlternatePowerBar.LeftText:SetPoint("LEFT", AlternatePowerBar, "LEFT", 4, 0);

    AlternatePowerBar.RightText:SetFont(BlokyUI.font, 8, "OUTLINE")
    AlternatePowerBar.RightText:ClearAllPoints();
    AlternatePowerBar.RightText:SetJustifyH("RIGHT")
    AlternatePowerBar.RightText:SetPoint("RIGHT", AlternatePowerBar, "RIGHT", -4, 0);

    if AlternateManaBarFrameBackground == nil then
      CreateFrame("StatusBar", "AlternateManaBarFrameBackground", AlternatePowerBar)
    end

    AlternateManaBarFrameBackground:SetPoint("TOPLEFT", AlternatePowerBar, "TOPLEFT", -2.5, 2.5)
    AlternateManaBarFrameBackground:SetWidth(AlternatePowerBar:GetWidth() + 5)
    AlternateManaBarFrameBackground:SetHeight(AlternatePowerBar:GetHeight() + 5)
    AlternateManaBarFrameBackground:SetStatusBarTexture(BlokyUI.statusbarTexture)
    AlternateManaBarFrameBackground:SetStatusBarColor(0, 0, 0, 1)
    AlternateManaBarFrameBackground:SetFrameLevel(0)
  end

  PlayerHitIndicator:SetText(nil)
  PlayerHitIndicator.SetText = function() end



  -- the mana bar texture resets sometimes, so this is needed to make sure the texture stays the same
  hooksecurefunc("UnitFrameManaBar_UpdateType", function(manabar)
    if manabar.unit ~= "player" then return end
    local powerColor = GetPowerBarColor(PlayerFrame.manabar.powerType)
    if PlayerFrame.manabar.powerType == 0 then
      PlayerFrame.manabar:SetStatusBarColor(0, 0.5, 1)
    else
      PlayerFrame.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
    end
  end)

  PlayerFrame:HookScript("OnEvent", function(self, event)
    if event == "PORTRAITS_UPDATED" and not InCombatLockdown() then
      PlayerFrame.manabar:Show()
      PlayerFrame.manabar:SetStatusBarTexture(BlokyUI.statusbarTexture)
      PlayerFrame.manabar.SetStatusBarTexture = function() end
    end
  end)

  hooksecurefunc("PlayerFrame_Update", function()
    UpdateBar()
  end)
  hooksecurefunc("PlayerFrame_UpdateArt", function()
    UpdateBar()
  end)
end
