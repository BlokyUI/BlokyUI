local function UpdateBar()
  if InCombatLockdown() then return end
  PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:Hide()
  PlayerFrame.PlayerFrameContainer:Hide()
  PlayerFrame.healthbar.HealthBarMask:Hide()
  PlayerLevelText:SetAlpha(0)
  PlayerLevelText:Hide()

  -- hide combat glow
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:SetAlpha(0)
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture.Show = function() end

  -- remove health changes appearing on the portrait
  PlayerFrame:UnregisterEvent('UNIT_COMBAT');

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
  PlayerFrame.healthbar:SetStatusBarTexture(BUI.statusbarTexture)

  local _, classFileName = UnitClass(PlayerFrame.unit)
  local r, g, b = GetClassColor(classFileName)
  PlayerFrame.healthbar:SetStatusBarColor(r, g, b)
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.PlayerFrameHealthBarAnimatedLoss:SetAlpha(0)
  PlayerFrame.healthbar.LeftText:SetPoint("RIGHT", PlayerFrame.healthbar, "RIGHT", -8, 0);
  PlayerFrame.healthbar.LeftText:SetJustifyH("RIGHT")
  PlayerFrame.healthbar.LeftText:SetFont(BUI.font, 10, "OUTLINE")
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.TotalAbsorbBar:SetTexture(BUI.statusbarTexture)
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.OverAbsorbGlow:SetAlpha(0)

  if PlayerFrameBackground == nil then
    CreateFrame("StatusBar", "PlayerFrameBackground", PlayerFrame.PlayerFrameContent.PlayerFrameContentMain)
  end

  local borderSize = 2
  -- -- Set the size and position of the frame
  PlayerFrameBackground:SetPoint("TOPLEFT", PlayerFrame.healthbar, "TOPLEFT", -2, 2.5)
  PlayerFrameBackground:SetWidth(width + borderSize * 2 + .5)
  PlayerFrameBackground:SetHeight(totalFrameHeight + 4.5)
  PlayerFrameBackground:SetStatusBarTexture(BUI.statusbarTexture)
  PlayerFrameBackground:SetStatusBarColor(0, 0, 0, 1)
  PlayerFrameBackground:SetFrameLevel(0)

  PlayerFrame.healthbar.RightText:SetPoint("LEFT", PlayerFrame.healthbar, "LEFT", 8, 0);
  PlayerFrame.healthbar.RightText:SetJustifyH("CENTER")
  PlayerFrame.healthbar.RightText:SetFont(BUI.font, 10, "OUTLINE")

  -- manabar styling
  PlayerFrame.manabar:SetSize(width, manabarHeight)
  PlayerFrame.manabar.ManaBarMask:Hide()
  PlayerFrame.manabar:ClearAllPoints()
  PlayerFrame.manabar:SetPoint("TOPLEFT", PlayerFrame.healthbar, "BOTTOMLEFT", 0, 0)
  PlayerFrame.manabar:SetStatusBarTexture(BUI.statusbarTexture)
  PlayerFrame.manabar.RightText:SetFont(BUI.font, 8, "OUTLINE")
  PlayerFrame.manabar.RightText:SetJustifyH("RIGHT")
  PlayerFrame.manabar.RightText:SetPoint("RIGHT", PlayerFrame.manabar, "RIGHT", 0, -0.49);
  PlayerFrame.manabar.RightText:SetShadowOffset(0, 0)
  -- local power = PlayerFrame.manabar.powerToken

  -- the mana bar texture resets sometimes, so this is needed to make sure the texture stays the same
  hooksecurefunc("UnitFrameManaBar_UpdateType", function(manabar)
    if manabar.unit ~= "player" then return end
    manabar:SetStatusBarTexture(BUI.statusbarTexture)
    local color = PowerBarColor[PlayerFrame.manabar.powerToken]
    PlayerFrame.manabar:SetStatusBarColor(color.r, color.g, color.b)
  end)

  -- disable the mana bar animations
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:Hide()
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.FeedbackFrame:Hide()
  PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.FullPowerFrame:Hide()

  -- move the name into the healthbar frame

  PlayerFrame.name:ClearAllPoints()
  PlayerFrame.name:SetPoint("LEFT", PlayerFrame.healthbar, "LEFT", 8, 0);
  PlayerFrame.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
  PlayerFrame.name:SetShadowOffset(0, 0)
  PlayerFrame.name:SetFont(BUI.font, 10, "OUTLINE")

  -- PlayerFrame.manabar:Show()
  -- PlayerFrame.manabar:SetStatusBarTexture(BUI.statusbarTexture)
  -- PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.texture:SetTexture(BUI.statusbarTexture)
  -- local powerColor = GetPowerBarColor(PlayerFrame.manabar.powerType)
  -- if PlayerFrame.manabar.powerType == 0 then
  --   PlayerFrame.manabar:SetStatusBarColor(0, 0.5, 1)
  -- else
  --   PlayerFrame.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
  -- end
end

hooksecurefunc("PlayerFrame_Update", function()
  UpdateBar()
end)
hooksecurefunc("PlayerFrame_UpdateArt", function()
  UpdateBar()
end)
